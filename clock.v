module Clock(output reg clk);
initial clk = 1'b0;
always #1 clk = ~clk;    
endmodule