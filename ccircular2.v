`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 22:01:37
// Design Name: 
// Module Name: display_circular
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module display_circular( 
    input fastclk,//100MHz时钟
    input resetin,//复位信号
    output reg [3:0] select,//4个中选哪个的选择信号，选左边4个
    output reg [7:0] hex_display//7段管显示输出
  
    );
    wire clk1,clk2,reset;
    reg [3:0] state_big = 0,state_big_next=0;
    reg [1:0]state_small=0,state_small_next=0;//, state_small = 0;//大显示周期（clk1, 移动速率），小显示周期（clk2, 显示当前4位数码）
    
    freqdiv_half_Hz fd1(fastclk,1'b0,clk1);//周期 1 s

    freqdiv_for_mux fd2(fastclk,clk2);//刷新频率,周期 2ms
    debounce2 bt1(fastclk ,resetin, reset);
    ///// global reset -- 100MHz ////
      always@(posedge fastclk)begin
         if(reset)begin
          state_big <= 2'b00;
          state_small <= 2'b00;
          hex_display <= 8'b00000000;
           end
        end
///////// unconditional state change for big cycle -- 0.5Hz ////////
    always@(*)begin
       state_big_next = (state_big==15) ? 0 : (state_big + 1);
      end

///////// unconditional state change for samll cycle -- 2000Hz ////////////
  always@(*)begin
       state_small_next = (state_small == 3) ? 0 : (state_small + 1);
      end

    always@(posedge clk1)begin  state_big <= state_big_next; end
 ////// combinational part for big cycle ///////
 always@(posedge clk2)begin
   case(state_big)      
 0:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b11011010; end
   1:begin select <= 4'b0100; hex_display <= 8'b11111100; end
   2:begin select <= 4'b0010; hex_display <= 8'b01100000; end
   3:begin select <= 4'b0001; hex_display <= 8'b11110110; end
   endcase
   end
   
   1:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b11111100; end
   1:begin select <= 4'b0100; hex_display <= 8'b01100000; end
   2:begin select <= 4'b0010; hex_display <= 8'b11110110; end
   3:begin select <= 4'b0001; hex_display <= 8'b00000000; end
   endcase
   end
   
   2:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b01100000; end
   1:begin select <= 4'b0100; hex_display <= 8'b11110110; end
   2:begin select <= 4'b0010; hex_display <= 8'b00000000; end
   3:begin select <= 4'b0001; hex_display <= 8'b11111100; end
   endcase
   end
   
   3:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b11110110; end
   1:begin select <= 4'b0100; hex_display <= 8'b00000000; end
   2:begin select <= 4'b0010; hex_display <= 8'b11111100; end
   3:begin select <= 4'b0001; hex_display <= 8'b01100110; end
   endcase
   end
   
   4:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b00000000; end
   1:begin select <= 4'b0100; hex_display <= 8'b11111100; end
   2:begin select <= 4'b0010; hex_display <= 8'b01100110; end
   3:begin select <= 4'b0001; hex_display <= 8'b00000000; end
   endcase
   end
   
   5:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b11111100; end
   1:begin select <= 4'b0100; hex_display <= 8'b01100110; end
   2:begin select <= 4'b0010; hex_display <= 8'b00000000; end
   3:begin select <= 4'b0001; hex_display <= 8'b11011010; end
   endcase
   end
   
   6:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b01100110; end
   1:begin select <= 4'b0100; hex_display <= 8'b00000000; end
   2:begin select <= 4'b0010; hex_display <= 8'b11011010; end
   3:begin select <= 4'b0001; hex_display <= 8'b11110110; end
   endcase
   end
   
   7:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b00000000; end
   1:begin select <= 4'b0100; hex_display <= 8'b11011010; end
   2:begin select <= 4'b0010; hex_display <= 8'b11110110; end
   3:begin select <= 4'b0001; hex_display <= 8'b00000000; end
   endcase
   end
   
   8:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b11011010; end
   1:begin select <= 4'b0100; hex_display <= 8'b11110110; end
   2:begin select <= 4'b0010; hex_display <= 8'b00000000; end
   3:begin select <= 4'b0001; hex_display <= 8'b01111010; end
   endcase
   end
   
   9:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b11110110; end
   1:begin select <= 4'b0100; hex_display <= 8'b00000000; end
   2:begin select <= 4'b0010; hex_display <= 8'b01111010; end
   3:begin select <= 4'b0001; hex_display <= 8'b01111010; end
   endcase
   end
   
   10:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b00000000; end
   1:begin select <= 4'b0100; hex_display <= 8'b01111010; end
   2:begin select <= 4'b0010; hex_display <= 8'b01111010; end
   3:begin select <= 4'b0001; hex_display <= 8'b00011100; end
   endcase
   end
   
   11:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b01111010; end
   1:begin select <= 4'b0100; hex_display <= 8'b01111010; end
   2:begin select <= 4'b0010; hex_display <= 8'b00011100; end
   3:begin select <= 4'b0001; hex_display <= 8'b00000000; end
   endcase
   end
   
   12:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b01111010; end
   1:begin select <= 4'b0100; hex_display <= 8'b00011100; end
   2:begin select <= 4'b0010; hex_display <= 8'b00000000; end
   3:begin select <= 4'b0001; hex_display <= 8'b11011010; end
   endcase
   end
   
   13:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b00011100; end
   1:begin select <= 4'b0100; hex_display <= 8'b00000000; end
   2:begin select <= 4'b0010; hex_display <= 8'b11011010; end
   3:begin select <= 4'b0001; hex_display <= 8'b11111100; end
   endcase
   end
   
   14:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b00000000; end
   1:begin select <= 4'b0100; hex_display <= 8'b11011010; end
   2:begin select <= 4'b0010; hex_display <= 8'b11111100; end
   3:begin select <= 4'b0001; hex_display <= 8'b01100000; end
   endcase
   end
   
   15:begin state_small <= state_small_next;
   case(state_small)0:begin select <= 4'b1000; hex_display <= 8'b11011010; end
   1:begin select <= 4'b0100; hex_display <= 8'b11111100; end
   2:begin select <= 4'b0010; hex_display <= 8'b01100000; end
   3:begin select <= 4'b0001; hex_display <= 8'b11110110; end
   endcase
   end
endcase 
end
endmodule
