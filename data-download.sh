#!/bin/bash

echo
echo "--------------------------------------------------------------------------"
echo "This script will download the example datasets."
echo
echo "Prerequisite programmes:"
echo "wget"
#echo "sratoolkit"
echo "--------------------------------------------------------------------------"
echo

echo
echo "--------------------------------------------------------------------------"
echo "Checking the availability of tools needed for the pipeline..."
echo "--------------------------------------------------------------------------"
echo

 
# Declare a string array with type
#declare -a CmdArray=("wget" "fastq-dump")
declare -a CmdArray=("wget")
 
# Read the array values with space
for cmd in "${CmdArray[@]}"; do
  if ! [ -x "$(command -v $cmd)" ]; then
  	echo
    echo "Error: $cmd is not installed." >&2
    exit 1
  else
    echo "$cmd is available." 
  fi
done

echo
echo "--------------------------------------------------------------------------"
echo "Checking the EBI FTP server is up running..."
echo "--------------------------------------------------------------------------"
echo

#FTPSTATUS=$(curl -s ftp://ftp-trace.ncbi.nlm.nih.gov/sra/ | grep sra-instant || echo "The site is down")

FTPSTATUS=$(curl -s ftp://ftp.sra.ebi.ac.uk/ | grep vol1 || echo "The site is down")

if [[ $FTPSTATUS == *"down"* ]]; then
    echo
    echo "Error: can not access to the EBI FTP server...please check the network connection." >&2
    exit 1
  else
    echo "The EBI FTP server is up."
    echo
fi

DATADIR=./out/data

echo "Downloading RNA-Seq data..."

mkdir -p $DATADIR/rna-seq
#wget -nv --tries=10 -O $DATADIR/rna-seq/test.sra ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRR160/SRR1605271/SRR1605271.sra 
#fastq-dump --gzip -O $DATADIR/rna-seq/ $DATADIR/rna-seq/test.sra

wget -nv --tries=10 -O $DATADIR/rna-seq/test.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR160/001/SRR1605271/SRR1605271.fastq.gz

echo "Dataset downloaded."

echo "Downloading Ribo-Seq data..."

mkdir -p $DATADIR/ribo-seq
#wget -nv --tries=10 -O $DATADIR/ribo-seq/test.sra ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRR160/SRR1605304/SRR1605304.sra 
#fastq-dump --gzip -O $DATADIR/ribo-seq/ $DATADIR/ribo-seq/test.sra

wget -nv --tries=10 -O $DATADIR/ribo-seq/test.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR160/004/SRR1605304/SRR1605304.fastq.gz

echo "Dataset downloaded."

