#!/usr/bin/python
from pyfasta import Fasta
import sys, os

def main():
    """
    select contigs from FASTA file that do not have "reads=1" on their header
    """
    if len(sys.argv) == 2:
        prefix = sys.argv[1]
    else:
        print "Usage: python get_nonsingleton_unitigs.py <canu_unassembled.fasta>; select contigs from FASTA file that do not have reads=1 on their header; creates <canu_unassembled_unitigs.fasta> file and runs n50 script"
        return 0
    
    count = 0 
    fas = Fasta(prefix)
    ofa = open(prefix[:-6]+'_unitigs.fasta','w')
    for x in sorted(fas.keys()): # process all the contigs one by one
        if "reads=1" in x:
            continue
        #print 'Selecting',x
        ofa.write('>'+x+'\n')
        ofa.write(fas[x][:]+'\n') # entire contig
        count += 1
    print 'Selected', count,'contigs with at least 2 reads'
    ofa.close()
    os.system("/home/stelo/bin/n50 -f "+prefix[:-6]+"_unitigs.fasta")
    os.system("rm -f *.flat *.gdx")
 
if __name__ == '__main__':
    main()
