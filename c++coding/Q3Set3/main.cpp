#include <iostream>

using namespace std;

int main()
{
    int a=4;
    int c[4]={1,1,1,1};

    int t1 = 0;
   while( t1 < a)
   {
       int t2 = t1;
       while( 0<=t2)
       {
            c[t1] *= t2;
            cout<<c[t1]<<"  ";
             t2--;
       }
        t1++;

   }
   cout<<endl;
   for(int i = 0; i < a; i++)
   {
       for(int j = i; j >= 0; j--)
       {
            cout<<c[i]<<"  ";
       }

   }

   cout<<endl;
   for(int i = 0; i < a; i++)
   {
       for(int j = 0; j < a; j++)
       {
            cout<<c[i]<<"  ";
       }

   }
cout<<endl;

     for(int j = 0; j < a; j++)
       {
            cout<<c[j]<<"  ";
       }




    return 0;
}
