module datagenerator(
    // Clock and reset.
    input wire           clk,
    input wire           rst_n,
    // Control.
    input wire           cs,
    input wire           we,
    // Data ports.
    input wire  [7 : 0]  address,
    input wire  [127: 0] write_data,
    output wire [127: 0] read_data
);


localparam ADDR_CTRL        = 8'h08;
localparam CTRL_INIT_BIT    = 0;
localparam CTRL_NEXT_BIT    = 1;
localparam ADDR_STATUS      = 8'h09;
localparam STATUS_READY_BIT = 0;
localparam STATUS_VALID_BIT = 1;
localparam ADDR_CONFIG      = 8'h0a;
localparam CTRL_ENCDEC_BIT  = 0;


reg                 init_reg;
reg                 init_new;
reg                 next_reg;
reg                 next_new;
reg                 encdec_reg;
reg                 config_we;
reg     [127: 0]    block_reg;
reg                 block_we;
reg     [127: 0]    key_reg;
reg                 key_we;
reg     [127: 0]    result_reg;
//  reg           valid_reg;
//  reg           ready_reg;


reg [127: 0]   tmp_read_data;
wire           core_encdec;
wire           core_init;
wire           core_next;
wire           core_ready;
wire [127 : 0] core_key;
wire [127 : 0] core_block;
wire [127 : 0] core_result;
wire           core_valid;


assign read_data = tmp_read_data;
assign core_key = key_reg;
assign core_block  = block_reg;
assign core_init   = init_reg;
assign core_next   = next_reg;
assign core_encdec = encdec_reg;


aes_core core(
    .clk(clk),
    .reset_n(rst_n),
    .encdec(core_encdec),
    .init(core_init),
    .next(core_next),
    .ready(core_ready),
    .key(core_key),
    .block(core_block),
    .result(core_result),
    .result_valid(core_valid)
);

lfsr lfsr(
    .clk(clk),
    .rst_n(rst_n),
    .random128()
);


always @ (posedge clk or negedge rst_n) begin : reg_update
    if (~rst_n) begin
        block_reg <= 128'h0;
        key_reg <= 128'hab7240f9_c5e0bb5e_ee8e34b6_bb84cfb0;			 
        init_reg   <= 1'b0;
        next_reg   <= 1'b0;
        encdec_reg <= 1'b0;
        result_reg <= 128'h0;
        //valid_reg  <= 1'b0;
        //ready_reg  <= 1'b0;
    end else begin
        //ready_reg  <= core_ready;
        //valid_reg  <= core_valid;
        result_reg <= core_result;
        init_reg   <= init_new;
        next_reg   <= next_new;

        if (config_we)
            encdec_reg <= write_data[CTRL_ENCDEC_BIT];

        if (key_we)
          key_reg <= write_data;

        if (block_we)
          block_reg <= write_data;
    end
end // reg_update


always @* begin : api
    init_new      = 1'b0;
    next_new      = 1'b0;
    config_we     = 1'b0;
    if (cs) begin
        if (we) begin
            if (address == ADDR_CTRL) begin
                  init_new = write_data[CTRL_INIT_BIT];
                  next_new = write_data[CTRL_NEXT_BIT];
            end
            if (address == ADDR_CONFIG)
                config_we = 1'b1;
        end
    end
end // addr_decoder


endmodule // aes
