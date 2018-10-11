# scg_tools

Useful utilities and some collected knowledge for using the Stanford SCG cluster.

## Utilities
*ssub*: submit jobs  
*inter*: launch interactive sessions  
*check*: check the status of your jobs  
*cost*: your charges over the past day, week, month and year  
*top_users*: the hall of fame.  Top users in terms of cpu-minutes over the past day.  

## Costs  
https://drive.google.com/file/d/1KGMNjtvN9BPkmpw7vVjCKbekTIE70E0M/view

## Storage
These graphs are made with graphite, which is accessible from the Stanford private network at https://graphite.scg.stanford.edu. Navigating there directly instead of using the links below will show an interface used to build these plots.

Individual footprints  
http://graphite.scg.stanford.edu/S/N

Collective footprint  
http://graphite.scg.stanford.edu/S/V

## Notes

### Compute usage

*labstats*: display compute usage by you and other members of your account.  Presently high by a factor of 2 due to some hyperthreading accounting issue.

The charges you accrue by running jobs on the cluster is a function of (elapsed walltime) * (allocated cores). Memory is not considered in determining cost. If you allocate eight cores, your job will cost eight times as much as a job with a single core allocated.  This is true regardless of whether your job is actually using all the cores!  It is therefore important to use your cpu allocation efficiently.  

## Intro

### The cluster

A compute cluster consists of one or more login nodes and many worker nodes.  In order to use a cluster, you establish a connection from your computer (e.g. `ssh johndoe@login.scg.stanford.edu`) through which you interact with a login node.  From there, you can see the cluster's filesystem and submit jobs for execution by worker nodes.  This can be done by the `ssub` and `inter` wrappers in the scg_tools repository, for submitted and interactive jobs, respectively.  The tools themselves will explain the options available when invoked with `-h`.  Anything more computationally taxing than filesystem navigation and the like should not be done on the login node.

### Doing stuff

There is an ongoing effort in the lab to codify analytical processes in snakemake workflows.  [Snakemake](https://snakemake.readthedocs.io/en/stable/index.html) is a python tool which automates workflow management.  These workflows can be found in the github bhattlab organization.  Snakemake can interpret a collection of rules, each with defined input and output, and link them together to obtain some final output (e.g. a barplot) from some initial input (e.g. raw read data).  Snakemake can also use the cluster, submitting the tasks associated with individual rules for execution on worker nodes.  This is achieved by following the instructions in the [slurm](https://www.github.com/bhattlab/slurm) repository.
