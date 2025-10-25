`include "mem.v"
module tb;
  parameter WIDTH=8;
  parameter DEPTH=256;
  parameter ADDR_WIDTH=$clog2(DEPTH);
  reg clk,res,wr_rd,valid;
  reg [ADDR_WIDTH-1:0] addr;
  reg [WIDTH-1:0] wdata;
  wire [WIDTH-1:0] rdata;
  wire ready;
  reg [20*8-1:0]test_name;

mem dut(.clk(clk),.res(res),.addr(addr),.wr_rd(wr_rd),.wdata(wdata),.rdata(rdata),.valid(valid),.ready(ready));
  reg [WIDTH-1:0] exp_data[0:15];
  reg [ADDR_WIDTH-1:0] iden_addr[0:15];
  integer i;

  always #5 clk=~clk;
initial begin
    clk=0;
    res=1;
    $value$plusargs("test_name=%s",test_name);
    reset();
    #3 res=0;
    for(i=0;i<8;i=i+1)
      iden_addr[i]=8'b0000_0001<<i;
    for(i=0;i<8;i=i+1)
      iden_addr[i+8]=~(8'b0000_0001<<i);
 
case(test_name)
      "1_WR_RD": begin
        for(i=0;i<16;i=i+1) begin
          exp_data[i]=$urandom_range(10,200);
          write(iden_addr[i],exp_data[i]);
          readch(iden_addr[i],exp_data[i]);
        end
      end

      "ALL_LOC": begin
        for(i=0;i<16;i=i+1) begin
          exp_data[i]=$urandom_range(10,200);
          write(iden_addr[i],exp_data[i]);
        end
        for(i=0;i<16;i=i+1)
          readch(iden_addr[i],exp_data[i]);
        end

     "MIXED_WR_RD": begin
 		for(i=0;i<4;i=i+1) begin
    		exp_data[i]=$urandom_range(10,200);
    		write(iden_addr[i],exp_data[i]);
  		end
 		for(i=0;i<2;i=i+1)
    		readch(iden_addr[i],exp_data[i]);
		for(i=4;i<10;i=i+1) begin
    		exp_data[i]=$urandom_range(10,200);
    		write(iden_addr[i],exp_data[i]);
  		end
		for(i=2;i<10;i=i+1)
    		readch(iden_addr[i],exp_data[i]);
		end 
endcase
end

initial begin
    #3000;
    $finish;
end
task reset(); begin
    wr_rd=0;
    wdata=0;
    addr=0;
    valid=0;
  end
endtask

task write(input [ADDR_WIDTH-1:0]addr_i,input [WIDTH-1:0] data_i); begin
    @(posedge clk);
    wr_rd=1;
    addr=addr_i;
    wdata=data_i;
    valid=1;
    wait(ready==1);
    @(posedge clk);
    wr_rd=0;
    valid=0;
    addr=0;
    wdata=0;
  end
endtask

task readch(input [ADDR_WIDTH-1:0] addr_i,input [WIDTH-1:0]exp); begin
    @(posedge clk);
    wr_rd=0;
    addr=addr_i;
    valid=1;
    wait(ready==1);
    @(posedge clk);
    if(rdata===exp)
      $display("PASS:addr=%h wdata=%h rdata=%h",addr_i,exp,rdata);
    else
      $display("FAIL:addr=%h expected=%h rdata=%h",addr_i,exp,rdata);
    valid=0;
    addr=0;
  end
endtask
endmodule

