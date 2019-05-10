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
    reg [1:0]state_small=0;
    reg [3:0] state_big=0;
    
    freqdiv_half_Hz fd1(fastclk,clk1);//周期 2 s

    freqdiv_for_mux fd2(fastclk,clk2);//刷新频率,周期 2ms
    debounce2 bt1(fastclk ,resetin, reset);

always@(posedge clk1 or posedge reset)begin
  state_big = (state_big==15 || reset) ? 0 : (state_big+1);
end

 always@(posedge clk2)begin
case(state_big)
 0:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b11011010; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b11111100; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b01100000; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b11110110; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 1:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b11111100; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b01100000; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b11110110; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b00000000; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 2:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b01100000; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b11110110; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b00000000; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b11111100; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 3:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b11110110; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b00000000; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b11111100; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b01100110; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 4:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b00000000; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b11111100; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b01100110; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b00000000; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 5:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b11111100; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b01100110; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b00000000; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b11011010; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 6:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b01100110; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b00000000; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b11011010; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b11110110; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 7:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b00000000; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b11011010; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b11110110; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b00000000; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 8:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b11011010; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b11110110; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b00000000; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b01111010; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 9:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b11110110; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b00000000; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b01111010; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b01111010; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 10:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b00000000; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b01111010; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b01111010; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b00011100; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 11:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b01111010; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b01111010; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b00011100; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b00000000; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 12:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b01111010; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b00011100; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b00000000; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b00000000; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 13:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b00011100; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b00000000; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b00000000; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b11011010; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 14:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b00000000; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b00000000; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b11011010; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b11111100; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 15:begin case(state_small)
 2'b00:begin select <= 4'b1000; hex_display <= 8'b00000000; state_small <= 2'b01;end
 2'b01:begin select <= 4'b0100; hex_display <= 8'b11011010; state_small <= 2'b10;end
 2'b10:begin select <= 4'b0010; hex_display <= 8'b11111100; state_small <= 2'b11;end
 2'b11:begin select <= 4'b0001; hex_display <= 8'b01100000; state_small <= 2'b00;end
 default: state_small<=2'b00;//回到初始状态
 endcase
 end
 
 endcase
end

endmodule
