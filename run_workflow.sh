# ----------- Snakemake workflow for running the analysis

# Modify this variable to change the number of cores used by snakemake
cores=4

# Message to the user
echo
echo " ----------- Reprohackathon 2023 : groupe 8 -----------"
echo
echo "Snakemake AND Apptainer should be installed before running this script"
echo "The default number of cores is $cores, but can be changed in the script"
echo
echo " ------------------------------------------------------"
echo

# Run the workflow
snakemake --cores $cores -r -p --use-singularity