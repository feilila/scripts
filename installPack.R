#Usage:
#  installPack.R [SourcePackPath]
#!/usr/bin/Rscript
args<-commandArgs(trailingOnly=TRUE)
PathOfPackage<-args[1]
if(PathOfPackage=="")
{
	stop("usage: ",Args[0], "[PathOfPackage]\n")
}

PackNameArray<-unlist(strsplit(PathOfPackage,split='/'))
PackName<-gsub("^.* ", "", PackNameArray[length(PackNameArray)])
cat("package Path is:",PathOfPackage,"\n")
cat("package Name is:",PackName,",len=",nchar(PackName),"\n")

library('devtools')
create(PathOfPackage) ###input R proj
setwd(PathOfPackage)
document()
if(!file.exists('DESCRIPTION'))
{
	stop("create error stopped")
}
fp<-file('DESCRIPTION', "r")
packVersion<-""
repeat{
  cnt<-readLines(fp, 1)
  if(grepl("^Version:", cnt)){
     strLen<-nchar(cnt)
     packVersion<- gsub("^.* ","",substr(cnt,nchar("Version:")+1,strLen))
     break
  }
  else if(length(cnt)==0)
  {
  	close(fp)
  	break
  }
}

if(packVersion=="")
{
	stop("Can not get Version ,stopped")
}
cat("packVersion=",packVersion,",len=",nchar(packVersion),"\n") 

build()
curdir<-getwd()
cat("cur dir=",curdir,"\n")
setwd('../')
cat("cur dir=",getwd(),"\n")
packTargzFileName<- paste(PackName,"_",packVersion,".tar.gz",sep='')
cat("packTargzFileName=",packTargzFileName,",len=",nchar(packTargzFileName),"\n")

if(!file.exists(packTargzFileName))
{
	stop(packTargzFileName," is not exist!")
}
install.packages(packTargzFileName, type='source')
