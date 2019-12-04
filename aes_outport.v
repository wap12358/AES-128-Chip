/* This is the output part of the interface. */

module aes_outport(  clk,rst,
							pass_data,aes_en,div_bits,
							out_data,out_valid);

input[3:0] div_bits;

input clk,rst;
input [31:0] pass_data;
input aes_en;
output wire [7:0] out_data;
//output wire out_en;      //finish 128
output wire out_valid;   //shakehand

reg [127:0] out_mem;
reg [1:0] pass_count;
reg [3:0] out_count;
//reg pass_en;   //indicate the 128 reg has been stored
 
reg [7:0] out_reg;
reg outen_reg;
//reg en_reg;
reg valid_en;
assign out_data = out_reg;
//assign out_en = outen_reg;
assign out_valid = valid_en;

reg [15:0] clk_count;
reg flag_en8;

always@(posedge clk or negedge rst) begin
if(!rst) begin
pass_count <= 'd0;
//pass_en <= 'd0;
//en_reg <= 1'b0;
flag_en8 <= 1'b0;
end
else begin

//en_reg <= aes_en;

if(aes_en) begin
	case(pass_count) 
	2'd0: begin out_mem[127:96] <= pass_data[31:0]; pass_count <= 2'd1; flag_en8 <= 1'b1; end
	2'd1: begin out_mem[ 95:64] <= pass_data[31:0]; pass_count <= 2'd2; flag_en8 <= 1'b1; end	
	2'd2: begin out_mem[ 63:32] <= pass_data[31:0]; pass_count <= 2'd3; flag_en8 <= 1'b1; end
	2'd3: begin out_mem[ 31: 0] <= pass_data[31:0]; pass_count <= 2'd0; flag_en8 <= 1'b1; end
	default: begin out_mem <= 'd0; pass_count <= 'd0; end
	endcase end
//old_pass_en <= pass_en;

if(clk_count == 'h1 && outen_reg == 1) begin
	//pass_en <= 1'd0; 
	flag_en8 <= 1'b0; end

end //biggest else begin
end //always begin



//reg out_flag;
always@(posedge clk or negedge rst) begin
if(!rst) begin
out_count <= 'd0;
outen_reg <= 'd0;
clk_count <= 'd1;
valid_en <= 1'b0;
end
else begin

//out_flag <= 1'b0;
if(flag_en8) begin
//	out_flag <= 1'b1;
	clk_count <= clk_count + 1'b1;
	
	if(clk_count[div_bits] == 1'b1) begin
		clk_count <= 'd1; 
		out_count <= out_count + 1'b1; end
	if(!outen_reg) begin
	if(clk_count[div_bits-1'b1] & clk_count[0]) begin
		valid_en <= 1'b0; end
	else begin if(~clk_count[div_bits-1'b1] & clk_count[0]) begin
		valid_en <= 1'b1; end end
	end
	else begin
		if(clk_count[div_bits-1'b1] & clk_count[0]) begin
		valid_en <= 1'b0; end
	end
	
	case(out_count) 
	4'd0 : begin out_reg[7:0] <= out_mem[127:120]; outen_reg <= 1'b0; end
	4'd1 : begin out_reg[7:0] <= out_mem[119:112]; outen_reg <= 1'b0; end
	4'd2 : begin out_reg[7:0] <= out_mem[111:104]; outen_reg <= 1'b0; end
	4'd3 : begin out_reg[7:0] <= out_mem[103:96 ]; outen_reg <= 1'b0; end
	4'd4 : begin out_reg[7:0] <= out_mem[ 95:88 ]; outen_reg <= 1'b0; end
	4'd5 : begin out_reg[7:0] <= out_mem[ 87:80 ]; outen_reg <= 1'b0; end
	4'd6 : begin out_reg[7:0] <= out_mem[ 79:72 ]; outen_reg <= 1'b0; end
	4'd7 : begin out_reg[7:0] <= out_mem[ 71:64 ]; outen_reg <= 1'b0; end
	4'd8 : begin out_reg[7:0] <= out_mem[ 63:56 ]; outen_reg <= 1'b0; end
	4'd9 : begin out_reg[7:0] <= out_mem[ 55:48 ]; outen_reg <= 1'b0; end
	4'd10: begin out_reg[7:0] <= out_mem[ 47:40 ]; outen_reg <= 1'b0; end
	4'd11: begin out_reg[7:0] <= out_mem[ 39:32 ]; outen_reg <= 1'b0; end
	4'd12: begin out_reg[7:0] <= out_mem[ 31:24 ]; outen_reg <= 1'b0; end
	4'd13: begin out_reg[7:0] <= out_mem[ 23:16 ]; outen_reg <= 1'b0; end
	4'd14: begin out_reg[7:0] <= out_mem[ 15:8  ]; outen_reg <= 1'b0; end
	4'd15: begin out_reg[7:0] <= out_mem[  7:0  ]; outen_reg <= 1'b1; end
	default: begin out_reg[7:0] <= 'd0; out_count <= 4'd0; outen_reg <= 1'b0; end
	endcase end

//else begin
//	if(outen_reg) 
//		out_flag <= 1'b0; end
end //biggest else begin
end //always begin

//assign out_valid = out_flag & clk_count[div_bits - 2];

endmodule






//	case(out_count) 
//	4'd0 : begin out_reg[7:0] <= out_mem[127:120]; out_count <= 4'd1 ; outen_reg <= 1'b0; end
//	4'd1 : begin out_reg[7:0] <= out_mem[119:112]; out_count <= 4'd2 ; outen_reg <= 1'b0; end
//	4'd2 : begin out_reg[7:0] <= out_mem[111:104]; out_count <= 4'd3 ; outen_reg <= 1'b0; end
//	4'd3 : begin out_reg[7:0] <= out_mem[103:96 ]; out_count <= 4'd4 ; outen_reg <= 1'b0; end
//	4'd4 : begin out_reg[7:0] <= out_mem[ 95:88 ]; out_count <= 4'd5 ; outen_reg <= 1'b0; end
//	4'd5 : begin out_reg[7:0] <= out_mem[ 87:80 ]; out_count <= 4'd6 ; outen_reg <= 1'b0; end
//	4'd6 : begin out_reg[7:0] <= out_mem[ 79:72 ]; out_count <= 4'd7 ; outen_reg <= 1'b0; end
//	4'd7 : begin out_reg[7:0] <= out_mem[ 71:64 ]; out_count <= 4'd8 ; outen_reg <= 1'b0; end
//	4'd8 : begin out_reg[7:0] <= out_mem[ 63:56 ]; out_count <= 4'd9 ; outen_reg <= 1'b0; end
//	4'd9 : begin out_reg[7:0] <= out_mem[ 55:48 ]; out_count <= 4'd10; outen_reg <= 1'b0; end
//	4'd10: begin out_reg[7:0] <= out_mem[ 47:40 ]; out_count <= 4'd11; outen_reg <= 1'b0; end
//	4'd11: begin out_reg[7:0] <= out_mem[ 39:32 ]; out_count <= 4'd12; outen_reg <= 1'b0; end
//	4'd12: begin out_reg[7:0] <= out_mem[ 31:24 ]; out_count <= 4'd13; outen_reg <= 1'b0; end
//	4'd13: begin out_reg[7:0] <= out_mem[ 23:16 ]; out_count <= 4'd14; outen_reg <= 1'b0; end
//	4'd14: begin out_reg[7:0] <= out_mem[ 15:8  ]; out_count <= 4'd15; outen_reg <= 1'b0; end
//	4'd15: begin out_reg[7:0] <= out_mem[  7:0  ]; out_count <= 4'd0 ; outen_reg <= 1'b1; end
//	default: begin out_reg[7:0] <= 'd0; out_count <= 4'd0 ; outen_reg <= 1'b0; end
//	endcase end