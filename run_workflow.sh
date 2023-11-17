# ----------- Snakemake workflow for running the analysis

# Modify this variable to change the number of cores used by snakemake
cores=$(grep 'threads:' config.yaml | awk '{print $2}')

# Message to the user
echo
echo " ----------- Reprohackathon 2023 : groupe 8 -----------"
echo
echo "Snakemake AND Apptainer should be installed before running this script"
echo "The default number of cores is $cores, but can be changed in the config.yaml file"
echo
echo " ------------------------------------------------------"
echo

# Run the workflow
snakemake --cores $cores -r -p --use-singularity