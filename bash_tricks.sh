# put these useful commands in your ~/.basrc or ~/.bash_aliases
# and add your own tricks with a quick explanation!

# copy current working directory to clipboard. Requires xclip and therefore X forwarding to work
alias cpd='echo -en `pwd`/ | xclip -selection clipboard'

# set an alias for conda envs you use all the time
alias py='source activate py36'

# cat a file with columns spaced out so they line up like a spreadsheet
alias catcol="column -t -s $'\t'"

# transpose a tsv file on the command line
transpose_tsv() { 
awk ' BEGIN { FS=OFS="\t" }
{
    for (rowNr=1;rowNr<=NF;rowNr++) {
        cell[rowNr,NR] = $rowNr
    }
    maxRows = (NF > maxRows ? NF : maxRows)
    maxCols = NR
}
END {
    for (rowNr=1;rowNr<=maxRows;rowNr++) {
        for (colNr=1;colNr<=maxCols;colNr++) {
            printf "%s%s", cell[rowNr,colNr], (colNr < maxCols ? OFS : ORS)
        }
    }
}' $1;}


#sequence file stuff
#=========
#pull read sequences from a fastq
cat blar.fastq | paste - - - - | cut -f2

#what are the largest contigs in an assembly?
samtools faidx sequence.fa
sort -k2,2gr sequence.fa.fai | head

#uniquefy the sequence identifiers in a fasta by appending _2, _3 etc to repeated id's
cat sequences.fa | awk '(/^>/ && s[$0]++){{$0=$0\"_\"s[$0]}}1;' > uniquefied.fa

#for several fasta files, submit a job to the cluster to count homopolymers of length 5
ls fasta_dir/*.fasta | xargs -n 1 -I foo ssub -n count_homopolymers "cat foo | grep -E '(.)\1{4}' -o | wc -l > foo.count"
#=========



### fix X forwarding within Tmux
# -- Improved X11 forwarding through GNU Screen (or tmux).
# If not in screen or tmux, update the DISPLAY cache.
# If we are, update the value of DISPLAY to be that in the cache.
function update-x11-forwarding
{
    if [ -z "$STY" -a -z "$TMUX" ]; then
        echo $DISPLAY > ~/.display.txt
    else
        export DISPLAY=`cat ~/.display.txt`
    fi
}

# This is run before every command.
preexec() {
    # Don't cause a preexec for PROMPT_COMMAND.
    # Beware!  This fails if PROMPT_COMMAND is a string containing more than one command.
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return 

    update-x11-forwarding

    # Debugging.
    #echo DISPLAY = $DISPLAY, display.txt = `cat ~/.display.txt`, STY = $STY, TMUX = $TMUX  
}
trap 'preexec' DEBUG
###