module uart_tx#(
    parameter  CLK_FREQ = 50_000_000,
    parameter  UART_BPS = 115200
)(
    clk, rst_n,
    uart_txd,
    data, require, valid
);

//Basic signals
input           clk, rst_n;

//uart interface
output reg      uart_txd;

//Data interface
input   [7:0]   data;
output reg      require;
input           valid;

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

//Define registers
reg     [COUNTER_WIDTH-1: 0]    bps_counter;
reg     [ 4: 0]                 tx_cnt;
reg     [ 7: 0]                 tx_data;

// Data Interface Logic
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        tx_data <= 8'd0;
        require <= 1'b0;
    end else begin
        if ( require & valid ) begin
            tx_data <= data;
            require <= 1'b0;
        end else begin
            require <= ( tx_cnt == 4'h0 ) ? 1'b1 : 1'b0 ; // valid when UART IDLE
        end
    end
end


// UART Logic
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        tx_cnt <= 4'd0;
    end else begin
        if ( ( tx_cnt == 4'h0 ) & require & valid ) begin
            tx_cnt <= 4'd1;
        end else if ( tx_cnt == 4'ha ) begin
            tx_cnt <= ( bps_counter == BPS_CNT ) ? 4'h0 : tx_cnt;
        end else begin
            tx_cnt <= ( bps_counter == BPS_CNT ) ? tx_cnt + 1'b1 : tx_cnt;
        end
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        bps_counter <= 'd0;
    end else begin
        bps_counter <= ( |tx_cnt & ( bps_counter != BPS_CNT ) ) ? bps_counter + 1'b1 : 'd0 ;
    end
end

always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        uart_txd <= 1'b1;
    end else begin
        case(tx_cnt)
            4'h1: uart_txd <= 1'b0;
            4'h2: uart_txd <= tx_data[0];
            4'h3: uart_txd <= tx_data[1];
            4'h4: uart_txd <= tx_data[2];
            4'h5: uart_txd <= tx_data[3];
            4'h6: uart_txd <= tx_data[4];
            4'h7: uart_txd <= tx_data[5];
            4'h8: uart_txd <= tx_data[6];
            4'h9: uart_txd <= tx_data[7];
            4'ha: uart_txd <= 1'b1;
            default: ;
        endcase
    end
end

endmodule