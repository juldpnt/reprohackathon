# ----------- Snakemake workflow for running the analysis

# Default values
cores=$(grep 'threads:' config.yaml | awk '{print $2}')
version=$(grep 'version:' config.yaml | awk '{print $2}')
with_trimgalore=$(grep 'with_trimming:' config.yaml | awk '{print $2}')

# Handle command-line arguments
while getopts v:t:c:h flag
do
    case "${flag}" in
        v) version=${OPTARG};;
        t) with_trimgalore=${OPTARG};;
        c) cores=${OPTARG};;
        h) echo "Usage: $0 [-v version] [-t with_trimgalore] [-c cores]"
           echo " -v: Set the version in the config.yaml file (latest or paper)"
           echo " -t: Set whether trimgalore is used in the config.yaml file (true or false)"
           echo " -c: Set the number of cores to use for the workflow (integer)"
           echo " -h: Display this help message"
           exit 0;;
    esac
done

# Update config.yaml with new values
sed -i "s/^version: .*/version: $version/" config.yaml
sed -i "s/^with_trimming: .*/with_trimming: $with_trimgalore/" config.yaml
sed -i "s/^threads: .*/threads: $cores/" config.yaml

# Message to the user
echo
echo " ----------- Reprohackathon 2023 : groupe 8 -----------"
echo
echo "Snakemake AND Apptainer should be installed before running this script"
echo "The number of cores is $cores"
echo "The Snakefile version is $version"
echo "Is Trimming applied ? ${with_trimgalore}"
echo
echo "To change these values, pass '-v <version>', '-t <trimming>', '-c <cores>' as arguments"
echo
echo
echo " ------------------------------------------------------"
echo

# Run the workflow
snakemake --cores $cores -r -p --use-singularity