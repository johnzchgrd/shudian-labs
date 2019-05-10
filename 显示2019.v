module display_circular( 
    input fastclk,//100MHz时钟
   // input resetin,//复位信号
    output reg [3:0] select,//4个中选哪个的选择信号，选左边4个
    output reg [7:0] hex_display//7段管显示输出
    
	,output clkdebug
	,output [1:0]state
    );
    wire clk1,clk2,reset;
    reg [1:0]state_small=0;
    
    freqdiv_half_Hz fd1(fastclk,clk1);//周期 1 s

    freqdiv_for_mux fd2(fastclk,clk2);//刷新频率,周期 2ms
   // debounce2 bt1(fastclk ,resetin, reset);
	
assign clkdebug=clk2;
assign state=state_small;

 always@(posedge clk2)begin
   case(state_small)
	   2'b00:begin select <= 4'b1000; hex_display <= 8'b11011010; state_small<=2'b01; end
	   2'b01:begin select <= 4'b0100; hex_display <= 8'b11111100; state_small<=2'b10; end
	   2'b10:begin select <= 4'b0010; hex_display <= 8'b01100000; state_small<=2'b11; end
	   2'b11:begin select <= 4'b0001; hex_display <= 8'b11110110; state_small<=2'b00; end
	   default: state_small<=2'b00;//回到初始状态
   endcase
end

endmodule
