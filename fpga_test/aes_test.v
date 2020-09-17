module aes_test(  clk,rst,
						test_cu,test_id,test_data,test_valid);

input clk,rst;
output wire test_cu,test_id;
output wire [7:0] test_data;
output wire test_valid;

reg cu_reg,id_reg;
reg [7:0] data_reg;
reg valid_reg;

assign test_cu = cu_reg;
assign test_id = id_reg;
assign test_data = data_reg;
assign test_valid = valid_reg;

reg [2:0] clk_count;
reg clk_div16;

always@(posedge clk or negedge rst) begin
if(!rst) begin
clk_div16 <= 1'b0; 
clk_count <= 'd0;
end
else begin

clk_count <= clk_count + 1'b1;
if(clk_count == 'd7) 
clk_div16 <= ~clk_div16;

end //of biggest else
end //of always 

reg [8:0] data_count;

always@(posedge clk_div16 or negedge rst) begin
if(!rst) begin
cu_reg <= 1'b0;
id_reg <= 1'b1;
data_reg <= 'd0;
valid_reg <= 1'b0; 
data_count <= 'd0;
end
else begin

if(data_count <= 'd47) begin
	data_count <= data_count + 1'b1; end
	case(data_count) 
	'd0 : begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd1 : begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd2 : begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd3 : begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd4 : begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd5 : begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd6 : begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd7 : begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd8 : begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd9 : begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd10: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd11: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd12: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd13: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd14: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd15: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	
	'd16: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd17: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd18: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd19: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd20: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd21: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd22: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd23: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd24: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd25: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd26: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd27: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd28: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd29: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd30: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end
	'd31: begin data_reg <= 8'h1; valid_reg <= ~valid_reg; end	

	'd32: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd33: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd34: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd35: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd36: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd37: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd38: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd39: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd40: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd41: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd42: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd43: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd44: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd45: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd46: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd47: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end	
	
	'd48: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd49: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd50: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd51: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd52: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd53: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd54: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd55: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd56: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd57: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd58: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd59: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd60: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd61: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd62: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end
	'd63: begin data_reg <= 8'h0; valid_reg <= ~valid_reg; end	
	
	default: begin valid_reg <= valid_reg; end 
	endcase



end //of biggest else
end //of always 


endmodule
