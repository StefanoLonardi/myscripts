#!/usr/bin/python
import csv
import sys

def ReadNucTable(inputStr, headerFlag=None):
    '''
    Takes table in csv format, skips first line (headerFlag) if needed and creates a table of float numbers
    '''
    if headerFlag is None:
        headerFlag = False
    rows = []
    with open(inputStr, 'rb') as csvfile:
        csvreader = csv.reader(csvfile, delimiter='\t')
        if (headerFlag):
            #print 'Skipping header'
            csvreader.next()
        for row in csvreader:
            rows.append(row)
    return rows

def main(fileName='default.out'):
    """
    blah
    """
    if len(sys.argv) == 3:
        fileNameIn1 = sys.argv[1]
        fileNameIn2 = sys.argv[2]
    else:
        print "Usage: python checkSNPs.py <file1.csv> <file2.csv>"
        return 0

    # read first file
    list1 = ReadNucTable(fileNameIn1,True)
    # set1 is the set of unique SNPs in first file
    set1 = {}
    for snp in list1:
        set1[snp[0]] = True 
    print 'File', fileNameIn1, 'has', len(set1), 'distinct SNPs'

    # read second file
    list2 = ReadNucTable(fileNameIn2,True)
    # set2 is the set of unique SNPs in second file
    set2 = {}
    for snp in list2:
        set2[snp[0]]=True
    print 'File', fileNameIn2, 'has', len(set2), 'distinct SNPs'
    #print set2

    intersection = 0
    for snp in set1:
        if set2.has_key(snp):
            intersection += 1

    total = (len(set1) - intersection) + intersection + len(set2)- intersection
    print 'Unique to file',fileNameIn1,len(set1) - intersection,'SNPs (',100.0*(len(set1) - intersection)/total,'% of total)'
    print 'Unique to file',fileNameIn2,len(set2) - intersection,'SNPs (',100.0*(len(set2) - intersection)/total,'% of total)'
    print 'In common', intersection,'SNPs (',100.0*intersection/total,'% of total)'

if __name__ == '__main__':
    main()
