#!/usr/bin/python
import sys
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages

def main():
    """
     produces a file called all_coverages.pdf which contains the plots of all unitigs coverages
     as produced by the SMRT pipeline (RS_Resequencing.1 with default params, max divergence 30%,
     minimum anchor size 12)
    """
    if len(sys.argv) == 2:
        f1 = sys.argv[1]
    else:
        print "Usage: python coverage.py <coverage.bed>"
        return 0
    h1 = open(f1, 'r')
    column_names = h1.readline() # first row is garbage
    pp = PdfPages('all_coverages.pdf')

    done = 0
    current_tig = "" # name current unitig
    current_cov = []
    current_coo = []
    coverages = [] # store everything here
    while done == 0:
      line = h1.readline()
      if not line:
        # end of file
        done = 1
        continue
      #fields = line.split(' ') # for CANU
      fields = line.split('\t')
      tig = fields[0]
      print 'fields=', fields
      print 'tigname=', tig
      #subfields = fields[7].split('\t') # for CANU
      #coverage = subfields[4] # for CANU
      #coordinate = subfields[2] # for CANU
      coverage = fields[4]
      coordinate = fields[1]
      if (tig == current_tig) :
        # same unitig, just add coverage and coordinates
        current_cov.append(float(coverage))
        current_coo.append(float(coordinate))
      else :
        # new unitig, first we save the data for the previous unitig
	if (current_cov != []):
          coverages.append((current_tig, sum(current_cov)/len(current_cov), current_coo, current_cov))
	# the start the arrays for the new unitig
        current_cov = [float(coverage)]
        current_coo = [float(coordinate)]
        current_tig = tig
    #save the last contig
    coverages.append((current_tig, sum(current_cov)/len(current_cov), current_coo, current_cov))
    sorted_coverages = sorted(coverages, key=lambda avg: avg[1]) 

    #plot all unitigs coverage
    counter = 1
    for t in sorted_coverages:
      current_tig = t[0]
      current_avg = t[1]
      current_coo = t[2]
      current_cov = t[3]
      lab = current_tig + ' avg=' + str(current_avg)
      plt.plot(current_coo, current_cov, label=lab)
      if (counter % 1 == 0) : # each page has 10 plots
        plt.xlabel('Position')
        plt.ylabel('Coverage')
        plt.legend(fontsize='x-small')
        plt.savefig(pp, format='pdf')
        plt.clf()
      counter += 1
    pp.close()

if __name__ == '__main__':
    main()
