#include <stdio.h>
#include <math.h>
#include "/home/group/code/c/mldaetlib/allocate.c"
#include "/home/group/code/c/mldaetlib/read.c"
#include "/home/group/code/c/mldaetlib/getdatanum.c"
#include "/home/group/code/c/mldaetlib/inlist.c"
#define N 500
#define LINELEN 5000
#define DIM 3
#define IL 7



int getinstringlist(char **idlist,int idnum,char *targetid,char **charindexlist,int charindexlistlen,char *tempcharindex,int **charindexrange)
 {
 int i,j,k,l,m,tempindex,targetindex;

 for(i=0;i<IL;i++)
  tempcharindex[i] = targetid[i];

 tempindex = instringlist(charindexlist,charindexlistlen,tempcharindex);

 targetindex = -1;
 for(i=charindexrange[tempindex][0];(i<=charindexrange[tempindex][1])&&(targetindex==-1);i++)
  {
//  if(strcmp_nolen(targetid,idlist[i]) == 0)
  if(strcmp_nolen_start(targetid,idlist[i],IL) == 0)
   {
   targetindex = i;
   }
  }

 if(targetindex == -1)
  {
  printf("ERROR for assignment:\n");
  printf("%s %s %d %d\n",targetid,tempcharindex,charindexrange[tempindex][0],charindexrange[tempindex][1]);
  exit(0);
  }
 return(targetindex);

 }












void main()
{
char idlistfilename[N],pairfilename[N],singlefilename[N],outputfilename[N],**idlist,**pairlist,**charindexlist,tempcharindex[50],line[LINELEN];
int i,j,k,id,idnum,pairnum,id1,id2,*count,**pairidlist,**charindexrange,charindexlistlen,**contactidlist,*contactidlen,**timelist,date,second,starttime,endtime,*daytime,startyearid,endyearid,daytimelen,seqdayid;
double *current,*contactflux;
FILE *idlistfile,*pairfile,*outputfile;

printf("Input filename for idlist:\n");
scanf("%s",idlistfilename);

printf("Input filename for pair current:\n");
scanf("%s",pairfilename);

printf("Input filename for output:\n");
scanf("%s",outputfilename);

idnum = getlinenum(idlistfilename);
pairnum = getlinenum(pairfilename);

idlist = namearray(idnum,50);
count = intarray(idnum);
//matrix = doublematrix(idnum,idnum);
pairlist = namearray(3,50);
pairidlist = intmatrix(pairnum,2);

charindexlist = namearray(idnum,50);
charindexrange = intmatrix(idnum,2);

contactidlist = intpointarray(idnum);
contactidlen = intarray(idnum);



for(i=0;i<50;i++)
 tempcharindex[i] = '\0';


charindexlistlen = 0;
idlistfile = openfile(idlistfilename,'r');
for(i=0;i<idnum;i++)
 {
 if(i%1000==0) 
  printf("%d %d\n",i,idnum);
 fscanf(idlistfile,"%s",idlist[i]);
 for(j=0;j<IL;j++)
  tempcharindex[j] = idlist[i][j];
 if(instringlist(charindexlist,charindexlistlen,tempcharindex) == -1)
  {
  for(j=0;j<IL;j++)
   charindexlist[charindexlistlen][j] = tempcharindex[j];
  charindexlistlen ++;
  }
 count[i] = 0;
 }
fclose(idlistfile);

for(i=0;i<charindexlistlen;i++)
 {
 charindexrange[i][0] = idnum;
 charindexrange[i][1] = 0;
 
 }

for(i=0;i<idnum;i++)
 {
 for(j=0;j<IL;j++)
  tempcharindex[j] = idlist[i][j];
 k=instringlist(charindexlist,charindexlistlen,tempcharindex);
 if(charindexrange[k][0] > i)
  charindexrange[k][0] = i;
 if(charindexrange[k][1] < i)
  charindexrange[k][1] = i;
 }

pairfile = openfile(pairfilename,'r');
for(i=0;i<pairnum;i++)
 {
 fscanf(pairfile,"%s",line);
 fscanf(pairfile,"%s",line);
 fscanf(pairfile,"%s",line);
 fscanf(pairfile,"%s",line);
 if(i%100000==0)
  printf("%d %s\n",i,line);

 id = getinstringlist(idlist,idnum,line,charindexlist,charindexlistlen,tempcharindex,charindexrange);
 count[id] ++;
 fscanf(pairfile,"%s",line);
 }

fclose(pairfile);

outputfile = openfile(outputfilename,'w');
for(i=0;i<idnum;i++)
 fprintf(outputfile,"%d\n",count[i]);
fclose(outputfile);







for(i=0;i<idnum;i++)
 {
 free(idlist[i]);
 free(charindexlist[i]);
 free(charindexrange[i]);
// free(contactidlist[i]);
 }
free(idlist);
free(charindexlist);
free(charindexrange);
//free(contactidlist);

for(i=0;i<3;i++)
 free(pairlist[i]);
free(pairlist);


for(i=0;i<pairnum;i++)
 {
 free(pairidlist[i]);
 }
free(pairidlist);


//free(contactidlist);
free(contactidlen);
free(count);

}


