//design

module freq( clk ,rst,out_clk );
input clk,rst;
output reg out_clk;

always @(posedge clk)
begin
if (rst)
     out_clk <= 1'b0;
else
     out_clk <= ~out_clk;	
end
endmodule
 
//testbench

module tb;
  reg clk,rst;
  wire out_clk;

  freq q1(clk,rst,out_clk);

  initial begin
    clk = 1'b0;
    forever  #1 clk = ~clk;
  end
    initial
      begin

        $monitor($time,"clk=%b rst=%b out_clk = %b",clk,rst,out_clk);

        rst =1;
        #5 rst =0;
        #50 $finish;
      end

  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
    end
endmodule
