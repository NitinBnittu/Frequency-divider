//design

module freq ( clk ,rst,out_clk);
  input clk,rst;
  output reg out_clk;
  parameter N=3; //(N+1)*2 is the nummber of time clock will divide
  reg [N:0]count;
  
  always @(posedge clk or posedge rst)
    begin
      if (rst)begin
        count <= 0;
        out_clk<=0;
      end

      else if(count==N)
        begin
          count<=0;
          out_clk= ~out_clk;	
        end
      
      else
        count=count+1;
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

  
  
  
