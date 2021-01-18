`timescale 1ns/1ps

module uart_rx#(
    parameter  CLK_FREQ = 50_000_000,
    parameter  UART_BPS = 115200
)(
    clk, rst_n,
    uart_rxd,
    work, enc
);

//Basic signals
input           clk, rst_n;
input           uart_rxd;
output reg      work, enc;

//Define functions
function integer clog2;
    input integer value;
        begin
            value = value-1;
        for (clog2=0; value>0; clog2=clog2+1)
            value = value>>1;
    end
endfunction

//Define parameters
localparam BPS_CNT  = CLK_FREQ/UART_BPS;
localparam COUNTER_WIDTH =$clog2(BPS_CNT);
localparam IDLE = 'd0;

//Define registers
reg     [COUNTER_WIDTH-1: 0]    bps_counter;
reg     [ 4: 0]                 rx_cnt;
reg     [ 7: 0]                 rx_data;
reg                             rx_valid;

// UART Logic
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rx_cnt <= 4'd0;
    end else begin
        if ( rx_cnt == 4'h0 ) begin
            rx_cnt <= uart_rxd ? 4'd0 : 4'd1;
        end else if ( rx_cnt == 4'ha ) begin
            rx_cnt <= ( bps_counter == BPS_CNT ) ? 4'h0 : rx_cnt;
        end else begin
            rx_cnt <= ( bps_counter == BPS_CNT ) ? rx_cnt + 1'b1 : rx_cnt;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        bps_counter <= 'd0;
    end else begin
        bps_counter <= ( |rx_cnt & ( bps_counter != BPS_CNT ) ) ? bps_counter + 1'b1 : 'd0 ;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rx_data <= 8'b0;
    end else if ( bps_counter == BPS_CNT / 2 ) begin
        rx_valid <= 1'b0;
        case(rx_cnt)
            //4'h1: uart_rxd <= 1'b0;
            4'h2: rx_data[0] <= uart_rxd;
            4'h3: rx_data[1] <= uart_rxd;
            4'h4: rx_data[2] <= uart_rxd;
            4'h5: rx_data[3] <= uart_rxd;
            4'h6: rx_data[4] <= uart_rxd;
            4'h7: rx_data[5] <= uart_rxd;
            4'h8: rx_data[6] <= uart_rxd;
            4'h9: rx_data[7] <= uart_rxd;
            4'ha: rx_valid <= 1'b1;
            default: ;
        endcase
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        work <= 1'd0;
        enc  <= 1'd1;
    end else if ( rx_valid ) begin
        case ( rx_data )
            "W": work <= 1'd1;
            "S": work <= 1'd0;
            "E": enc  <= 1'd1;
            "D": enc  <= 1'd0;
            default:;
        endcase
    end
end

endmodule