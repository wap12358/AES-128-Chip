//File name  :    top.v
//Author     :    wap12358
//Time       :    2021/01/09 15:28:13
//Abstract   :        

`timescale 1ns/1ps

module top(
    clk, clk_tx, rst_n,
    uart_tx, uart_rx,
    aes_tx, aes_rx
);

//Define pins:
input           clk, clk_tx, rst_n;
output          uart_tx;
input           uart_rx;
output  [8:0]   aes_tx;
input   [8:0]   aes_rx;



//Define signals:
wire    [127: 0]    generator_data_fifo_data, generator_result_fifo_data;
wire                generator_data_fifo_require, generator_result_fifo_require;
wire                generator_data_fifo_empty;

wire    [127: 0]    aes_result_data;
wire                aes_result_en;


//Edit code:
//always@(posedge clk or negedge rst_n) begin
//    if(~rst_n) begin
//
//    end else begin
//
//
//
//
//    end //the end of biggest if
//end //the end of always

datagenerator datagenerator(
    .clk(clk),
    .rst_n(rst_n),
    .enc(),
    .work(),
    .key(),
    .write_key(),
    .data_require(generator_data_fifo_require),
    .data(generator_data_fifo_data),
    .data_empty(generator_data_fifo_empty),
    .result_require(generator_result_fifo_require),
    .result(generator_result_fifo_data)
    //.result_empty()
);

aes_tx aes_tx_module(
    .clk(clk_tx),
    .rst_n(rst_n),
    .data(),
    .empty(),
    .require(),
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
    .total(),
    .correct(),
    .chip_result(aes_result_data),
    .chip_en(aes_result_en),
    .generator_result(generator_result_fifo_data),
    .generator_require(generator_result_fifo_require)
);

endmodule

