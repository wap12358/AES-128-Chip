//File name  :    mux.v
//Author     :    wap12358
//Time       :    2021/01/09 23:09:39
//Abstract   :        

`timescale 1ns/1ps

module mux(
    clk, rst_n, sel,
    cpu_wr_tx_data, cpu_wr_tx_require,
    data_data, data_require, data_empty,
    tx_data, tx_requre, full
);

//Define pins:
input                   clk, rst_n, sel;
input       [ 31: 0]    cpu_wr_tx_data;
input                   cpu_wr_tx_require;
input       [127: 0]    data_data;
output reg              data_require;
input                   data_empty;
output reg  [ 31: 0]    tx_data;
output reg              tx_requre;
input                   full;

//Define registers:

//Define FSM:
reg     [  2: 0]    current_state, next_state;
parameter IDLE  = 3'b000;
parameter CPU   = 3'b001;
parameter D3    = 3'b100;
parameter D2    = 3'b101;
parameter D1    = 3'b110;
parameter D0    = 3'b111;

//Edit code:

always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        current_state <= IDLE;
    end else begin
        current_state <= next_state; 
    end
end

always @* begin
    next_state = IDLE;
    case (current_state)
        IDLE: begin
            next_state = sel ? CPU : D3 ;
        end
        CPU: begin
            next_state = sel ? CPU : IDLE ;
        end
        D3: begin
            next_state = (         sel         ) ? IDLE :
                         ( ~data_empty & ~full ) ?  D2  : D3 ;
        end
        D2: begin
            next_state = ( full ) ? D2 : D1 ;
        end
        D1: begin
            next_state = ( full ) ? D1 : D0 ;
        end
        D0: begin
            next_state = ( full ) ? D0 : D3 ;
        end
        default: next_state = IDLE;
    endcase
end

always @* begin
    tx_data = 32'h0;
    tx_requre = 1'b0;
    case (current_state)
        IDLE: begin
            tx_data = 32'h0;
            tx_requre = 1'b0;
        end
        CPU: begin
            tx_data = cpu_wr_tx_data;
            tx_requre = cpu_wr_tx_require & ~full;
        end
        D3: begin
            tx_data = data_data[127:96];
            tx_requre = ~data_empty & ~full;
        end
        D2: begin
            tx_data = data_data[95:64];
            tx_requre = ~full;
        end
        D1: begin
            tx_data = data_data[63:32];
            tx_requre = ~full;
        end
        D0: begin
            tx_data = data_data[31:0];
            tx_requre = ~full;
        end
        default: begin
            tx_data = 32'h0;
            tx_requre = 1'b0;
        end
    endcase
end

always @* begin
    if ( current_state == D0 ) begin
        data_require = ~full;
    end else begin
        data_require = 1'b0;
    end
end




endmodule

