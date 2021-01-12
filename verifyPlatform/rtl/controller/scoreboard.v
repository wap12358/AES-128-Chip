//File name  :    scoreboard.v
//Author     :    wap12358
//Time       :    2021/01/09 00:33:28
//Abstract   :        

`timescale 1ns/1ps

module scoreboard(
    clk, rst_n,
    total, correct,
    chip_result, chip_en,
    generator_result, generator_require,
    error_chip, error_generator
);

//Define pins:
input                   clk, rst_n;
output reg  [ 31: 0]    total, correct;
input       [127: 0]    chip_result, generator_result;
input                   chip_en;
output                  generator_require;
output reg  [127: 0]    error_chip, error_generator;

//Define signals:
wire                    equal;


//Edit code:
assign generator_require = chip_en;
assign equal = (chip_result == generator_result);

always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        total <= 32'h0;
        correct <= 32'h0;
        error_chip <= 128'h0;
        error_generator <= 128'h0;
    end else begin
        if (chip_en)begin
            total <= total + 1'b1;
            correct <= equal ? correct + 1'b1 : correct;
            error_chip <= equal ? error_chip : chip_result;
            error_generator <= equal ? error_generator : generator_result;
        end
    end //the end of biggest if
end //the end of always







endmodule

