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
    
    ,output clkout//debug用
    ,output reg [2:0]state_small
    );
    wire clk1,clk2,reset;
    reg [1:0] state_big = 0,state_big_next=0,state_small_next=0;//, state_small = 0;//大显示周期（clk1, 移动速率），小显示周期（clk2, 显示当前4位数码）
    reg [7:0] num1=0,num2=0,num3=0,num4=0;
    reg [119:0]string={8'b11011010,8'b11111100, 8'b01100000 ,8'b11110110,
                       8'b00000000,8'b11111100, 8'b01100110, 8'b00000000,
                       8'b11011010,8'b11110110, 8'b00000000, 8'b01111010,
                       8'b01111010,8'b00011100, 8'b00000000};//储存显示字符串对应7段管编码
    parameter SIZE = 8;//位宽
    
    freqdiv_half_Hz fd1(fastclk,1'b0,clk1);//周期 1 s
    assign clkout = clk2;
    freqdiv_for_mux fd2(fastclk,clk2);//刷新频率
    debounce2 bt1(fastclk ,resetin, reset);
    ///// global reset -- 100MHz ////
      always@(posedge fastclk)begin
         if(reset)begin
          state_big <= 4'b0;
          state_small <= 4'b0;
           num1 <= 8'b0;
           num2 <= 8'b0;
           num3 <= 8'b0;
           num4 <= 8'b0;
           end
        end
///////// unconditional state change for big cycle -- 0.5Hz ////////
    always@(*)begin
       if(state_big == 1 )begin//先做2个测试一下
         state_big_next <= 0;
         end
       else
           state_big_next <= state_big + 1;
      end
always@(posedge clk1)begin  state_big <= state_big_next; end
///////// unconditional state change for samll cycle -- 2000Hz ////////////
  always@(*)begin
        if(state_small == 3 )begin
          state_small_next <= 0;
          end
        else
            state_small_next <= state_small + 1;
    end
    always@(posedge clk2)begin state_small <= state_small_next; end
   ////// combinational part for every small cycle ///////
   always@(*)begin
     case(state_small)
        0:begin select <= 4'b1000; hex_display <= num1; end
        1:begin select <= 4'b0100; hex_display <= num2; end
        2:begin select <= 4'b0010; hex_display <= num3; end
        3:begin select <= 4'b0001; hex_display <= num4; end
        default: select <= 4'b0000;
     endcase
   end
  
    
 ////// combinational part for big cycle ///////
 always@(*)begin
   case(state_big)      
      0:begin  num1 <= 8'b11011010;
      num2 <= 8'b11111100;
      num3 <= 8'b01100000;
      num4 <= 8'b11110110;end
      1:begin  num1 <= 8'b11111100;
            num2 <= 8'b01100000;
            num3 <= 8'b11110110;
            num4 <= 8'b00000000;end
//      2:begin  num4 <= string[11*SIZE-1:10*SIZE];
//                  num1 <= string[14*SIZE-1:13*SIZE];
//                  num2 <= string[13*SIZE-1:12*SIZE];
//                  num3 <= string[12*SIZE-1:11*SIZE];end
//      3:begin  num3 <= string[11*SIZE-1:10*SIZE];
//                        num4 <= string[10*SIZE-1:9*SIZE];
//                        num1 <= string[13*SIZE-1:12*SIZE];
//                        num2 <= string[12*SIZE-1:11*SIZE];end
//      4:begin  num2 <= string[11*SIZE-1:10*SIZE];
//                num3 <= string[10*SIZE-1:9*SIZE];
//                num4 <= string[9*SIZE-1:8*SIZE];
//               num1 <= string[12*SIZE-1:11*SIZE];end
//      5:begin  num1 <= string[11*SIZE-1:10*SIZE];
//             num2 <= string[10*SIZE-1:9*SIZE];
//             num3<= string[9*SIZE-1:8*SIZE];
//            num4<= string[8*SIZE-1:7*SIZE];end
//      6:
//      7:
//      8:
//      9:
//      10:
//      11:
//      12:
//      13:
//      14:
//      15:
      default:begin
                 num1 <= 8'b0;
                 num2 <= 8'b0;
                 num3 <= 8'b0;
                 num4 <= 8'b0;
                 end
   endcase
   
 end

 
 
endmodule
