#include<stdio.h>
#define BIGSTATESIZE 16
#define SMALLSTATESIZE 4
main(){
	int i,j;
	char string[][12]={ "8'b11011010",
						"8'b11111100", 
						"8'b01100000",
						"8'b11110110",
						"8'b00000000",
						"8'b11111100",
						"8'b01100110",
						"8'b00000000",
						"8'b11011010",
						"8'b11110110", 
						"8'b00000000", 
						"8'b01111010",
						"8'b01111010",
						"8'b00011100",
						"8'b00000000",
						"8'b00000000"};
	char select4[4][8]={ "4'b1000",
						 "4'b0100",
						 "4'b0010",
						 "4'b0001"};
	char select2[4][6]={"2'b00","2'b01","2'b10","2'b11"};
	
	printf("\n\n\n\ncase(state_big)\n");
	for(i=0;i<BIGSTATESIZE;i++){
		printf("%d:begin case(state_small)\n",i);//大循环第i个case
		for(j=0;j<SMALLSTATESIZE;j++){
			printf("%s:begin ",select2[j%4],j);
		    printf("select <= %s;",select4[j]);
			printf(" hex_display");
			printf(" <= ");
			printf("%s; state_small <= %s;end\n",string[(i+j)%16],select2[(j+1)%4]);
		}
		printf("default: state_small<=2'b00;//回到初始状态\n");
		printf("endcase\nend\n\n");//大循环第i个case结束
	
	}
	printf("endcase");//大循环结束
	return 0;
}




