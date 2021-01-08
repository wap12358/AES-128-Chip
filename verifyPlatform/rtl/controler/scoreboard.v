//File name  :    scoreboard.v
//Author     :    wap12358
//Time       :    2021/01/09 00:33:28
//Abstract   :        

`timescale 1ns/1ps

module scoreboard(
    clk, rst_n,
);

//Define pins:
input   clk, rst_n;


//Define signals:


//Define parameters:


//Edit code:
always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin

    end else begin




    end //the end of biggest if
end //the end of always







endmodule

