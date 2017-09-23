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
	int sq[11];
	int dif[10];
	int dif1[11];
	int c=a;
	
	int sum=0;
	for (i=0; i<10; i++)
	{
		temp_number[i]=0;
		sq[i]=i*i; 								//make the squares of digits 0-9
		number[i]=a % (10);
		a = a / 10;
	} 											//get the number divided in digits
	sq[10]=0;
	
	//find for all numbers that digits<=3 if they are happy
	
	for(i=0; i<730; i++) 
	{
		first[i]=0;
		current[i]=0;
	}                                           //initialization
	first[0]=-1;
	
	for(i=1; i<730; i++)
	{
		if(first[i]==0)							//an den exei elegxthei
		{
			k=0;								//deikths sthn lista ths akolouthias
			temp=i;
			for(j=0; j<3; j++)
			{
				temp_number[j]=temp % 10;
				temp = temp / 10;
			}
			sum=0;
			current[k]=i;
			k++;
			while(!(sum==1 || sum==4))
			{
				sum=0;
				for(j=0; j<3; j++)
				{
					sum=sum + sq[temp_number[j]];	
				}
				temp=sum;
				for(j=0; j<3; j++)
				{
					temp_number[j]=temp % 10;	//get the next number
					temp = temp / 10;
				}
				current[k]=sum;
				k++;				
			}
			if (sum==1)
			{
				for(j=0; j<k; j++)
				{
					first[(current[j])]=1;
				}
			}
			else
			{
				for(j=0; j<k; j++)
				{
					first[(current[j])]=-1;
				}
			}
			
		}
	}
	// Find how many numbers are in [a,b] all numbers <= 1 000 000 000 in 1 step they turn into a number <= 9*81=729
	sum=0;
	for(k=0; k<10; k++)
	{
		sum=sum + sq[number[k]];
		dif[k]=	sq[k+1]-sq[k];
	}
	
	
	for(j=0; j<((b-c)+1); j++)
	{
		if(first[sum]==1)
		{
			numofhappies ++;
		}
		sum= sum + dif[number[0]];
		number[0] ++;
		
		if(number[0]==10)
		{
		
			for(i=0; i<9; i++)
			{
				if(number[i]==10)
				{
					number[i]=0;
					sum= sum + dif[number[i+1]];
					number[i+1] ++;
				}
				else 
				{
					break;
				}
			}
		}
	}
	printf("%d", numofhappies);
	fclose(fp);
	return 0;
	
}
