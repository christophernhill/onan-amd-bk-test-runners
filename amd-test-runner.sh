#/bin/bash -l
/opt/rocm/bin/rocm-smi
module use /home/software.x86_64/modulefiles; module load singularity
/bin/rm -f matin-julia-roc4.2.sif
singularity pull matin-julia-roc4.2.sif docker://christophernhill/matin-julia:roc4.2
