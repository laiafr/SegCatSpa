scan("~/Documents/SegCatSpa/big_corpora/conc_cat/4/spanninga.txt",what="character")->sp
sp[-1]->sp
t(matrix(sp,nrow=2))->sp1
write.table(sp2,"span.txt")
read.table("span.txt")->sp
colnames(sp)<-c("diphone","nsp")

scan("~/Documents/SegCatSpa/big_corpora/conc_cat/4/internal.txt",what="character")->int
int[-1]->int
t(matrix(int,nrow=2))->int
write.table(int,"int.txt")
read.table("int.txt")->int
colnames(int)<-c("diphone","nint")

merge(sp,int,all.x=T,all.y=T)->both

both$prop=both$nsp/(both$nsp+both$nint)
hist(both$prop)
