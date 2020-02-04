//design

module d_ff(in,clk,q,qb);
  input in,clk;
  output reg q,qb;
  
  always@(posedge clk or negedge clk)begin
    q=in;
    qb=~q;
  end
endmodule

module dec(rst,clk,count);
  input rst,clk;
  output reg [1:0]count;
  reg q,qb,freq_out;
  
  always@(posedge clk)begin
   
    if(rst)
      count=3'b0;
    else
      count=count+1;
    if(count==2'b11)
      count=2'b00;
     
  end
  
  d_ff eey(.in(count[1]),.clk(clk),.q(q),.qb(qb));
  always@(*)begin

      freq_out=q|count[1];
  end
  
  
endmodule


//testbench

module tb;
  reg rst,clk;
  wire[1:0]count;
  
  dec e(.rst(rst),.clk(clk),.count(count));
   
  initial begin
    clk=0;
    forever #1clk=~clk;
   end
  
  initial begin
    $monitor("Time=%0t  rst=%b  count=%b",$time,rst,count);
    rst=1;
    #5rst=0;
    #30$finish;

  end
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars();
    end
endmodule
