module aes_top( 
    clk,
    config_pin,
    rx, tx
);
input clk;
input [2:0] config_pin;
input [8:0] rx;
output [8:0] tx;

wire rst = config_pin[2];
wire cu = config_pin[1];
wire id = config_pin[0];


wire [7:0] user_data = rx[7:0];
wire shi = rx[8];
wire [7:0] chip_data = tx[7:0];
wire sho = tx[8];

wire [31:0] inport_iset32;
wire inport_iset_ready;

wire [31:0] iset_aes32;
wire [ 7:0] iset_aes_address8;
wire iset_aes_cs;
wire iset_aes_we;

wire [31:0] aes_outport32;

wire iset_outport_ready32;
wire [3:0] iset_outport_speed;

aes_inport aes_inport(.clk(clk),.rst(rst),
						.in_data(user_data),.shi(shi),
						.out_data(inport_iset32),.ready_32(inport_iset_ready));

aes_iset aes_iset(
	.clk(clk), .rst(rst),
	.cu(cu), .id(id), .in_wire(inport_iset32), .in_valid(inport_iset_ready),  
	.address_pass(iset_aes_address8), .data_pass(iset_aes32), .cs_en(iset_aes_cs), .we_en(iset_aes_we), 
	.outport_shakehand_wire(iset_outport_ready32), .outport_speed_wire(iset_outport_speed)
);

aes_outport aes_outport(  .clk(clk),.rst(rst),
							.pass_data(aes_outport32),.aes_en(iset_outport_ready32),
							.out_data(chip_data),.out_valid(sho),.div_bits(iset_outport_speed));
							
aes128only aes128only(
          .clk(clk),
          .reset_n(rst),
          .cs(iset_aes_cs),
          .we(iset_aes_we),
          .address(iset_aes_address8),
          .write_data(iset_aes32),
          .read_data(aes_outport32)
          );






endmodule
 