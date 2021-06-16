# SNPFrequency
## Analysis of the SNP frequency in given genomic intervals

This tool extracts the SNP frequency per 1 kb of defined regions of interest from a file specifyinga called genetic variants. The tool calculates the sum of SNPs per region specified in a bed file and then divides that by the length of the region, resulting in a SNP frequency (SNP/1 kb) for every region of interest.

## Usage
The script is based on Perl and can be executed from a Linux command terminal. It does not require any additional packages. Use the following command to run the script:

```
perl SNP_counting.pl FreeBayes_output.vcf Region_File.bed
```

Output files will be generated automatically and saved as input_file_name_counted.txt

## Input Data
This script requires a .vcf file as provided by the Galaxy tool FreeBayes, containing all called genetic variants for given regions or a whole genome. As a second input it needs a bed file defining the regions of interest, for which the SNP frequency should be calculated.
The file with the called genetic variants needs to be generated beforehand by a tool such as FreeBayes, which can be found for example on Galaxy Europe (https://usegalaxy.eu/). These files have extensive headers, marked by ##, followed by the definition of the called genetic variants. Example:
```
## header
## more header
## even more header
## [...]
chr1	11863	.	C	A	5.64118	.	AB=0;ABP=0;AC=0;AF=0;AN=2;AO=4;CIGAR=1X;DP=8;DPB=8;DPRA=0;EPP=5.18177;EPPR=3.0103;GTI=0;LEN=1;MEANALT=1;MQM=1;MQMR=1;NS=1;NUMALT=1;ODDS=0.980342;PAIRED=1;PAIREDR=1;PAO=0;PQA=0;PQR=0;PRO=0;QA=146;QR=164;RO=4;RPL=2;RPP=3.0103;RPPR=11.6962;RPR=2;RUN=1;SAF=1;SAP=5.18177;SAR=3;SRF=2;SRP=3.0103;SRR=2;TYPE=snp	GT:DP:AD:RO:QR:AO:QA:GL	0/0:8:4,4:4:164:4:146:0,-2.03848,-0.000211715
chr1	12383	.	G	A	0.40149	.	AB=0;ABP=0;AC=2;AF=1;AN=2;AO=2;CIGAR=1X;DP=2;DPB=2;DPRA=0;EPP=7.35324;EPPR=0;GTI=0;LEN=1;MEANALT=1;MQM=1;MQMR=0;NS=1;NUMALT=1;ODDS=2.33517;PAIRED=1;PAIREDR=0;PAO=0;PQA=0;PQR=0;PRO=0;QA=78;QR=0;RO=0;RPL=1;RPP=3.0103;RPPR=0;RPR=1;RUN=1;SAF=1;SAP=3.0103;SAR=1;SRF=0;SRP=0;SRR=0;TYPE=snp	GT:DP:AD:RO:QR:AO:QA:GL	1/1:2:0,2:0:0:2:78:-0.18997,-0.60206,0
chr1	12783	.	G	A	2.08218	.	AB=0;ABP=0;AC=2;AF=1;AN=2;AO=2;CIGAR=1X;DP=3;DPB=3;DPRA=0;EPP=3.0103;EPPR=5.18177;GTI=0;LEN=1;MEANALT=1;MQM=1;MQMR=1;NS=1;NUMALT=1;ODDS=0.485933;PAIRED=1;PAIREDR=1;PAO=0;PQA=0;PQR=0;PRO=0;QA=82;QR=41;RO=1;RPL=1;RPP=3.0103;RPPR=5.18177;RPR=1;RUN=1;SAF=0;SAP=7.35324;SAR=2;SRF=1;SRP=5.18177;SRR=0;TYPE=snp	GT:DP:AD:RO:QR:AO:QA:GL	1/1:3:1,2:1:41:2:82:-0.089992,-0.803099,0
chr1	13896	.	C	A	3.03744	.	AB=0;ABP=0;AC=2;AF=1;AN=2;AO=2;CIGAR=1X;DP=4;DPB=4;DPRA=0;EPP=7.35324;EPPR=7.35324;GTI=0;LEN=1;MEANALT=1;MQM=6;MQMR=6;NS=1;NUMALT=1;ODDS=0.0124089;PAIRED=1;PAIREDR=1;PAO=0;PQA=0;PQR=0;PRO=0;QA=68;QR=59;RO=2;RPL=0;RPP=7.35324;RPPR=7.35324;RPR=2;RUN=1;SAF=2;SAP=7.35324;SAR=0;SRF=2;SRP=7.35324;SRR=0;TYPE=snp	GT:DP:AD:RO:QR:AO:QA:GL	1/1:4:2,2:2:59:2:68:-0.00538913,-0.0720536,0
[...]
```
For the second input, the file that defined the genomic regions for which the frequencies should be calculated, a file in tabular or .bed format is needed. The file has to contain 3 tab-separated columns: chromosome, start position and stop position.
```
chromA  chromStartA  chromEndA
chromB  chromStartB  chromEndB
```
## Output Data
The file will output a tabular file defining the region, followed by the determined SNP frequency of the respective region:
```
Chromo	Startpos   	Stoppos	SNPcount	SNPs/100bp
chromA	chromStartA	chromEndA	SNPcountA	SNPFreqA
chromB	chromStartB	chromEndB	SNPcountB	SNPFreqB
chromC	chromStartC	chromEndC	SNPcountC	SNPFreqC
```

## License

MIT
