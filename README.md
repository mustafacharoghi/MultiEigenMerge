### MultiEigenMerge
The original program for merging genotype files in eigenstrat format, i.e., `mergeit.c` enclosed in EIGENSOFT (https://github.com/DReichLab/EIG) and ADMIXTOOLS (https://github.com/DReichLab/AdmixTools) packages, can only merge two file every time. 
Accounting that, I wrote this R code `MultiEigenMerge.R` to generate parameter files and the bash file for merging multiple (>2) genotype files in eigenstrat format. 

## INPUT
* `merged.file.list.DIR`: a list containing the prefixes of all the eigenstrat files you want to merge - one line per prefix. E.g., `v50.0_1240K_public` is the prefix of `v50.0_1240K_public.geno`, `v50.0_1240K_public.snp`, and `v50.0_1240K_public.ind`.
* `fixed.par.file.DIR`: the part of parameter file that does not change, i.e, except for the name of input and output eigenstrat files.
* `mergeit.DIR`: the directory of compiled `mergeit` program.

## OUTPUT
* `output.file.prefix`: the prefix of newly generated eigenstrat file.
* `do_mergeit.sh`: the bash file used for running `mergeit`.
