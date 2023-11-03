cd ../
cd workflow/
snakemake --dag | dot -Tpng > jobgraph.png
snakemake --rulegraph | dot -Tpng > rulegraph.png
mv jobgraph.png ../resources
mv rulegraph.png ../resources