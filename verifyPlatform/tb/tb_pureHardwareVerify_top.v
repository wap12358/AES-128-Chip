//File name  :    tb_pureHardwareVerify_top.v
//Author     :    wap12358
//Time       :    2021/01/11 10:24:41
//Abstract   :        

`timescale 1ns/10ps

module tb_pureHardwareVerify_top();

// define stimulate
reg   clk, rst_n, work, enc;


//Define signals:
wire    [ 8: 0]     aes_tx, aes_rx;
wire                clk_chip, rst_n_chip;


//Define parameters:


//Edit code:
always #5 clk = ~clk;

initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    work = 1'b0;
    enc = 1'b1;
    #1003
    rst_n = 1'b1;
    #50003
    work = 1'b1;

end

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
    .enc(enc),
    .total(),
    .correct(),
    .aes_tx(aes_tx),
    .aes_rx(aes_rx)
);

aes_top aes_top(
    .clk(clk_chip), 
    .rst(rst_n_chip),
    .cu(1'b0),
    .id(enc),
	.user_data(aes_tx[7:0]),
    .shi(aes_tx[8]),
    .chip_data(aes_rx[7:0]),
    .sho(aes_rx[8])
);



endmodule

