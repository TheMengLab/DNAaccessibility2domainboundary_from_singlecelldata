#include <stdio.h>
#include <math.h>
#include "/home/group/code/c/mldaetlib/allocate.c"
#include "/home/group/code/c/mldaetlib/read.c"
#include "/home/group/code/c/mldaetlib/getdatanum.c"
#include "/home/group/code/c/mldaetlib/inlist.c"
#define N 200
#define DIM 3





double getdist(double *coor1,double *coor2,int dim)
 {
 int i;
 double distsq;
 distsq = 0;

 for(i=0;i<dim;i++)
  distsq += (coor1[i]-coor2[i])*(coor1[i]-coor2[i]);

 return(sqrt(distsq));
 }












void main()
{
char coorlistfilename[N],coorfilename[N],assignfilename[N],outputfilename[N],avedistfilename[N];
int i,j,k,l,m,filenum,pointnum,**assign,*count,interval,*chrlen,chrnum,intervalnum,tempid,maxlen,endbool,chrid,startid,endid,*targetid,avedistnum,tempstartid,ratio,distlen;
double ***coor,*avedist,**distmatrix,*distlist,medianvalue;
FILE *coorlistfile,*coorfile,*assignfile,*outputfile,*avedistfile;

printf("Input filename for original coordinate list:\n");
scanf("%s",coorlistfilename);

printf("Input number of point in the system:\n");
scanf("%d",&pointnum);

//printf("Input the chr id for target assignment:\n");
//scanf("%d",&chrid);
//
printf("Input the interval for distance calculation:\n");
scanf("%d",&interval);

//printf("Input filename for avedist:\n");
//scanf("%s",avedistfilename);
//
//printf("Input the startid for calculation:\n");
//scanf("%d",&startid);
//
//printf("Input the endid for calculation:\n");
//scanf("%d",&endid);
//
printf("Input filename for output:\n");
scanf("%s",outputfilename);


filenum = getlinenum(coorlistfilename);
distlist = doublearray(filenum*interval*interval);


coor = doublematrixarray(filenum,pointnum,DIM);




intervalnum = (pointnum-1)/interval+1;
printf("%d\n",intervalnum);

distmatrix = doublematrix(intervalnum,intervalnum);
targetid = intarray(intervalnum);

for(i=0;i<intervalnum;i++)
 {
 for(j=0;j<intervalnum;j++)
  distmatrix[i][j] = 0;
 targetid[i] = (i+1)*interval;
 if(targetid[i] > pointnum)
  targetid[i] = pointnum;
 }



coorlistfile = openfile(coorlistfilename,'r');
for(i=0;i<filenum;i++)
 {
 fscanf(coorlistfile,"%s",coorfilename);
 coorfile = openfile(coorfilename,'r');
 for(j=0;j<pointnum;j++)
  for(k=0;k<DIM;k++)
   fscanf(coorfile,"%lf",&coor[i][j][k]);
 fclose(coorfile);
 }
fclose(coorlistfile);




for(i=0;i<intervalnum;i++)
 {
 printf("%d %d\n",i,intervalnum);
 for(j=i+1;j<intervalnum;j++)
  {
  distlen = 0;
   for(l=i*interval;l<targetid[i];l++)
    {
    for(m=j*interval;m<targetid[j];m++)
     {

     for(k=0;k<filenum;k++)
      {
      distlist[distlen] = getdist(coor[k][l],coor[k][m],DIM);
      distlen ++;
      }

     }
    }

  medianvalue = getmedianvalue(distlist,distlen);
  distmatrix[i][j] = medianvalue;
  distmatrix[j][i] = distmatrix[i][j];
// printf("%d %d %d %d\n",i,j,intervalnum,distlen);

  }
 }


//count = intarray(intervalnum);
//avedist = doublearray(intervalnum);
//
//for(i=0;i<intervalnum;i++)
// {
// avedist[i] = 0;
// count[i] = 0;
// }





outputfile = openfile(outputfilename,'w');
for(i=0;i<intervalnum;i++)
 {
 for(j=0;j<intervalnum;j++)
  {
  if(i==j)
   fprintf(outputfile,"0 ");
  else
   fprintf(outputfile,"%lf ",log(distmatrix[i][j])/log(10));
//  if((assign[targetid[i]][2] == -1)||(assign[targetid[j]][2] == -1)||(i==j))
//   fprintf(outputfile,"0 ");
//  else if(i>j)
//   fprintf(outputfile,"%lf ",-log(distmatrix[i][j]/avedist[i-j-1])/log(10));
//  else if(i<j)
//   fprintf(outputfile,"%lf ",-log(distmatrix[i][j]/avedist[j-i-1])/log(10));
  }
 fprintf(outputfile,"\n");
 }
fclose(outputfile);


//free(count);
//free(avedist);
//for(i=0;i<pointnum;i++)
// free(assign[i]);
//free(assign);
for(i=0;i<filenum;i++)
 {
 for(j=0;j<pointnum;j++)
  free(coor[i][j]);
 free(coor[i]);
 }
free(coor);
//free(chrlen);

free(targetid);
for(i=0;i<intervalnum;i++)
 free(distmatrix[i]);
free(distmatrix);
//free(avedist);
free(distlist);






}







