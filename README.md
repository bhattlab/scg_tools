# scg_tools

Useful utilities and some collected knowledge for using the Stanford SCG cluster.

## Utilities
ssub: submit jobs  
inter: launch interactive sessions  
check: check the status of your jobs
cost: your charges over the past day, week, month and year
top_users: the hall of fame

## Costs  
https://drive.google.com/file/d/1KGMNjtvN9BPkmpw7vVjCKbekTIE70E0M/view

## Storage
These graphs are made with graphite, which is accessible from the Stanford private network at https://graphite.scg.stanford.edu. Navigating there directly instead of using the links below will show an interface used to build these plots.

Individual footprints  
http://graphite.scg.stanford.edu/S/J

Collective footprint  
http://graphite.scg.stanford.edu/S/L

## Notes

### Compute usage

labstats: display compute usage by you and other members of your account.  Presently high by a factor of 2 due to some hyperthreading accounting issue.

The charges you accrue by running jobs on the cluster is a function of (elapsed walltime) * (allocated cores). Memory is not considered in determining cost. If you allocate eight cores, your job will cost eight times as much as a job with a single core allocated.  This is true regardless of whether your job is actually using all the cores!  It is therefore important to use your cpu allocation efficiently.  

