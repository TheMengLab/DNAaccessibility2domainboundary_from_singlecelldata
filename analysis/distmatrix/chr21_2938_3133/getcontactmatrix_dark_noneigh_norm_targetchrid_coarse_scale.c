#include <stdio.h>
#include <stdlib.h>
#include "/home/group/code/c/mldaetlib/read.c"
#include "/home/group/code/c/mldaetlib/getdatanum.c"
#include "/home/group/code/c/mldaetlib/allocate.c"
#include "/home/group/code/c/mldaetlib/getrmsd.c"
#define N 200
#define DIM 3




double getdistsq(double *coor1,double *coor2,int dim)
 {
 int i;
 double distsq;

 distsq = 0;
 for(i=0;i<dim;i++)
  distsq += (coor1[i]-coor2[i])*(coor1[i]-coor2[i]);

 return(distsq);
 }





void main()
{
char inputlistfilename[N],inputfilename[N],outputfilename[N],targetfilename[N];
int i,j,k,id1,id2,filenum,atomnum,*targetid,*targetassign,targetnum,chrid,shift,ratio,targetnum_ratio;
double **matrix,***coor,distcutoff,distsq,distcutoffsq,*sum,dist;
FILE *inputlistfile,*inputfile,*outputfile,*targetfile;

printf("Input the filename for filelist of original coordinate:\n");
scanf("%s",inputlistfilename);

printf("Input the number of atoms in this system:\n");
scanf("%d",&atomnum);

printf("Input filename for target atomlist(start from 1):\n");
scanf("%s",targetfilename);

printf("Input the cutoff for contact dist(with radius of 10):\n");
scanf("%lf",&distcutoff);

printf("Input filename for output:\n");
scanf("%s",outputfilename);

printf("Input the value for target id:\n");
scanf("%d",&chrid);

ratio = 10;


filenum = getlinenum(inputlistfilename);
targetnum = getlinenum(targetfilename);

targetnum_ratio = (targetnum-1)/ratio+1;


targetid = intarray(targetnum);
targetassign = intarray(targetnum);
//matrix = doublematrix(targetnum,targetnum);
matrix = doublematrix(targetnum_ratio,targetnum_ratio);
coor = doublematrixarray(filenum,atomnum,DIM);
sum = doublearray(targetnum_ratio);


inputlistfile = openfile(inputlistfilename,'r');
for(i=0;i<filenum;i++)
 {
 fscanf(inputlistfile,"%s",inputfilename);
 inputfile = openfile(inputfilename,'r');
 for(j=0;j<atomnum;j++)
  for(k=0;k<DIM;k++)
   fscanf(inputfile,"%lf",&coor[i][j][k]);
 fclose(inputfile);
 }
fclose(inputlistfile);
printf("test\n");

targetfile = openfile(targetfilename,'r');
for(i=0;i<targetnum;i++)
 {
 fscanf(targetfile,"%d",&targetid[i]);
 fscanf(targetfile,"%d",&targetassign[i]);
 targetid[i] --;
 }
fclose(targetfile);

printf("test\n");

for(i=0;i<targetnum_ratio;i++)
 {
 for(j=0;j<targetnum_ratio;j++)
  matrix[i][j] = 0;
 sum[i] = 0;
 }
printf("test\n");

distcutoffsq = distcutoff*distcutoff;
printf("%lf %lf\n",distcutoff,distcutoffsq);

for(k=0;k<filenum;k++)
 {
  printf("%d %d\n",filenum,k);

 for(i=0;i<targetnum;i++)
  {
  id1 = targetid[i];
//  printf("%d %d\n",k,i);
  for(j=i+4;j<targetnum;j++)
   {
   id2 = targetid[j];
   if((targetassign[i] != -1)&&(targetassign[j] != -1))
    {
     distsq = getdistsq(coor[k][id1],coor[k][id2],DIM);
     
     if(distsq < distcutoffsq)
      {
      matrix[id1/ratio][id2/ratio] += pow(distsq,-2.5);
      matrix[id2/ratio][id1/ratio] += pow(distsq,-2.5);
//      matrix[id1/ratio][id2/ratio] ++;
//      matrix[id2/ratio][id1/ratio] ++;
      }
     else
      {
      dist = sqrt(distsq);
      shift = (dist-distcutoff)/1.5-1;
      if(shift < 0)
       shift = 0;

      j += shift;
      }
//    matrix[j][i] = matrix[i][j];
    }
   }
  }



 }


//for(i=0;i<targetnum;i++)
// {
// id1 = targetid[i];
// for(j=i+2;j<targetnum;j++)
//  {
//  id2 = targetid[j];
//  if((targetassign[i] != -1)&&(targetassign[j] != -1))
//   {
//   for(k=0;k<filenum;k++)
//    {
//    distsq = getdistsq(coor[k][id1],coor[k][id2],DIM);
//    if(distsq < distcutoffsq)
//     matrix[i][j] ++;
//    }
//   matrix[j][i] = matrix[i][j];
//   }
//  }
// }

for(i=0;i<targetnum_ratio;i++)
 {
 for(j=0;j<targetnum_ratio;j++)
  sum[i] += matrix[i][j];
 }

printf("test\n");

outputfile = openfile(outputfilename,'w');
for(i=0;i<targetnum_ratio;i++)
 {
// fprintf(outputfile,"chr%d %d %d ",chrid,i*10000*ratio,(i+1)*10000*ratio);
 for(j=0;j<targetnum_ratio;j++)
  fprintf(outputfile,"%lf ",matrix[i][j]/sqrt(sum[i]*sum[j]));
 fprintf(outputfile,"\n");
 }
fclose(outputfile);





for(i=0;i<filenum;i++)
 {
 for(j=0;j<atomnum;j++)
  free(coor[i][j]);
 free(coor[i]);
 }
free(coor);

for(i=0;i<targetnum_ratio;i++)
 free(matrix[i]);
free(matrix);

free(targetid);
free(targetassign);
free(sum);


}




