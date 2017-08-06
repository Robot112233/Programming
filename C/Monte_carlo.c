#include<stdio.h>
#include<stdlib.h>


int main(){
  srand (time(0));

//-----------X--------------------------
  double a = 0.0;
  double b = 5.0;
  double x;
//-----------Y--------------------------
  double e = 0.0;
  double f = 5.0;
  double y;

//---------numerical-intecral-----------
  int n = 10000000;
  double z;
  double ans;
  int i;
  for(i=0; i < n; i++){
    double d = rand()/(double)RAND_MAX;
    x = a+(b-a)*d;
    y = e+(f-e)*d;
    z = z+(2*x+y);
  }
  ans = (((b-a)*(f-e))/n)*z;
  printf("%e\n",ans);
}
