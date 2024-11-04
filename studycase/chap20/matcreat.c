/* 1&2 include head files and use marco*/
#include <stdio.h>
#include <string.h> /* For strcmp() */
#include <stdlib.h> /* For EXIT_FAILURE, EXIT_SUCCESS */
#include "mat.h" 
#define BUFSIZE 256 
/*3. create main function*/
int main() {
  MATFile *pmat;
  mxArray *pa1, *pa2, *pa3;
  double data[9] = { 1.0, 4.0, 7.0, 2.0, 5.0, 8.0, 3.0, 6.0, 9.0 };
  const char *file = "mattest.mat";
  char str[BUFSIZE];
  int status;  
  printf("Creating file %s...\n\n", file);
  pmat = matOpen(file, "w");
  pa1 = mxCreateDoubleMatrix(3,3,mxREAL);
  pa2 = mxCreateDoubleMatrix(3,3,mxREAL);
   /*4. copy data */
  memcpy((void *)(mxGetPr(pa2)), (void *)data, sizeof(data));  
  pa3 = mxCreateString("MATLAB: the language of technical computing");
  status = matPutVariable(pmat, "LocalDouble", pa1);
  status = matPutVariableAsGlobal(pmat, "GlobalDouble", pa2);
  status = matPutVariable(pmat, "LocalString", pa3);
  memcpy((void *)(mxGetPr(pa1)), (void *)data, sizeof(data));
  status = matPutVariable(pmat, "LocalDouble", pa1);
   /* 5. clean up */
  mxDestroyArray(pa1);
  mxDestroyArray(pa2);
  mxDestroyArray(pa3); 
  printf("Done\n");
  return(EXIT_SUCCESS);
}
