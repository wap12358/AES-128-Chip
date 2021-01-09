//File name  :    aes_tx.v
//Author     :    wap12358
//Time       :    2021/01/09 00:33:53
//Abstract   :        

`timescale 1ns/1ps

module aes_tx(
    clk, rst_n,
    data, empty, require,
    shakehand, tx
);

//Define pins:
input               clk, rst_n;
input   [31: 0]     data;
input               empty;
output reg          require;
output              shakehand;
output  [ 7: 0]     tx;


//Define signals:
reg     [ 1: 0]     counter;
reg     [31: 0]     data_tmp;

//Edit code:
assign shakehand = counter[0];
assign tx = data_tmp[(8*(3-counter))+:8];

always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        counter <= 2'd3;
    end else begin
        if ( &counter ) begin
            counter <= empty ? 2'd3 : 2'd0 ;
            data_tmp <= data;
            require <= ~empty;
        end else begin
            counter <= counter + 1'b1;
            require <= 1'b0;
        end
    end //the end of biggest if
end //the end of always



endmodule

