//File name  :    aes_rx.v
//Author     :    wap12358
//Time       :    2021/01/09 00:34:05
//Abstract   :        

`timescale 1ns/1ps

module aes_rx(
    clk, rst_n,
    shakehand, rx,
    data, en
);

//Define pins:
input               clk, rst_n;
input               shakehand;
input   [  7: 0]    rx;
output  [127: 0]    data;
output reg          en;

//Define signals:
reg     [127: 0]    data_tmp;
reg     [  3: 0]    counter;
reg                 shakehand_last;


//Edit code:
always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        shakehand_last <= 128'h0;
    end else begin
        shakehand_last <= shakehand;
    end //the end of biggest if
end //the end of always

always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        data_tmp <= 128'h0;
        counter <= 'h0;
    end else if ( ~shakehand_last & shakehand ) begin
        data_tmp[(8*counter)+:8] <= rx;
        counter <= counter + 1'b1;
        en <= &counter;
    end else begin
        en <= 1'b0;
    end //the end of biggest if
end //the end of always

assign data = data_tmp;





endmodule

