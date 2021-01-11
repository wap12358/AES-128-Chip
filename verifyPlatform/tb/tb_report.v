//File name  :    tb_report.v
//Author     :    wap12358
//Time       :    2021/01/11 15:38:05
//Abstract   :        

`timescale 1ns/1ns

module tb_report();

//Define parameters:
parameter CLK_FREQ = 50_000_000;
parameter REPORT_FREQ = 100;
parameter UART_BPS = 115200;

reg                 clk, rst_n;


//Define signals:
reg     [31: 0]     total;

//UART report
wire    [ 7: 0]     data;
wire                require, valid;



//Edit code:
always #5 clk = ~clk;

initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    total = 'd0;
    #13
    rst_n = 1'b1;
end

always #7282 total <= total + 1'b1;

report_ascii#(
    .CLK_FREQ(CLK_FREQ),
    .REPORT_FREQ(REPORT_FREQ)
)report_ascii(
    .clk(clk),
    .rst_n(rst_n),
    .total(total),
    .correct(total),
    .data(data),
    .require(require),
    .valid(valid)
);

uart_tx#(
    .CLK_FREQ(CLK_FREQ),
    .UART_BPS(UART_BPS)
)uart_tx(
    .clk(clk),
    .rst_n(rst_n),
    .uart_txd(),
    .data(data),
    .require(require),
    .valid(valid)
);

endmodule

