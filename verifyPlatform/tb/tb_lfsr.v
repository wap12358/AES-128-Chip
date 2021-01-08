`timescale 1ns/1ps

module tb_lfsr();

reg   clk, rst_n, require;

initial begin
    clk = 1'b1;
    rst_n = 1'b0;
    require = 1'b1;
    #13
    rst_n = 1'b1;
    #54
    require = 1'b0;
    #57
    require = 1'b1;
end

always #5 clk = ~clk;

lfsr lfsr(
    .clk(clk), 
    .rst_n(rst_n),
    .require(require),
    .random128()
);

endmodule

