//File name  :    clk_div_en.v
//Author     :    wap12358
//Time       :    2021/01/11 09:58:05
//Abstract   :        

`timescale 1ns/1ps

module clk_div_en
#(
    parameter DIV = 16 // This parameter must be greater than or equal to 2
)(
    clk_in, rst_n,
    en
);

//Define pins:
input   clk_in, rst_n;
output  en;

// Define functions:
function integer clog2;
    input integer value;
        begin
        value = value-1;
        for (clog2=0; value>0; clog2=clog2+1)
            value = value>>1;
    end
endfunction

//Define parameters:
parameter   counter_width = $clog2(DIV);

//Define signals:
reg     [counter_width-1:0] counter;


//Edit code:
always@(posedge clk_in or negedge rst_n) begin
    if(~rst_n) begin
        counter <= 'd0;
    end else begin
        counter <= ( counter == ( DIV - 1 ) ) ? 'd0 : counter + 1'b1;
    end //the end of biggest if
end //the end of always


assign en = ( ~|counter ) ? 1'b1 : 1'b0;

endmodule

