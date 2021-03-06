### R code from vignette source 'datatable-faq.Rnw'

###################################################
### code chunk number 1: datatable-faq.Rnw:15-18
###################################################
if (!exists("data.table",.GlobalEnv)) library(data.table)  # see Intro.Rnw for comments on these two lines
rm(list=as.character(tables()$NAME),envir=.GlobalEnv)
options(width=70)  # so lines wrap round


###################################################
### code chunk number 2: datatable-faq.Rnw:97-104
###################################################
DT = as.data.table(iris)
setkey(DT,Species)
myfunction = function(dt, expr) {
    e = substitute(expr)
    dt[,eval(e),by=Species]
}
myfunction(DT,sum(Sepal.Width))


###################################################
### code chunk number 3: datatable-faq.Rnw:149-155
###################################################
X = data.table(grp=c("a","a","b","b","b","c","c"), foo=1:7)
setkey(X,grp)
Y = data.table(c("b","c"), bar=c(4,2))
X
Y
X[Y,sum(foo*bar)]


###################################################
### code chunk number 4: datatable-faq.Rnw:179-182
###################################################
DF = data.frame(x=1:3,y=4:6,z=7:9)
DF
DF[,c("y","z")]


###################################################
### code chunk number 5: datatable-faq.Rnw:185-187
###################################################
DT = data.table(DF)
DT[,c(y,z)]


###################################################
### code chunk number 6: datatable-faq.Rnw:190-191
###################################################
DT[,list(y,z)]


###################################################
### code chunk number 7: datatable-faq.Rnw:200-206
###################################################
data.table(NULL)
data.frame(NULL)
as.data.table(NULL)
as.data.frame(NULL)
is.null(data.table(NULL))
is.null(data.frame(NULL))


###################################################
### code chunk number 8: datatable-faq.Rnw:210-213
###################################################
DT = data.table(a=1:3,b=c(4,5,6),d=c(7L,8L,9L))
DT[0]
sapply(DT[0],class)


###################################################
### code chunk number 9: datatable-faq.Rnw:235-238
###################################################
DT = data.table(x=rep(c("a","b"),c(2,3)),y=1:5)
DT
DT[,{z=sum(y);z+3},by=x]


###################################################
### code chunk number 10: datatable-faq.Rnw:244-249
###################################################
DT[,{
  cat("Objects:",paste(objects(),collapse=","),"\n")
  cat("Trace: x=",as.character(x)," y=",y,"\n")
  sum(y)
},by=x]


###################################################
### code chunk number 11: datatable-faq.Rnw:256-258
###################################################
DT[,list(g=1,h=2,i=3,j=4,repeatgroupname=x,sum(y)),by=x]     
DT[,list(g=1,h=2,i=3,j=4,repeatgroupname=x[1],sum(y)),by=x]


###################################################
### code chunk number 12: datatable-faq.Rnw:277-279
###################################################
A = matrix(1:12,nrow=4)
A


###################################################
### code chunk number 13: datatable-faq.Rnw:282-283
###################################################
A[c(1,3),c(2,3)]


###################################################
### code chunk number 14: datatable-faq.Rnw:290-293
###################################################
B = cbind(c(1,3),c(2,3))
B
A[B]


###################################################
### code chunk number 15: datatable-faq.Rnw:296-301
###################################################
rownames(A) = letters[1:4]
colnames(A) = LETTERS[1:3]
A
B = cbind(c("a","c"),c("B","C"))
A[B]


###################################################
### code chunk number 16: datatable-faq.Rnw:304-309
###################################################
A = data.frame(A=1:4,B=letters[11:14],C=pi*1:4)
rownames(A) = letters[1:4]
A
B
A[B]


###################################################
### code chunk number 17: datatable-faq.Rnw:312-314
###################################################
B = data.frame(c("a","c"),c("B","C"))
cat(try(A[B],silent=TRUE))


###################################################
### code chunk number 18: datatable-faq.Rnw:394-395
###################################################
base::cbind.data.frame


###################################################
### code chunk number 19: datatable-faq.Rnw:402-405
###################################################
foo = data.frame(a=1:3)
cbind.data.frame = function(...)cat("Not printed\n")
cbind(foo)


###################################################
### code chunk number 20: datatable-faq.Rnw:407-408
###################################################
rm("cbind.data.frame")


###################################################
### code chunk number 21: datatable-faq.Rnw:463-469
###################################################
DT = data.table(a=rep(1:3,1:3),b=1:6,c=7:12)
DT
DT[,{ mySD = copy(.SD)
      mySD[1,b:=99L]
      mySD },
    by=a]


###################################################
### code chunk number 22: datatable-faq.Rnw:475-481
###################################################
DT = data.table(a=c(1,1,2,2,2),b=c(1,2,2,2,1))
DT
DT[,list(.N=.N),list(a,b)]   # show intermediate result for exposition
cat(try(
    DT[,list(.N=.N),by=list(a,b)][,unique(.N),by=a]   # compound query more typical
,silent=TRUE))


###################################################
### code chunk number 23: datatable-faq.Rnw:485-488
###################################################
if (packageVersion("data.table") >= "1.8.1") {
    DT[,.N,by=list(a,b)][,unique(N),by=a]
}


###################################################
### code chunk number 24: datatable-faq.Rnw:506-514
###################################################
DT = data.table(a=1:5,b=1:5)
suppressWarnings(
DT[2,b:=6]        # works (slower) with warning
)
class(6)          # numeric not integer
DT[2,b:=7L]       # works (faster) without warning
class(7L)         # L makes it an integer
DT[,b:=rnorm(5)]  # 'replace' integer column with a numeric column


