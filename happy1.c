#include <stdio.h>
int main(void)
{
	FILE *fp;
	int a=3;
	int b=1;
	int i=0;
	int j=0;
	int numofhappies=0;
	int temp_number[10];
	int number[10];
	int k=0;
	fp=fopen("hap.txt", "rt");
	fscanf(fp,"%d\n", &a);
	fscanf(fp,"%d\n", &b);
	printf("To diasthma einai %d - %d\n", a, b);
	int sq[10];
	int c=a;
	for (i=0; i<10; i++)
	{
		sq[i]=i*i;
		number[i]=0;
	}
	
	int sum=0;
	for (i=0; i<10; i++)
	{
		number[i]=a % 10;
		a = a / 10;
	}
	
	for(j=0; j<((b-c)+1); j++)
	{
		sum=0;
		for(k=0; k<10; k++)
		{
			sum=sum + sq[number[k]];	
		}
		while(sum>244)
		{
			for (i=0; i<10; i++)
			{
				temp_number[i]=sum % 10;
				sum = sum / 10;
			}
			
			sum=0;
			for(k=0; k<10; k++)
			{
				sum=sum + sq[temp_number[k]];	
			}
		}
		
		i=sum;
		if(i==1|| i==7 || i==10 || i==13 || i==19 || i==23 || i==28 || i==31 || i==32 || i==44 || i==49 || i==68 || i==70 || i==79 || i==82 || i==86 || i==91 || i==94 || i==97 || i==100 || i==103 || i==109 || i==129 || i==130 || i==133 || i==139 || i==167 || i==176 || i==188 || i==190 || i==192 || i==193 || i==203 || i==208 || i==219 || i==226 || i==230 || i==236 || i==239)
		{
			numofhappies ++;
		}
		
		number[0] ++;
		for(i=0; i<10; i++)
		{
			if(number[i]==10)
			{
				number[i]=0;
				number[i+1] ++;
			}
		}
		
	}
	printf("THERE ARE %d HAPPY NUMBERS IN THERE", numofhappies);
	
	fclose(fp);
	return 0;
	
}
