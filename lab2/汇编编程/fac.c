#include<stdio.h>
#define num 2  //hong
int func(int i,int n,int f){
    while (i<=n)
    {
        f=f*i;
        i=i+1;
    }
    return f;    
}
int main(){
    int i,n,f;
    i=num;
    f=1;
    scanf("%d",&n);
    f=func(i,n,f);
    printf("%d\n",f);     //shuchu
}

