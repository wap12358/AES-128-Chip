//File name  :    platformTop.v
//Author     :    wap12358
//Time       :    2021/01/09 15:28:13
//Abstract   :        

`timescale 1ns/1ps

module platformTop
#(
    parameter CLK_FREQ = 50_000_000,
    parameter CHIP_CLK_FREQ = 1_000_000,
    parameter AES_TX_FREQ = 200_000
)(
    clk, rst_n,
    clk_chip, rst_n_chip,
    work, enc,
    //sel,
    //key, write_key,
    //cpu_wr_tx_data, cpu_wr_tx_require,
    total, correct,
    aes_tx, aes_rx
);

//Define pins:
input               clk, rst_n;
output              clk_chip, rst_n_chip;
input               work, enc;
//input               sel;
//input   [127: 0]    key;
//input               write_key;
//input   [ 31: 0]    cpu_wr_tx_data;
//input               cpu_wr_tx_require;
output  [  8: 0]    aes_tx;
input   [  8: 0]    aes_rx;
output  [ 31: 0]    total, correct;



//Define signals:
wire    [127: 0]    generator_data_fifo_data, generator_result_fifo_data;
wire                generator_data_fifo_require, generator_result_fifo_require;
wire                generator_data_fifo_empty;

wire    [127: 0]    aes_result_data;
wire                aes_result_en;

wire    [ 31: 0]    aes_tx_data;
wire                aes_tx_require, aes_tx_empty;
wire                aes_tx_en;

wire                asyfifo_full, asyfifo_wr_require;
wire    [ 31: 0]    asyfifo_wr_data;


//Edit code:

datagenerator datagenerator(
    .clk(clk),
    .rst_n(rst_n),
    .enc(enc),
    .work(work),
    .key(128'hab7240f9_c5e0bb5e_ee8e34b6_bb84cfb0),
    .write_key(1'b0),
    .data_require(generator_data_fifo_require),
    .data(generator_data_fifo_data),
    .data_empty(generator_data_fifo_empty),
    .result_require(generator_result_fifo_require),
    .result(generator_result_fifo_data),
    .result_empty()
);

chip_rst chip_rst(
    .clk(clk),
    .rst_n(rst_n),
    .chip_rst_n(rst_n_chip)
);

clk_div #(.DIV(CLK_FREQ/CHIP_CLK_FREQ)) clk_div(
    .clk_in(clk),
    .rst_n(rst_n),
    .clk_out(clk_chip)
);

clk_div_en #(.DIV(CLK_FREQ/AES_TX_FREQ)) clk_div_en(
    .clk_in(clk),
    .rst_n(rst_n),
    .en(aes_tx_en)
);

aes_tx aes_tx_module(
    .clk(clk),
    .rst_n(rst_n),
    .en(aes_tx_en),
    .data(generator_data_fifo_data),
    .empty(generator_data_fifo_empty),
    .require(generator_data_fifo_require),
    .shakehand(aes_tx[8]),
    .tx(aes_tx[7:0])
);

aes_rx aes_rx_module(
    .clk(clk),
    .rst_n(rst_n),
    .shakehand(aes_rx[8]),
    .rx(aes_rx[7:0]),
    .data(aes_result_data),
    .en(aes_result_en)
);

scoreboard scoreboard(
    .clk(clk),
    .rst_n(rst_n),
    .total(total),
    .correct(correct),
    .chip_result(aes_result_data),
    .chip_en(aes_result_en),
    .generator_result(generator_result_fifo_data),
    .generator_require(generator_result_fifo_require)
);

endmodule

