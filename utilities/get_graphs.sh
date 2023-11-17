# Run this script to get the graphs of the workflow

# This should be run from the root of the repository

snakemake --dag | dot -Tpng > jobgraph.png
snakemake --rulegraph | dot -Tpng > rulegraph.png
mv jobgraph.png resources
mv rulegraph.png resources