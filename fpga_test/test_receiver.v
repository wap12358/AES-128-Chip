module test_receiver(clk,rst,
							read_en,read_data,
							led1,led2,led3);

input clk,rst;
input read_en;
input [7:0] read_data;
output wire led1;
output wire led2;
output wire led3;

reg led1_reg;
assign led1 = led1_reg;
reg led2_reg;
assign led2 = led2_reg;
reg led3_reg;
assign led3 = led3_reg;

reg [7:0] count;
reg [7:0] mem;

always@(negedge read_en or negedge rst) begin
if(!rst) begin
led1_reg <= 1'b0;
led2_reg <= 1'b0;
led3_reg <= 1'b0;
count <= 'd0;
end
else begin

led1_reg <= 1'b1;
count <= count + 1'b1;
mem <= read_data;

if(count == 'd1 ) begin if(mem == 8'haa) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd2 ) begin if(mem == 8'h00) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd3 ) begin if(mem == 8'h24) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd4 ) begin if(mem == 8'hfd) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd5 ) begin if(mem == 8'hd8) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd6 ) begin if(mem == 8'h91) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd7 ) begin if(mem == 8'he2) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd8 ) begin if(mem == 8'h28) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd9 ) begin if(mem == 8'h67) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd10) begin if(mem == 8'h78) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd11) begin if(mem == 8'h01) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd12) begin if(mem == 8'hfe) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd13) begin if(mem == 8'h62) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd14) begin if(mem == 8'h04) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd15) begin if(mem == 8'h8c) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd16) begin if(mem == 8'hcf) led2_reg <= 1'b1; else led2_reg <= 1'b0; end

if(count == 'd33) begin if(mem == 8'haa) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd34) begin if(mem == 8'h00) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd35) begin if(mem == 8'h24) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd36) begin if(mem == 8'hfd) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd37) begin if(mem == 8'hd8) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd38) begin if(mem == 8'h91) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd39) begin if(mem == 8'he2) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd40) begin if(mem == 8'h28) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd41) begin if(mem == 8'h67) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd42) begin if(mem == 8'h78) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd43) begin if(mem == 8'h01) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd44) begin if(mem == 8'hfe) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd45) begin if(mem == 8'h62) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd46) begin if(mem == 8'h04) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd47) begin if(mem == 8'h8c) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd48) begin if(mem == 8'hcf) led2_reg <= 1'b1; else led2_reg <= 1'b0; end

if(count == 'd49) begin if(mem == 8'haa) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd50) begin if(mem == 8'h00) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd51) begin if(mem == 8'h24) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd52) begin if(mem == 8'hfd) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd53) begin if(mem == 8'hd8) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd54) begin if(mem == 8'h91) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd55) begin if(mem == 8'he2) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd56) begin if(mem == 8'h28) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd57) begin if(mem == 8'h67) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd58) begin if(mem == 8'h78) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd59) begin if(mem == 8'h01) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd60) begin if(mem == 8'hfe) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd61) begin if(mem == 8'h62) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd61) begin if(mem == 8'h04) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd63) begin if(mem == 8'h8c) led2_reg <= 1'b1; else led2_reg <= 1'b0; end
if(count == 'd64) begin if(mem == 8'hcf) led2_reg <= 1'b1; else led2_reg <= 1'b0; led3_reg <= 1'b1; end


end //of biggest else
end //of always

endmodule
