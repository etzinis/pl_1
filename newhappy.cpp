#include <stdio.h>
int main(void)
{
	FILE *fp;
	int a=3;
	int b=1;
	int i=0;
	int j=0;
	int temp=0;
	int numofhappies=0;
	int temp_number[10];
	int first[1000];
	int current[1000];
	int number[10];
	int k=0;
	fp=fopen("hap.txt", "rt");
	fscanf(fp,"%d\n", &a);
	fscanf(fp,"%d\n", &b);
	printf("To diasthma einai %d - %d\n", a, b);
	int sq[10];
	int c=a;
	
	int sum=0;
	for (i=0; i<10; i++)
	{
		temp_number[i]=0;
		sq[i]=i*i; 								//make the squares of digits 0-9
		number[i]=a % (10*(i+1));
		a = a / (10*(i+1));
	} 											//get the number divided in digits
	
	//find for all numbers tha digits<=3 if they are happy
	
	for(i=0; i<1000; i++) 
	{
		first[i]=0;
		current[i]=0;
	}                                           //initialization
	first[0]=-1;
	
	for(i=1; i<1000; i++)
	{
		if(first[i]==0)							//an den exei elegxthei
		{
			k=0;								//deikths sthn lista ths akolouthias
			temp=i;
			for(j=0; j<3; j++)
			{
				temp_number[j]=temp % (10*(j+1));
				temp = temp / (10*(j+1));
			}
			sum=0;
			while(sum!=1 && sum!=4)
			{
				sum=0;
				for(j=0; j<3; j++)
				{
					sum=sum + sq[temp_number[j]];	
				}
				temp=sum;
				for(j=0; j<3; j++)
				{
					temp_number[j]=temp % (10*(j+1));	//get the next number
					temp = temp / (10*(j+1));
				}
				current[k]=sum;
				k++;				
			}
			if (sum==1)
			{
				for(j=0; j<k; j++)
				{
					first[current[j]]=1;
				}
			}
			else
			{
				for(j=0; j<k; j++)
				{
					first[current[j]]=-1;
				}
			}
			
		}
	}
	
	for(i=0; i<1000; i++)
	{
		if(first[i]==1) printf("%d", first[i]);
	}
	
	fclose(fp);
	return 0;
	
}
