//File name  :    report_ascii.v
//Author     :    wap12358
//Time       :    2021/01/11 14:15:51
//Abstract   :        

`timescale 1ns/1ps

module report_ascii#(
    parameter  CLK_FREQ = 50_000_000,
    parameter  REPORT_FREQ = 2
)(
    clk, rst_n,
    total, correct,
    data, require, valid
);

//Define pins:
input   clk, rst_n;

//data source interface
input   [31: 0]     total, correct;

//data output interface
output reg  [ 7: 0]     data;
input                   require;
output reg              valid;

//Define functions
function [7:0] ascii ( input [3:0] hex ); begin
    if ( hex < 4'd10 )
        ascii = { 4'b0011, hex };
    else
        ascii = { 5'b0100_0, hex[2:1] - 1'b1 };
end
endfunction

function integer clog2 (input integer value); begin
    value = value-1;
    for (clog2=0; value>0; clog2=clog2+1)
        value = value>>1;
end
endfunction

//Define parameters
localparam REPORT_COUNT = CLK_FREQ/REPORT_FREQ;
localparam COUNTER_WIDTH = $clog2(REPORT_COUNT);

//Define registers
reg     [11: 0]                 report_times;
reg     [COUNTER_WIDTH-1: 0]    report_counter;
reg     [31: 0]     total_reg, correct_reg;

//Define FSM:
reg     [  5: 0]    current_state, next_state;
parameter IDLE  = 6'd0;

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
            next_state = ( report_counter == REPORT_COUNT ) ? 6'd1 : IDLE ;
        end
        6'd39: begin
            next_state = require ? IDLE : current_state ;
        end
        default: begin
            next_state = require ? current_state + 1'b1 : current_state ;
        end
    endcase
end

always @* begin
    valid = 1'b1;
    data = 8'h0;
    case (current_state)
        IDLE: begin
            data = 8'h0;
            valid = 1'b0;
        end
        6'd1: data = ascii(report_times[11:8]);
        6'd2: data = ascii(report_times[ 7:4]);
        6'd3: data = ascii(report_times[ 3:0]);
        6'd4: data = " ";
        6'd5: data = "t";
        6'd6: data = "o";
        6'd7: data = "t";
        6'd8: data = "a";
        6'd9: data = "l";
        6'd10: data = ":";
        6'd11: data = " ";
        6'd12: data = ascii(total_reg[31:28]);
        6'd13: data = ascii(total_reg[27:24]);
        6'd14: data = ascii(total_reg[23:20]);
        6'd15: data = ascii(total_reg[19:16]);
        6'd16: data = ascii(total_reg[15:12]);
        6'd17: data = ascii(total_reg[11: 8]);
        6'd18: data = ascii(total_reg[ 7: 4]);
        6'd19: data = ascii(total_reg[ 3: 0]);
        6'd20: data = " ";
        6'd21: data = "c";
        6'd22: data = "o";
        6'd23: data = "r";
        6'd24: data = "r";
        6'd25: data = "e";
        6'd26: data = "c";
        6'd27: data = "t";
        6'd28: data = ":";
        6'd29: data = " ";
        6'd30: data = ascii(correct_reg[31:28]);
        6'd31: data = ascii(correct_reg[27:24]);
        6'd32: data = ascii(correct_reg[23:20]);
        6'd33: data = ascii(correct_reg[19:16]);
        6'd34: data = ascii(correct_reg[15:12]);
        6'd35: data = ascii(correct_reg[11: 8]);
        6'd36: data = ascii(correct_reg[ 7: 4]);
        6'd37: data = ascii(correct_reg[ 3: 0]);
        6'd38: data = "\n";
        6'd39: data = "\r";
        default: data = 8'd0;
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        report_counter <= 'd0;
    end else begin
        report_counter <= ( current_state == IDLE ) ? report_counter + 1'b1 : 'd0 ;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        report_times <= 'd0;
        total_reg <= 'h0;
        correct_reg <= 'h0;
    end else begin
        report_times    <= ( report_counter == REPORT_COUNT ) ? report_times + 1'b1 : report_times ;
        total_reg       <= ( report_counter == REPORT_COUNT ) ? total : total_reg ;
        correct_reg     <= ( report_counter == REPORT_COUNT ) ? correct : correct_reg ;
    end
end



endmodule

