#include <stdio.h>
#include <math.h>
#include "/home/group/code/c/mldaetlib/allocate.c"
#include "/home/group/code/c/mldaetlib/read.c"
#include "/home/group/code/c/mldaetlib/getdatanum.c"
#include "/home/group/code/c/mldaetlib/inlist.c"
#define N 500
#define LINELEN 5000
#define DIM 3
#define IL 9



int getinstringlist(char **idlist,int idnum,char *targetid,char **charindexlist,int charindexlistlen,char *tempcharindex,int **charindexrange)
 {
 int i,j,k,l,m,tempindex,targetindex;

 for(i=0;i<IL;i++)
  tempcharindex[i] = targetid[i];

 tempindex = instringlist(charindexlist,charindexlistlen,tempcharindex);

 targetindex = -1;
 for(i=charindexrange[tempindex][0];(i<=charindexrange[tempindex][1])&&(targetindex==-1);i++)
  {
  if(strcmp_nolen(targetid,idlist[i]) == 0)
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



int getnexttime(int time)
 {
 int i,j,k,yearid,monthid,dayid;
 int monthlenlist[12];
 int nextyearid,nextmonthid,nextdayid,nexttime;

 yearid = time/10000;
 time -= yearid*10000;
 monthid = time/100;
 time -= monthid*100;
 dayid = time;

 monthlenlist[0] = 31;
 monthlenlist[1] = 28;
 monthlenlist[2] = 31;
 monthlenlist[3] = 30;
 monthlenlist[4] = 31;
 monthlenlist[5] = 30;
 monthlenlist[6] = 31;
 monthlenlist[7] = 31;
 monthlenlist[8] = 30;
 monthlenlist[9] = 31;
 monthlenlist[10] = 30;
 monthlenlist[11] = 31;


 if((yearid%4==0)&&(yearid%100!=0))
  monthlenlist[1] = 29;
 
 nextyearid = yearid;
 nextmonthid = monthid;
 nextdayid = dayid+1;
 if(dayid == monthlenlist[monthid-1])
  {
  nextdayid = 1;
  nextmonthid ++;
  if(nextmonthid > 12)
   {
   nextmonthid = 1;
   nextyearid ++;
   }
  }
 
 nexttime = nextyearid*10000+nextmonthid*100+nextdayid;

 return(nexttime);

 }




void initdaytime(int *daytime,int startyearid,int endyearid,int daytimelen)
 {
 int i,j,k,l,id;
 int time;

 for(i=0;i<daytimelen;i++)
  {
  daytime[i] = -1;
  }

 time=startyearid*10000+101;
 id = 0;

 for(id=0;id<daytimelen;id++)
  {
  daytime[id] = time;
  time=getnexttime(time);
//  printf("%d %d\n",id,daytime[id]);
  }



 }





int getseqdayid(int startyearid,int *daytime,int daytimelen,int time)
 {
 int i,j,k,yearid,monthid,dayid,seqdayid,targettime;
 int endbool;

 targettime = time;

 yearid = time/10000;
 time -= yearid*10000;
 monthid = time/100;
 time -= monthid*100;
 dayid = time;

 seqdayid = (yearid-startyearid)*365+(monthid-1)*30+dayid-1;

 if(seqdayid >= daytimelen)
  seqdayid = daytimelen-1;

 endbool = 0;
 for(;(endbool==0)&&(seqdayid>=0)&&(seqdayid<daytimelen);)
  {
  if(daytime[seqdayid] < targettime)
   seqdayid ++;
  else if(daytime[seqdayid] > targettime)
   seqdayid --;
  else
   endbool = 1;
  }
 
 return(seqdayid);

 }



int lineinfoconvert(char *line,int linelen,char **pairlist,double *current,int *timelist)
 {
 int i,j,k,segnum,id;
 char tempstring[6][N];

 segnum = 0;
 id = 0;
 for(i=0;i<6;i++)
  for(j=0;j<N;j++)
   tempstring[i][j] = '\0';


 for(i=0;line[i] != '\0';i++)
  {
//  printf("%d %c\n",i,line[i]);
  if((line[i] != ' ')&&(line[i] != '\0'))
   {
   if(segnum >= 6)
    {
    printf("ERROR for the line convert: %d\n",segnum);
    printf("%s",line);
    exit(0);
    }
   tempstring[segnum][id] = line[i];
   id ++;
   }
  else
   {
   segnum ++;
   id = 0;
   }
  }
// printf("test %d\n",segnum);

 if(segnum == 5)
  {
//printf("test1\n");
  stringcopy(tempstring[0],pairlist[0]);
//printf("test2 %s\n",pairlist[0]);
  stringcopy(tempstring[2],pairlist[1]);
//printf("test3 %s\n",pairlist[1]);
  stringcopy(tempstring[3],pairlist[2]);
//printf("test4 %s\n",pairlist[2]);
  current[0] = stringtodouble(tempstring[1]);
//printf("test5 %lf\n",current[0]);
  timelist[0] = stringtoint(tempstring[4]);
//printf("test6 %d\n",timelist[0]);
  timelist[1] = stringtoint(tempstring[5]);
//printf("test7 %d\n",timelist[1]);
  }
 else
  {
  current[0] = 0;
  }
 return(segnum);
 }




int lineinfoconvert2(char *line,int linelen,char **pairlist,double *current,int *timelist)
 {
 int i,j,k,segnum,id;
 char tempstring[6][N];

 segnum = 0;
 id = 0;
 for(i=0;i<6;i++)
  for(j=0;j<N;j++)
   tempstring[i][j] = '\0';


 for(i=0;line[i] != '\0';i++)
  {
//  printf("%d %c\n",i,line[i]);
  if((line[i] != ' ')&&(line[i] != '\0'))
   {
   if(segnum >= 4)
    {
    printf("ERROR for the line convert: %d\n",segnum);
    printf("%s",line);
    exit(0);
    }
   tempstring[segnum][id] = line[i];
   id ++;
   }
  else
   {
   segnum ++;
   id = 0;
   }
  }
// printf("test %d\n",segnum);

 if(segnum == 3)
  {
//printf("test1\n");
  stringcopy(tempstring[0],pairlist[0]);
//printf("test2 %s\n",pairlist[0]);
//  stringcopy(tempstring[2],pairlist[1]);
//printf("test3 %s\n",pairlist[1]);
//  stringcopy(tempstring[3],pairlist[2]);
//printf("test4 %s\n",pairlist[2]);
  current[0] = stringtodouble(tempstring[3]);
//printf("test5 %lf\n",current[0]);
  timelist[0] = stringtoint(tempstring[1]);
//printf("test6 %d\n",timelist[0]);
  timelist[1] = stringtoint(tempstring[2]);
//  printf("test current %s %lf\n",tempstring[3],current[0]);
//printf("test7 %d\n",timelist[1]);
  }
 else
  {
  current[0] = 0;
  }
 return(segnum);
 }




void main()
{
char idlistfilename[N],pairfilename[N],singlefilename[N],outputfilename[N],**idlist,**pairlist,**charindexlist,tempcharindex[50],line[LINELEN];
int i,j,k,idnum,pairnum,id1,id2,**pairidlist,**charindexrange,charindexlistlen,**contactidlist,*contactidlen,**timelist,date,second,starttime,endtime,*daytime,startyearid,endyearid,daytimelen,seqdayid;
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
//matrix = doublematrix(idnum,idnum);
pairlist = namearray(3,50);
current = doublearray(pairnum);
pairidlist = intmatrix(pairnum,2);
timelist = intmatrix(pairnum,2);

charindexlist = namearray(idnum,50);
charindexrange = intmatrix(idnum,2);

contactidlist = intpointarray(idnum);
contactidlen = intarray(idnum);

contactflux = doublearray(idnum);


for(i=0;i<50;i++)
 tempcharindex[i] = '\0';


charindexlistlen = 0;
idlistfile = openfile(idlistfilename,'r');
for(i=0;i<idnum;i++)
 {
// printf("%d %d\n",i,idnum);
 fscanf(idlistfile,"%s",idlist[i]);
 for(j=0;j<IL;j++)
  tempcharindex[j] = idlist[i][j];
 if(instringlist(charindexlist,charindexlistlen,tempcharindex) == -1)
  {
  for(j=0;j<IL;j++)
   charindexlist[charindexlistlen][j] = tempcharindex[j];
  charindexlistlen ++;
  }
// printf("%s\n",idlist[i]);
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
// printf("check %s %d\n",tempcharindex,k);
 if(charindexrange[k][0] > i)
  charindexrange[k][0] = i;
 if(charindexrange[k][1] < i)
  charindexrange[k][1] = i;
// printf("check %d %d\n",charindexrange[0][0],charindexrange[0][1]);
 }

//for(i=0;i<charindexlistlen;i++)
// {
// printf("%s %d %d\n",charindexlist[i],charindexrange[i][0],charindexrange[i][1]);
// }


pairfile = openfile(pairfilename,'r');
for(i=0;i<pairnum;i++)
 {
 printf("pair %d %d\n",i,pairnum);
 if(fgets(line,LINELEN,pairfile) == NULL)
  {
  printf("Error in read the input file:\n");
  exit(0);
  }
// lineinfoconvert(line,LINELEN,pairlist,&current[i],timelist[i]);
 lineinfoconvert2(line,LINELEN,pairlist,&current[i],timelist[i]);

// fscanf(pairfile,"%s",pairlist[0]);
// fscanf(pairfile,"%lf",&current[i]);
// fscanf(pairfile,"%s",pairlist[1]);
// fscanf(pairfile,"%s",pairlist[2]);
// fscanf(pairfile,"%d",&timelist[i][0]);
// fscanf(pairfile,"%d",&timelist[i][1]);
// printf("%d %d\n",timelist[i][0],timelist[i][1]);
 if(i==0)
  {
  starttime=timelist[i][0];
  endtime= timelist[i][0];
  }
 if((starttime < 19000000)||(starttime>21000000)||(endtime < 19000000)||(endtime>21000000))
  {
  starttime=timelist[i][0];
  endtime= timelist[i][0];
  }
// printf("check\n");

// printf("%s\n",pairlist[0]);
 pairidlist[i][0] = getinstringlist(idlist,idnum,pairlist[0],charindexlist,charindexlistlen,tempcharindex,charindexrange);
// printf("check\n");
// pairidlist[i][1] = getinstringlist(idlist,idnum,pairlist[2],charindexlist,charindexlistlen,tempcharindex,charindexrange);
// printf("check\n");

// pairidlist[i][0] = instringlist(idlist,idnum,pairlist[0]);
// pairidlist[i][1] = instringlist(idlist,idnum,pairlist[2]);
// printf("%d %d %lf\n",pairidlist[i][0],pairidlist[i][1],current[i]);
 }
fclose(pairfile);

for(i=0;i<pairnum;i++)
 {
 if((timelist[i][0] < 19000000)||(timelist[i][0] > 21000000))
  {
  printf("timelist %d\n",timelist[i][0]);
  current[i] = 0;
  }
 if((current[i] > 0.1)||(current[i] < -0.1))
  {
  if(starttime > timelist[i][0])
   starttime = timelist[i][0];
  if(endtime < timelist[i][0])
   endtime = timelist[i][0];
  }
 }

startyearid = starttime/10000;
endyearid = endtime/10000+1;
daytimelen = (endyearid-startyearid)*366;

daytime = intarray(daytimelen);
initdaytime(daytime,startyearid,endyearid,daytimelen);

printf("startyearid %d\n",startyearid);

date=timelist[0][0];
second=timelist[0][1];
printf("check\n");
for(i=1;i<pairnum;i++)
 {
 if((date==timelist[i][0])&&(second==timelist[i][1]))
  {
//  printf("%d\n",i);
  current[i] = 0;
  }
 else
  {
  date=timelist[i][0];
  second=timelist[i][1];
  }
 }

outputfile = openfile(outputfilename,'w');
for(i=0;i<pairnum;i++)
 {
// printf("output %d \n",i);
 if((current[i] > 0.001)||(current[i] < -0.001))
  {
  seqdayid = getseqdayid(startyearid,daytime,daytimelen,timelist[i][0]);
//  printf("time %d %d %d %d %d\n",timelist[i][0],seqdayid,starttime,starttime,endtime);
//  fprintf(outputfile,"%d %d %lf %d %d %d\n",pairidlist[i][0],pairidlist[i][1],current[i],seqdayid,timelist[i][0],timelist[i][1]);
  fprintf(outputfile,"%d %lf %d %d %d\n",pairidlist[i][0],current[i],seqdayid,timelist[i][0],timelist[i][1]);
  }
 }

fclose(outputfile);



//for(i=0;i<idnum;i++)
// {
// contactidlen[i] = 0;
// }
//
//for(i=0;i<pairnum;i++)
// {
// contactidlen[pairidlist[i][0]] ++;
// contactidlen[pairidlist[i][1]] ++;
// }
//
//for(i=0;i<idnum;i++)
// {
// if(contactidlen[i] > 0)
//  contactidlist[i] = intarray(contactidlen[i]);
// else
//  contactidlist[i] = intarray(1);
// }
//
//for(i=0;i<idnum;i++)
// {
// contactidlen[i] = 0;
// }
//
//for(i=0;i<pairnum;i++)
// {
// contactidlist[pairidlist[i][0]][contactidlen[pairidlist[i][0]]] = i;
// contactidlen[pairidlist[i][0]] ++;
// contactidlist[pairidlist[i][1]][contactidlen[pairidlist[i][1]]] = i;
// contactidlen[pairidlist[i][1]] ++;
// }
//
//
//outputfile = openfile(outputfilename,'w');
//
//for(i=0;i<idnum;i++)
// {
// for(j=0;j<idnum;j++)
//  contactflux[j] = 0;
//
// for(j=0;j<contactidlen[i];j++)
//  {
//  k=contactidlist[i][j];
//  if(current[k] > 0)
//   {
//   if(i==pairidlist[k][1])
//    {
//    contactflux[pairidlist[k][0]] += current[k];
////    if((pairidlist[k][1]==0)&&(pairidlist[i][0] == 1734))
////     printf("check %lf\n",current[k]);
//    }
//   }
//  else
//   {
//   if(i==pairidlist[k][0])
//    {
//    contactflux[pairidlist[k][1]] -= current[k];
//    }
//   }
//  }
//
// for(j=0;j<idnum;j++)
//  {
//  if((contactflux[j] > 0.1)||(contactflux[j] < -0.1))
//   {
//   fprintf(outputfile,"%d %d %lf\n",i,j,contactflux[j]);
//   }
//  }
// }
//
////for(i=0;i<idnum;i++)
//// {
//// printf("%d %d\n",i,idnum);
//// for(j=0;j<idnum;j++)
////  contactflux[j] = 0;
////
//// for(k=0;k<pairnum;k++)
////  {
////  if(current[k] > 0)
////   {
////   if(i==pairidlist[k][1])
////    {
////    contactflux[pairidlist[k][0]] += current[k];
//////    if((pairidlist[k][1]==0)&&(pairidlist[i][0] == 1734))
//////     printf("check %lf\n",current[k]);
////    }
////   }
////  else
////   {
////   if(i==pairidlist[k][0])
////    {
////    contactflux[pairidlist[k][1]] -= current[k];
////    }
////   }
////  }
////
//// for(j=0;j<idnum;j++)
////  {
////  if((contactflux[j] > 0.1)||(contactflux[j] < -0.1))
////   {
////   fprintf(outputfile,"%d %d %lf\n",i,j,contactflux[j]);
////   }
////  }
//// }
//
//fclose(outputfile);
//
////for(i=0;i<pairnum;i++)
//// {
//// printf("%d %d %lf\n",pairidlist[i][0],pairidlist[i][1],current[i]);
//// }





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

free(current);

for(i=0;i<pairnum;i++)
 {
 free(pairidlist[i]);
 free(timelist[i]);
 }
free(pairidlist);
free(timelist);

free(contactflux);
free(daytime);

//free(contactidlist);
free(contactidlen);

}


