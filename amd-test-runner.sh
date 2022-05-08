#/bin/bash -l
/opt/rocm/bin/rocm-smi
module use /home/software.x86_64/modulefiles; module load singularity
/bin/rm -f matin-julia-roc4.2.sif
singularity pull matin-julia-roc4.2.sif docker://christophernhill/matin-julia:roc4.2
/bin/rm -fr .julia
export JULIA_DEPOT_PATH=`pwd`/.julia
export TEST_GROUP=quick_amd
export RDIR=`pwd`
export JULIA_NUM_THREADS=1
cat > myscript.jl <<EOFA
using InteractiveUtils
versioninfo(verbose=true)
using Pkg
Pkg.instantiate()
Pkg.build()
Pkg.precompile()
Pkg.status()
Pkg.test()
EOFA
singularity run --bind `pwd`:`pwd` matin-julia-roc4.2.sif <<!
cd ${RDIR}
export JULIA_DEPOT_PATH=${JULIA_DEPOT_PATH}
export TEST_GROUP=${TEST_GROUP}
julia --project=. myscript.jl
!
