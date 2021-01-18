//File name  :    FPGAtop.v
//Author     :    wap12358
//Time       :    2021/01/11 10:14:46
//Abstract   :        

`timescale 1ns/1ps

module FPGAtop#(
    parameter CLK_FREQ = 50_000_000,
    parameter REPORT_FREQ = 10,
    parameter UART_BPS = 115200,
    parameter CHIP_CLK_FREQ = 12_500_000,
    parameter AES_TX_FREQ = 7_000_000
)(
    clk, rst_n,
    clk_chip, rst_n_chip,
    cu_chip, id_chip,
    aes_tx, aes_rx,
    uart_tx, uart_rx
);

//Define pins:
input               clk, rst_n;
input               uart_rx;
output              uart_tx;
input   [ 8: 0]     aes_rx;
output  [ 8: 0]     aes_tx;
output              clk_chip, rst_n_chip;
output              cu_chip, id_chip;


//Define signals:
wire                work, enc;
wire    [ 31: 0]    total, correct;
wire    [127: 0]    error_chip, error_generator;
//UART report
wire    [  7: 0]    data;
wire                require, valid;

//Edit code:
assign cu_chip = 1'b1;
assign id_chip = enc;

assign clk_chip = clk;

platformTop#(
    .CLK_FREQ(CLK_FREQ),
    .CHIP_CLK_FREQ(CHIP_CLK_FREQ),
    .AES_TX_FREQ(AES_TX_FREQ)
)platformTop(
    .clk(clk),
    .rst_n(rst_n),
    .clk_chip(),
    .rst_n_chip(rst_n_chip),
    .work(work),
    .enc(enc),
    .total(total),
    .correct(correct),
    .error_chip(error_chip),
    .error_generator(error_generator),
    .aes_tx(aes_tx),
    .aes_rx(aes_rx)
);

report_ascii#(
    .CLK_FREQ(CLK_FREQ),
    .REPORT_FREQ(REPORT_FREQ)
)report_ascii(
    .clk(clk),
    .rst_n(rst_n),
    .total(total),
    .correct(correct),
    .data(data),
    .require(require),
    .valid(valid),
    .error_chip(error_chip),
    .error_generator(error_generator),
    .work(work),
    .enc(enc)
);

uart_tx#(
    .CLK_FREQ(CLK_FREQ),
    .UART_BPS(UART_BPS)
)uart_tx_module(
    .clk(clk),
    .rst_n(rst_n),
    .uart_txd(uart_tx),
    .data(data),
    .require(require),
    .valid(valid)
);

uart_rx#(
    .CLK_FREQ(CLK_FREQ),
    .UART_BPS(UART_BPS)
)uart_rx_module(
    .clk(clk),
    .rst_n(rst_n),
    .uart_rxd(uart_rx),
    .work(work),
    .enc(enc)
);

endmodule

