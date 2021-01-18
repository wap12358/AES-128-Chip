//File name  :    chip_rst.v
//Author     :    wap12358
//Time       :    2021/01/11 11:59:04
//Abstract   :        

`timescale 1ns/1ps

module chip_rst(
    clk, rst_n,
    chip_rst_n
);

//Define pins:
input       clk, rst_n;
output reg  chip_rst_n;


//Define signals:
reg [7: 0] counter;

//Edit code:
always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        counter <= 16'h0;
        chip_rst_n <= 16'h0;
    end else begin
        counter <= counter + 1'b1;
        chip_rst_n <= ( counter == 'd 1 ) ? 1'b1 : chip_rst_n;
    end //the end of biggest if
end //the end of always







endmodule

