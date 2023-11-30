# ----------- Snakemake workflow for running the analysis

# Modify the config.yaml file to change the following parameters:
cores=$(grep 'threads:' config.yaml | awk '{print $2}')
version=$(grep 'version:' config.yaml | awk '{print $2}')
with_trimgalore=$(grep 'with_trimgalore:' config.yaml | awk '{print $2}')

# Add arguments to the command line
for arg in "$@"
do
    if [ "$arg" = "-clear" ]
    then
        rm -rf results
        rm -rf tmp
        break
    fi
done

# Message to the user

echo
echo " ----------- Reprohackathon 2023 : groupe 8 -----------"
echo
echo "Snakemake AND Apptainer should be installed before running this script"
echo "The default number of cores is $cores, but can be changed in the config.yaml file"
echo "The default Snakefile is $snakefile, but can be changed by passing either 'latest' or 'paper' as an argument"
echo "To clear the results and tmp folders, pass '-clear' as a second argument"
echo
echo
echo " ------------------------------------------------------"
echo

# Run the workflow
snakemake --cores $cores -r -p --use-singularity