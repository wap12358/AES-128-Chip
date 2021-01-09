//File name  :    tb_FIFO128.v
//Author     :    xiaocuicui
//Time       :    2021/01/09 16:11:21
//Version    :    V1.0
//Abstract   :        


`timescale 1ns/1ps

`define fifo_width 128
`define fifo_depth 8
`define fifo_addr 3


module synfifo_tst();

reg clk,rst;
reg wr_en,rd_en;
reg [`fifo_width-1'b1:0] data_in;
wire empty,full;
wire [`fifo_width-1'b1:0] data_out;

FIFO128 i1(
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .data_in(data_in),
    .data_out(data_out),
    .empty(empty),
    .full(full)
);


initial
begin
clk = 0;
rst = 0;
data_in = 'd0;  
wr_en = 0;
rd_en = 0;
$display("Running testbench");
#20
rst = 1; 
#50
wr_en = 1;
#500
wr_en = 0;
rd_en = 1;
#500
wr_en = 0;
rd_en = 0;
#100
wr_en = 1;
rd_en = 1;
#500
$display("Finish testbench");
$stop;            
end


always #5 clk = ~clk;    
always #20 data_in = data_in + 1'b1;

endmodule

