//File name  :    top.v
//Author     :    wap12358
//Time       :    2021/01/09 15:28:13
//Abstract   :        

`timescale 1ns/1ps

module top(
    clk, clk_tx, rst_n,
    enc, work, sel,
    key, write_key,
    cpu_wr_tx_data, cpu_wr_tx_require,
    total, correct,
    aes_tx, aes_rx
);

//Define pins:
input               clk, clk_tx, rst_n;
input               enc, work, sel;
input   [127: 0]    key;
input               write_key;
input   [ 31: 0]    cpu_wr_tx_data;
input               cpu_wr_tx_require;
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

wire                asyfifo_full, asyfifo_wr_require;
wire    [ 31: 0]    asyfifo_wr_data;


//Edit code:

datagenerator datagenerator(
    .clk(clk),
    .rst_n(rst_n),
    .enc(enc),
    .work(work),
    .key(key),
    .write_key(write_key),
    .data_require(generator_data_fifo_require),
    .data(generator_data_fifo_data),
    .data_empty(generator_data_fifo_empty),
    .result_require(generator_result_fifo_require),
    .result(generator_result_fifo_data)
    //.result_empty()
);

mux mux(
    .clk(clk),
    .rst_n(rst_n),
    .sel(sel),
    .cpu_wr_tx_data(cpu_wr_tx_data),
    .cpu_wr_tx_require(cpu_wr_tx_require),
    .data_data(generator_data_fifo_data),
    .data_require(generator_data_fifo_require),
    .data_empty(generator_data_fifo_empty),
    .tx_data(asyfifo_wr_data),
    .tx_requre(asyfifo_wr_require),
    .full(asyfifo_full)
);

asyfifo asyfifo(
    .wclk(clk),
    .rclk(clk_tx),
    .arst_n(rst_n),
    .wdv(asyfifo_wr_require),
    .wdata(asyfifo_wr_data),
    .wfull(asyfifo_full),
    .rrq(aes_tx_require),
    .rdata(aes_tx_data),
    .rempty(aes_tx_empty)
);

aes_tx aes_tx_module(
    .clk(clk_tx),
    .rst_n(rst_n),
    .data(aes_tx_data),
    .empty(aes_tx_empty),
    .require(aes_tx_require),
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

