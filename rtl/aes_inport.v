/* This is the input part of the interface. */

module aes_inport(clk,rst,
						in_data,shi,
						out_data,ready_32);

input clk,rst;
input [7:0] in_data;
input shi; // the signal indicate shake hand input signal
output wire [31:0] out_data;
output wire ready_32; // the siganl indicates the tranfer from 8 to 32 finished 

reg ready_reg0;
reg ready_reg1;
//reg ready_flag;
reg [31:0] out_reg;
assign out_data = out_reg;
reg ready_reg;
//assign ready_32 = ready_flag;
assign ready_32 = ready_reg0 & (~ready_reg1);

// deal with the shake hand signals 
reg shi0,shi1;
reg en_valid;

always@(posedge clk or negedge rst) begin
if(!rst) begin
shi0 <= 1'b0;
shi1 <= 1'b0; end
else begin

shi0 <= shi;
shi1 <= shi0; 

end // the begin of biggest else
end // the begin of always 

wire shi_wire;
assign shi_wire = ~(shi ^ shi1);

//the porcess to finish the transfer from 8 to 32
reg [1:0] part_count; // to count how many 8 parts

always@(posedge clk or negedge rst) begin
if(!rst) begin
ready_reg <= 1'b0;
out_reg <= 'd0;
en_valid <= 1'b0;
part_count <= 'd0; end
else begin

if(en_valid & shi_wire) begin
	en_valid <= 1'b0; 
	case(part_count)
	2'd0: begin out_reg[31 : 24] <= in_data; part_count <= 2'd1; ready_reg <= 1'b0; end
	2'd1: begin out_reg[23 : 16] <= in_data; part_count <= 2'd2; ready_reg <= 1'b0; end
	2'd2: begin out_reg[15 : 08] <= in_data; part_count <= 2'd3; ready_reg <= 1'b0; end
	2'd3: begin out_reg[07 : 00] <= in_data; part_count <= 2'd0; ready_reg <= 1'b1; end
	default: begin out_reg[31 : 00] <= 32'h0000_0000; part_count <= 2'd0;  ready_reg <= 1'b0; end
	endcase
end
else begin
	if(!shi_wire) begin
		en_valid <= 1'b1; end 
end

end // the begin of biggest else
end // the begin of always 

always@(posedge clk or negedge rst) begin
if(!rst) begin
ready_reg0 <= 1'b0; 
//ready_flag <= 1'b0; 
end
else begin

ready_reg0 <= ready_reg;
ready_reg1 <= ready_reg0;
//if(ready_reg && ready_reg0) begin
//	ready_flag <= 1'b1; end
//else begin
//	ready_flag <= 1'b0; end

end // the begin of biggest else
end // the begin of always 

endmodule
