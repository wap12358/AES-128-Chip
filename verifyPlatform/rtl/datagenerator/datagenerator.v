module datagenerator(
    clk, rst_n,
    enc, work,
    key, write_key,
    data_require, data, data_empty,
    result_require, result, result_empty
);

// pins
input               clk, rst_n;

input               enc;
input               work;

input   [127: 0]    key;
input               write_key;

input               data_require;
output  [127: 0]    data;
output              data_empty;
input               result_require;
output  [127: 0]    result;
output              result_empty;

// signals
wire                result_valid;
wire                require;
wire                data_full;
wire                core_ready;
wire    [127: 0]    random128, result_data;

// registers
reg     [127: 0]    key_tmp;
reg                 key_init;
reg     [127: 0]    data_tmp;
reg                 module_result_valid_tmp;


// write key
always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        key_tmp <= 128'hab7240f9_c5e0bb5e_ee8e34b6_bb84cfb0;
        key_init <= 1'b1;
    end else begin
        if ( write_key ) begin
            key_tmp <= key;
            key_init <= 1'b1;
        end else begin
            key_init <= 1'b0;
        end
    end
end

// data tmp for model
always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        data_tmp <= 128'h0;
        module_result_valid_tmp <= 1'b0;
    end else begin
        data_tmp <= random128;
        module_result_valid_tmp <= result_valid;
    end
end
assign module_result_valid_1period = ( result_valid & ~module_result_valid_tmp );


// core busy
//always@(posedge clk or negedge rst_n) begin
//    if(~rst_n) begin
//        core_busy <= 1'b0;
//    end else begin
//        if ( require ) begin
//            core_busy <= 1'b1;
//        end else if ( result_valid ) begin
//            core_busy <= 1'b0;
//        end
//    end
//end

// generate origin data
reg [1:0] rst_n_tmp;
always@(posedge clk or negedge rst_n)begin
if(!rst_n) begin
rst_n_tmp <= 'd0;
end
else begin

case(rst_n_tmp)
2'b00:rst_n_tmp <= 2'b01;
2'b01:rst_n_tmp <= 2'b10;
default:;
endcase

end
end


assign require = work & ~data_full & core_ready;
wire require_datatx;
assign require_datatx = require | rst_n_tmp[0];

aes_core core(
    .clk(clk),
    .reset_n(rst_n),
    .encdec(enc),
    .init(key_init),
    .next(require),
    .ready(core_ready),
    .key(key_tmp),
    .block(data_tmp),
    .result(result_data),
    .result_valid(result_valid)
);

lfsr lfsr(
    .clk(clk),
    .rst_n(rst_n),
    .require(require),
    .random128(random128)
);

FIFO128 #(.fifo_addr(2)) datafifo(
    .clk(clk),
    .rst_n(rst_n),
    .in_data(random128),
    .in_require(require_datatx),
    .full(data_full),
    .out_data(data),
    .out_require(data_require),
    .empty(data_empty)
);

FIFO128 #(.fifo_addr(4)) resultfifo(
    .clk(clk),
    .rst_n(rst_n),
    .in_data(result_data),
    .in_require(module_result_valid_1period),
    .full(),
    .out_data(result),
    .out_require(result_require),
    .empty(result_empty)
);



endmodule // aes
