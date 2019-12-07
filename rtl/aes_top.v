module aes_top(clk,rst,cu,id,
					user_data,shi,chip_data,sho);
input clk,rst;
input cu,id;
input [7:0] user_data;
input shi;
output [7:0] chip_data;
output sho;

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
 