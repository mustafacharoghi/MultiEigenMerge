merged.file.list.DIR="merged.file.prefix.txt"
fixed.par.file.DIR="fixed.parfile.txt"
merged.file.prefix=read.table(merged.file.list.DIR, header=FALSE, sep="")
fixed.parfile=read.table(fixed.par.file.DIR, header=FALSE, sep="\t")

output.file.prefix="merged.file"

eigen.fileset=function(infix, filename){
  eigen.setmat=matrix(0, nrow=3, ncol=1)
  eigen.setmat[1,]=paste("geno", infix, ":   ", filename, ".geno", sep="")
  eigen.setmat[2,]=paste("snp", infix, ":   ", filename, ".snp", sep="")
  eigen.setmat[3,]=paste("ind", infix, ":   ", filename, ".ind", sep="")
  return(eigen.setmat)
}

par.file=matrix(0, nrow=3*3+dim(fixed.parfile)[1], ncol=1)

old.filename=merged.file.prefix[1,]
new.filename=merged.file.prefix[2,]
output.filename=paste(output.file.prefix, 1, sep="_")
par.file[1:3,]=eigen.fileset(1,old.filename)
par.file[4:6,]=eigen.fileset(2,new.filename)
par.file[7:9,]=eigen.fileset("outfilename", output.filename)
par.file[10:dim(par.file)[1],]=fixed.parfile$V1
write.table(par.file, paste(output.filename,".par",sep=""), quote=FALSE, col.names=FALSE, row.names=FALSE)

for(i in 3:dim(merged.file.prefix)[1]){
  old.filename=paste(output.file.prefix, i-2, sep="_")
  new.filename=merged.file.prefix[i,]
  output.filename=paste(output.file.prefix, i-1, sep="_")
  par.file[1:3,]=eigen.fileset(1,old.filename)
  par.file[4:6,]=eigen.fileset(2,new.filename)
  par.file[7:9,]=eigen.fileset("outfilename", output.filename)
  par.file[10:dim(par.file)[1],]=fixed.parfile$V1
  write.table(par.file, paste(output.filename,".par",sep=""), quote=FALSE, col.names=FALSE, row.names=FALSE)
}

mergeit.DIR="/DIR/bin/mergeit"
bash.file=matrix(NA,nrow=1,ncol=1)
bash.file[1,]=paste("for i in $(seq 1 ", dim(merged.file.prefix)[1]-1, "); do ", mergeit.DIR, " -p ", paste(output.file.prefix,"_$i.par", sep=""), " > ", paste(output.file.prefix,"_$i.log", sep=""), "; done", sep="")
write.table(bash.file, "do_mergeit.sh", row.names=FALSE, col.names=FALSE, quote=FALSE)
library(icesTAF)
dos2unix("do_mergeit.sh")
