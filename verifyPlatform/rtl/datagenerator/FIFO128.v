`timescale 1ns/1ps

//`define fifo_width 128
//`define fifo_depth 8
//`define fifo_addr 3

module FIFO128
#( 
parameter fifo_addr = 3
)(
    clk, rst_n,
    in_data, in_require, full,
    out_data, out_require, empty
);

//Define parameters:
localparam  fifo_depth = (2 ** fifo_addr);

//Define pins:
input               clk, rst_n;
input               in_require, out_require;
input   [127: 0]    in_data;
output  [127: 0]    out_data;
output              empty, full;

//Define signals:
reg     [127: 0]    data_out_reg;

reg     [127: 0]            ram [fifo_depth-1:0];
reg     [fifo_addr-1:0]     wr_ptr, rd_ptr;
reg     [fifo_addr-1:0]     counter;


//Edit code:
assign  out_data = data_out_reg;

always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        data_out_reg <= 0;
        counter <= 0;
        wr_ptr <= 0;
        rd_ptr <= 0;
    end else begin
        case({in_require,out_require})
        2'b00: begin
            wr_ptr <= wr_ptr;
            rd_ptr <= rd_ptr;
            counter <= counter;
            end
        2'b01: begin
            data_out_reg <= ram[rd_ptr];
            counter <= counter - 1'b1;
            rd_ptr <= rd_ptr + 1'b1;
            end
        2'b10: begin
        	ram[wr_ptr] <= in_data;
            counter <= counter + 1'b1;
        	wr_ptr <= wr_ptr + 1'b1;
            end
        2'b11: begin
            data_out_reg <= ram[rd_ptr];
            rd_ptr <= rd_ptr + 1'b1;
        	ram[wr_ptr] <= in_data;
        	wr_ptr <= wr_ptr + 1'b1;
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

