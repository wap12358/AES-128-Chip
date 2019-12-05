/* This is the output part of the interface. */

module aes_outport(
	clk,rst,
	pass_data,aes_en,div_bits,
	out_data,out_valid);

// basic input
input clk,rst;

// about control
input[3:0] div_bits;

// about data input
input [31:0] pass_data;
input aes_en;
reg [1:0] pass_count;

// about data output
output wire [7:0] out_data;
output wire out_valid;   //shakehand
reg [7:0] out;
reg valid;
assign out_data = out;
assign out_valid = valid;

// store data
reg [127:0] out_mem;

// reg of logic of the control of output
reg [19:0] clk_count;

always@(posedge clk or negedge rst) begin // data input
if(!rst) begin
pass_count <= 'd0;
clk_count <= 'd0;
out_mem <= 128'h00000000_00000000_00000000_00000000;
end
else begin
clk_count <= |clk_count ? clk_count - 1'b1 : 'd0 ;
if(aes_en) begin
	case(pass_count) 
	2'd0: begin out_mem[127:96] <= pass_data[31:0]; pass_count <= 2'd1; clk_count[div_bits + 'd4] <= 1'b1; end // clk_count <= 1'b1 << (div_bits + 4); end
	2'd1: begin out_mem[ 95:64] <= pass_data[31:0]; pass_count <= 2'd2; end
	2'd2: begin out_mem[ 63:32] <= pass_data[31:0]; pass_count <= 2'd3; end
	2'd3: begin out_mem[ 31: 0] <= pass_data[31:0]; pass_count <= 2'd0; end
	default: begin out_mem <= 'd0; pass_count <= 'd0; end
	endcase
	end
end //biggest else begin
end //always begin

always @(posedge clk or negedge rst) begin
if(!rst) begin
out <= 'd0;
valid <= 'd0;
end
else begin
case({clk_count[div_bits+3],clk_count[div_bits+2],clk_count[div_bits+1],clk_count[div_bits],clk_count[div_bits-1]})
5'b1111_1: begin out <= out_mem[127:120]; valid <= 1'b1; end
5'b1111_0: begin valid <= 1'b0; end
5'b1110_1: begin out <= out_mem[119:112]; valid <= 1'b1; end
5'b1110_0: begin valid <= 1'b0; end
5'b1101_1: begin out <= out_mem[111:104]; valid <= 1'b1; end
5'b1101_0: begin valid <= 1'b0; end
5'b1100_1: begin out <= out_mem[103: 96]; valid <= 1'b1; end
5'b1100_0: begin valid <= 1'b0; end
5'b1011_1: begin out <= out_mem[ 95: 88]; valid <= 1'b1; end
5'b1011_0: begin valid <= 1'b0; end
5'b1010_1: begin out <= out_mem[ 87: 80]; valid <= 1'b1; end
5'b1010_0: begin valid <= 1'b0; end
5'b1001_1: begin out <= out_mem[ 79: 72]; valid <= 1'b1; end
5'b1001_0: begin valid <= 1'b0; end
5'b1000_1: begin out <= out_mem[ 71: 64]; valid <= 1'b1; end
5'b1000_0: begin valid <= 1'b0; end
5'b0111_1: begin out <= out_mem[ 63: 56]; valid <= 1'b1; end
5'b0111_0: begin valid <= 1'b0; end
5'b0110_1: begin out <= out_mem[ 55: 48]; valid <= 1'b1; end
5'b0110_0: begin valid <= 1'b0; end
5'b0101_1: begin out <= out_mem[ 47: 40]; valid <= 1'b1; end
5'b0101_0: begin valid <= 1'b0; end
5'b0100_1: begin out <= out_mem[ 39: 32]; valid <= 1'b1; end
5'b0100_0: begin valid <= 1'b0; end
5'b0011_1: begin out <= out_mem[ 31: 24]; valid <= 1'b1; end
5'b0011_0: begin valid <= 1'b0; end
5'b0010_1: begin out <= out_mem[ 23: 16]; valid <= 1'b1; end
5'b0010_0: begin valid <= 1'b0; end
5'b0001_1: begin out <= out_mem[ 15:  8]; valid <= 1'b1; end
5'b0001_0: begin valid <= 1'b0; end
5'b0000_1: begin out <= out_mem[  7:  0]; valid <= 1'b1; end
5'b0000_0: begin valid <= 1'b0; end
default: begin  end
endcase
end // end of biggest else
end // end of always

endmodule