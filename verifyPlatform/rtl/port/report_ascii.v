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
    error_chip, error_generator,
    data, require, valid,
    work, enc
);

//Define pins:
input   clk, rst_n;

//data source interface
input   [31: 0]     total, correct;

//data output interface
output reg  [ 7: 0]     data;
input                   require;
output reg              valid;
input       [127: 0]    error_chip, error_generator;
input                   work, enc;

//Define functions
function [7:0] ascii ( input [3:0] hex ); begin
    if ( hex < 4'd10 )
        ascii = { 4'b0011, hex };
    else
        ascii = { 5'b0100_0, hex[2:0] - 1'b1 };
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
reg     [  6: 0]    current_state, next_state;
parameter IDLE  = 7'd0;

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
            next_state = ( report_counter == REPORT_COUNT ) ? 7'd1 : IDLE ;
        end
        7'd110: begin
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
        7'd1: data = ascii(report_times[11:8]);
        7'd2: data = ascii(report_times[ 7:4]);
        7'd3: data = ascii(report_times[ 3:0]);
        7'd4: data = " ";
        7'd5: data = "T";
        7'd6: data = "o";
        7'd7: data = "t";
        7'd8: data = "a";
        7'd9: data = "l";
        7'd10: data = ":";
        7'd11: data = " ";
        7'd12: data = ascii(total_reg[31:28]);
        7'd13: data = ascii(total_reg[27:24]);
        7'd14: data = ascii(total_reg[23:20]);
        7'd15: data = ascii(total_reg[19:16]);
        7'd16: data = ascii(total_reg[15:12]);
        7'd17: data = ascii(total_reg[11: 8]);
        7'd18: data = ascii(total_reg[ 7: 4]);
        7'd19: data = ascii(total_reg[ 3: 0]);
        7'd20: data = " ";
        7'd21: data = "C";
        7'd22: data = "o";
        7'd23: data = "r";
        7'd24: data = "r";
        7'd25: data = "e";
        7'd26: data = "c";
        7'd27: data = "t";
        7'd28: data = ":";
        7'd29: data = " ";
        7'd30: data = ascii(correct_reg[31:28]);
        7'd31: data = ascii(correct_reg[27:24]);
        7'd32: data = ascii(correct_reg[23:20]);
        7'd33: data = ascii(correct_reg[19:16]);
        7'd34: data = ascii(correct_reg[15:12]);
        7'd35: data = ascii(correct_reg[11: 8]);
        7'd36: data = ascii(correct_reg[ 7: 4]);
        7'd37: data = ascii(correct_reg[ 3: 0]);
        7'd38: data = " ";
        7'd39: data = enc ? "E" : "D";
        7'd40: data = work ? "W" : " ";
        7'd41: data = "\n";
        7'd42: data = "\r";
        7'd43: data = ascii(error_chip[127:124]);
        7'd44: data = ascii(error_chip[124:120]);
        7'd45: data = ascii(error_chip[119:116]);
        7'd46: data = ascii(error_chip[115:112]);
        7'd47: data = ascii(error_chip[111:108]);
        7'd48: data = ascii(error_chip[107:104]);
        7'd49: data = ascii(error_chip[103:100]);
        7'd50: data = ascii(error_chip[ 99: 96]);
        7'd51: data = ascii(error_chip[ 95: 92]);
        7'd52: data = ascii(error_chip[ 91: 88]);
        7'd53: data = ascii(error_chip[ 87: 84]);
        7'd54: data = ascii(error_chip[ 83: 80]);
        7'd55: data = ascii(error_chip[ 79: 76]);
        7'd56: data = ascii(error_chip[ 75: 72]);
        7'd57: data = ascii(error_chip[ 71: 68]);
        7'd58: data = ascii(error_chip[ 67: 64]);
        7'd59: data = ascii(error_chip[ 63: 60]);
        7'd60: data = ascii(error_chip[ 59: 56]);
        7'd61: data = ascii(error_chip[ 55: 52]);
        7'd62: data = ascii(error_chip[ 51: 48]);
        7'd63: data = ascii(error_chip[ 47: 44]);
        7'd64: data = ascii(error_chip[ 43: 40]);
        7'd65: data = ascii(error_chip[ 39: 36]);
        7'd66: data = ascii(error_chip[ 35: 32]);
        7'd67: data = ascii(error_chip[ 31: 28]);
        7'd68: data = ascii(error_chip[ 27: 24]);
        7'd69: data = ascii(error_chip[ 23: 20]);
        7'd70: data = ascii(error_chip[ 19: 16]);
        7'd71: data = ascii(error_chip[ 15: 12]);
        7'd72: data = ascii(error_chip[ 11:  8]);
        7'd73: data = ascii(error_chip[  7:  4]);
        7'd74: data = ascii(error_chip[  3:  0]);
        7'd75: data = " ";
        7'd76: data = ascii(error_generator[127:124]);
        7'd77: data = ascii(error_generator[124:120]);
        7'd78: data = ascii(error_generator[119:116]);
        7'd79: data = ascii(error_generator[115:112]);
        7'd80: data = ascii(error_generator[111:108]);
        7'd81: data = ascii(error_generator[107:104]);
        7'd82: data = ascii(error_generator[103:100]);
        7'd83: data = ascii(error_generator[ 99: 96]);
        7'd84: data = ascii(error_generator[ 95: 92]);
        7'd85: data = ascii(error_generator[ 91: 88]);
        7'd86: data = ascii(error_generator[ 87: 84]);
        7'd87: data = ascii(error_generator[ 83: 80]);
        7'd88: data = ascii(error_generator[ 79: 76]);
        7'd89: data = ascii(error_generator[ 75: 72]);
        7'd90: data = ascii(error_generator[ 71: 68]);
        7'd91: data = ascii(error_generator[ 67: 64]);
        7'd92: data = ascii(error_generator[ 63: 60]);
        7'd93: data = ascii(error_generator[ 59: 56]);
        7'd94: data = ascii(error_generator[ 55: 52]);
        7'd95: data = ascii(error_generator[ 51: 48]);
        7'd96: data = ascii(error_generator[ 47: 44]);
        7'd97: data = ascii(error_generator[ 43: 40]);
        7'd98: data = ascii(error_generator[ 39: 36]);
        7'd99: data = ascii(error_generator[ 35: 32]);
        7'd100: data = ascii(error_generator[ 31: 28]);
        7'd101: data = ascii(error_generator[ 27: 24]);
        7'd102: data = ascii(error_generator[ 23: 20]);
        7'd103: data = ascii(error_generator[ 19: 16]);
        7'd104: data = ascii(error_generator[ 15: 12]);
        7'd105: data = ascii(error_generator[ 11:  8]);
        7'd106: data = ascii(error_generator[  7:  4]);
        7'd107: data = ascii(error_generator[  3:  0]);
        7'd108: data = {7'b0011_000,work};
        7'd109: data = "\n";
        7'd110: data = "\r";
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

