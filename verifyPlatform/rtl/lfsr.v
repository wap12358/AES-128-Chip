//File name  :    LFSR.v
//Author     :    wap12358
//Time       :    2021/01/05 22:59:10
//Abstract   :        

`timescale 1ns/1ps

module lfsr(
    clk, rst_n,
    random128
);

//Define pins:
input               clk, rst_n;
output  [127:0]     random128;

//Define signals:
reg     [127:0]     random128_reg;

//Edit code:
always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        random128_reg <= 'd0;
    end else begin
        // random128_reg <= 反馈



    end //the end of biggest if
end //the end of always


endmodule

