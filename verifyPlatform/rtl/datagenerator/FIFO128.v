//File name  :    FIFO128.v
//Author     :    wap12358
//Time       :    2021/01/08 22:52:36
//Abstract   :        

`timescale 1ns/1ps

module FIFO128(
    clk, rst_n,
    in_data, in_require, full,
    out_data, out_require, empty
);

//Define pins:
input               clk, rst_n;
input   [127: 0]    in_data;
input               in_require;
output              full;
output  [127: 0]    out_data;
output              out_require;
output              empty;

//Define signals:


//Define parameters:


//Edit code:
always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin

    end else begin




    end //the end of biggest if
end //the end of always







endmodule

