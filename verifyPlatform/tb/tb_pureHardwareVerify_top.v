//File name  :    tb_pureHardwareVerify_top.v
//Author     :    wap12358
//Time       :    2021/01/11 10:24:41
//Abstract   :        

`timescale 1ns/1ps

module tb_pureHardwareVerify_top();

//Define pins:
reg   clk, rst_n, work;


//Define signals:


//Define parameters:


//Edit code:
always #5 clk = ~clk;

initial begin
    clk = 1'b0;
    rst_n = 1'b0;
    work = 1'b0;
    #13
    rst_n = 1'b1;
    #10000
    work = 1'b1;

end

top top(
    .clk(clk),
    .rst_n(rst_n),
    .work(work),
    .total(),
    .correct()
);





endmodule

