# cmcc-reactions-env

Environment container to support the `cmcc-reactions` repository

To install on Grace, run

```commandline
module load WebProxy
username="$(whoami)"
export SINGULARITY_CACHEDIR="/scratch/user/$username/.singularity/cache"
singularity pull docker://ghcr.io/tabor-research-group/cmcc-reactions-env:latest
```