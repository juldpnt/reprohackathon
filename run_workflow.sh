# ----------- Snakemake workflow for running the analysis

# Modify this variable to change the number of cores used by snakemake
cores=$(grep 'threads:' config.yaml | awk '{print $2}')
# snakefile="workflow/Snakefile_${1:-paper}"
snakefile="workflow/Snakefile_${1:-without_TrimGalore}"

# Check if the second argument is -clear
if [ "${2:-}" = "-clear" ]
then
    rm -rf results
    rm -rf tmp
fi

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
snakemake -s $snakefile --cores $cores -r -p --use-singularity