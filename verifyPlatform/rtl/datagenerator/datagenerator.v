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
assign require = work & ~data_full & core_ready;


aes_core core(
    .clk(clk),
    .reset_n(rst_n),
    .encdec(enc),
    .init(key_init),
    .next(require),
    .ready(core_ready),
    .key(key_tmp),
    .block(random128),
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
    .in_require(require),
    .full(data_full),
    .out_data(data),
    .out_require(data_require),
    .empty(data_empty)
);

FIFO128 #(.fifo_addr(3)) resultfifo(
    .clk(clk),
    .rst_n(rst_n),
    .in_data(result_data),
    .in_require(result_valid),
    .full(),
    .out_data(result),
    .out_require(result_require),
    .empty(result_empty)
);



endmodule // aes
