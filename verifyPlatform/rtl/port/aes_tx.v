//File name  :    aes_tx.v
//Author     :    wap12358
//Time       :    2021/01/09 00:33:53
//Abstract   :        

`timescale 1ns/1ps

module aes_tx(
    clk, rst_n, en,
    data, empty, require,
    shakehand, tx
);

//Define pins:
input               clk, rst_n;
input   [127: 0]    data;
input               empty;
output reg          require;
output              shakehand;
output  [  7: 0]    tx;


//Define signals:
reg     [  3: 0]    counter;
reg     [ 31: 0]    data_tmp;

//Edit code:
assign shakehand = counter[0];
assign tx = data_tmp[(8*(15-counter))+:8];

always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        counter <= 4'd15;
        data_tmp <= 32'h0;
        require <= 1'b0;
    end else if (en) begin
        if ( &counter ) begin
            counter <= empty ? 4'd15 : 4'd0 ;
            data_tmp <= data;
            require <= ~empty;
        end else begin
            counter <= counter + 1'b1;
            require <= 1'b0;
        end
    end else begin
        require <= 1'b0;
    end
end



endmodule

