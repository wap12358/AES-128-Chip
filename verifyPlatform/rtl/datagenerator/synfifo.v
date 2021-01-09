//File name  :    synfifo.v
//Author     :    xiaocuicui
//Time       :    2021/01/09 15:41:17
//Version    :    V1.0
//Abstract   :        


`timescale 1ns/1ps

`define fifo_width 128;
`define fifo_depth 8;
`define fifo_addr 3;

module synfifo(clk,rst
               wr_en,rd_en,
               data_in,data_out,
               empty,full);

//Define parameters:
// parameter fifo_width = 128;
// parameter fifo_depth = 8;

//Define pins:
input clk;
input rst;
input wr_en,rd_en;
input  [fifo_width-1'b1:0] data_in;
output wire empty,full;
output wire [fifo_width-1'b1:0] data_out;

reg [fifo_width-1'b1:0] data_out_reg;
assign data_out = data_out_reg;

//Define signals:
reg    [fifo_width-1'b1:0] ram [fifo_depth-1'b1:0];
reg    [fifo_addr-1'b1:0] wr_ptr,rd_ptr;
reg    [fifo_addr-1'b1:0] counter;


//Edit code:
always@(posedge clk or negedge rst) begin
if(!rst) begin
data_out_reg <= 0;
counter <= 0;
wr_ptr <= 0;
rd_ptr <= 0;

end
else begin

case({wr_en,rd_en})
2'b00: begin
    wr_ptr <= wr_ptr;
    rd_ptr <= rd_ptr;
    counter <= counter;
end
2'b01: begin
    data_out_reg <= ram[rd_ptr];
    counter <= counter - 1'b1;
    rd_ptr <= (rd_ptr == fifo_depth-1'b1)?'d0:rd_ptr+1'b1;
end
2'b10: begin
	ram[wr_ptr] <= data_in;
    counter <= counter + 1'b1;
	wr_ptr <= (wr_ptr == fifo_depth-1'b1)?'d0:wr_ptr+1'b1;
end
2'b11: begin
    data_out_reg <= ram[rd_ptr];
    rd_ptr <= (rd_ptr == fifo_depth-1'b1)?'d0:rd_ptr+1'b1;
	ram[wr_ptr] <= data_in;
	wr_ptr <= (wr_ptr == fifo_depth-1'b1)?'d0:wr_ptr+1'b1;
    counter <= counter;
end
default: begin
    wr_ptr <= wr_ptr;
    rd_ptr <= rd_ptr;
    counter <= counter;
end
endcase


end //the end of biggest if
end //the end of always


assign empty = (counter == 'd0)?1'b1:1'b0;
assign full = (counter == fifo_depth-1'b1)?1'b1:1'b0;


endmodule

