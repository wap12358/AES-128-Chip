//File name  :    top.v
//Author     :    wap12358
//Time       :    2021/01/11 10:14:46
//Abstract   :        

`timescale 1ns/10ps

module top(
    clk, rst_n,
    work,
    total, correct
);

//Define pins:
input               clk, rst_n;
input               work;
output  [31: 0]     total, correct;


//Define signals:
wire    [ 8: 0]     aes_tx, aes_rx;
wire                clk_chip, rst_n_chip;

//Edit code:
platformTop#(
    .CLK_FREQ(50_000_000),
    .CHIP_CLK_FREQ(1_000_000),
    .AES_TX_FREQ(50_000)
)platformTop(
    .clk(clk),
    .rst_n(rst_n),
    .clk_chip(clk_chip),
    .rst_n_chip(rst_n_chip),
    .work(work),
    .total(total),
    .correct(correct),
    .aes_tx(aes_tx),
    .aes_rx(aes_rx)
);

aes_top aes_top(
    .clk(clk_chip),
    .rst(rst_n_chip),
    .cu(1'b0),
    .id(1'b0),
	.user_data(aes_tx[7:0]),
    .shi(aes_tx[8]),
    .chip_data(aes_rx[7:0]),
    .sho(aes_rx[8])
);





endmodule

