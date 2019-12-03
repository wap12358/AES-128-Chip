/* This is the key module to control each part
	and give instructions.  insturction set*/
	
module aes_iset(
	clk, rst,
	cu, id, in_wire, in_valid,
	address_pass, data_pass, cs_en, we_en, 
	outport_shakehand_wire, outport_speed_wire
);

input clk,rst;
//mode for this module
input cu; // the signal indicates usual mode or config mode, cu=1 means config mode
input id; /* in usual mode:  id=1 means encode     id=0 means decode  
				 in config mode: id=1 means instuction id=0 means data */
input [31:0] in_wire; //32 bits input instructions or data
input in_valid; // indicates the 32 bits is ready
output wire [7:0] address_pass;
output wire [31:0] data_pass;
output wire cs_en;
output wire we_en;

// port to aes module
reg [7:0] address_reg;
reg [31:0] data_out_reg; // the data port to aes module
reg read_en;
reg [7:0] waddr;
reg [31:0] wdata;
reg wflag;
reg [1:0] wcount;
assign address_pass = address_reg;
assign data_pass = data_out_reg; // the data port to aes module
assign cs_en = read_en || (wcount != 2'b00);
assign we_en = (wcount != 2'b00);

// port to outport module
reg outport_shakehand;
reg [3:0] outport_speed;
output wire outport_shakehand_wire;
output wire [3:0] outport_speed_wire;
assign outport_shakehand_wire = outport_shakehand;
assign outport_speed_wire = outport_speed;

//config instructions
parameter MOD = 24'h4D4F44; //config mode
parameter E = 8'h45; //means encode
parameter D = 8'h44; //means decode
parameter KEY = 24'h4B4559; //config key length
parameter F = 8'h46 ; //means receive 128(full) length 
parameter Q = 8'h51 ; //means receive 032(quar) length
parameter N = 8'h4E ; //means receive 000(null) length
parameter SPD = 24'h535044; /* config output speed  
										ensuring data format: 0x01-0x0f */

reg [2:0] data_write_state; // the number of packet has been wrote in
//reg [1:0] data_mode_read_state;
reg [5:0] data_ready_count;
reg aes_working;
reg [127:0] data_buffer;

reg [127:0] default_key;
reg [2:0] keylen_ctrl; // control the length of default part and config part of key, higher 2bit is used to save mode, lower 1bit is a flag
reg [3:0] div_count;

// the FSM of config mode
reg [7:0] state;
parameter ORDER = 8'b0_000_0000; //state after reset
parameter KEYST = 4'b1001;
parameter KEYC1 = {KEYST,4'b0000}; //
parameter KEYC2 = {KEYST,4'b0001}; //
parameter KEYC3 = {KEYST,4'b0010}; //
parameter KEYC4 = {KEYST,4'b0011}; //
parameter KEYEN = {KEYST,4'b0100}; //

// the FSM of default mode
reg [1:0] state_flag_default_mode;
//reg [2:0] packet_count_default_mode;

wire en;
assign en = in_valid || (div_count != 'd0);

//logic to deal with mode select
always@(posedge clk or negedge rst) begin
if(!rst) begin
	// port to aes module
	address_reg <= 8'h00;
	data_out_reg <= 32'h0000_0000;
	waddr <= 8'h08;
	wdata <= 32'h0000_0001;
	wflag <= 1'b1;
	wcount <= 2'b00;
	read_en <= 1'b0;

	// port to outport module
	outport_shakehand <= 1'b0;
	outport_speed <= 4'h4;

	// state and counter
	data_write_state <= 3'd0;
//	data_mode_read_state <= 2'd0;
	data_ready_count <= 6'd0;
	aes_working <= 1'b0;
	state <= ORDER;
//	packet_count_default_mode <= 3'b000;

	state_flag_default_mode <= 2'b00;

	// about key
	default_key <= 128'h2b7e151628aed2a6abf7158809cf4f3c;
	keylen_ctrl <= 3'b000;

	// enable signal
	div_count <= cu ? 4'd0 : 4'd3; // default mode need 3 clocks to initialize encode/decode mode
	


end
else begin	//biggest else

// logic need clk
if(aes_working) begin data_ready_count <= data_ready_count + 1'b1; end // count when aes module is working, to read complete data when it finish
if(cu == 1'd0 && state_flag_default_mode[1] == 1'd1 && state_flag_default_mode[0] != id) begin // change encode/decode mode of default mode
	state_flag_default_mode[0] <= id;
	waddr <= 8'h0a;
	wdata <= id ? 32'h0001 : 32'h0000;
	wflag <= 1'b1;
end // end of change encode/decode mode of default mode
wcount[0] <= wcount[1];



// logic of instruction
if(en) begin //input enable 
if(div_count != 'd0) begin div_count <= div_count - 1'b1; end
//core logic
if(cu) begin //config mode
if(id) begin //instruction mode
	if(state == ORDER) begin //the next input is an instruction
		case(in_wire[31:8])
		MOD: begin //config mode
				case(in_wire[7:0])
				E: begin waddr <= 8'h0a; wdata <= 32'h0000_0001; wflag <= 1'b1; end
				D: begin waddr <= 8'h0a; wdata <= 32'h0000_0000; wflag <= 1'b1; end
				default: begin  end
				endcase
			end
		KEY: begin //input KEY
				state <= KEYC4;
				case(in_wire[7:0])
				F: begin keylen_ctrl <= 3'b10_1; div_count <= 4'd0; end
				Q: begin keylen_ctrl <= 3'b01_0; div_count <= 4'd5; end
				N: begin keylen_ctrl <= 3'b00_0; div_count <= 4'd9; end
				default: begin  end
				endcase
			end
		SPD: begin //config speed
			outport_speed <= in_wire[3:0];
			end
		default: begin  end
		endcase
	end //end of ORDER state
	if(state[7:4] == KEYST) begin //config KEY process
	case(state)
	KEYC1: begin 
		if(keylen_ctrl[0]) begin // config key part
			wflag <= 1'b1;
			waddr <= 8'h13;
			wdata <= in_wire;
			state <= KEYEN;
			div_count <= 'd2;
		end
		else begin // default key part
		if(div_count[0]) begin
			wflag <= 1'b1;
			waddr <= 8'h13;
			wdata <= default_key[31:0];
			state <= KEYEN;
		end // end of div_count[0]
		end // end of default key part
	end // end of KEYC1
	KEYC2: begin 
		if(keylen_ctrl[0]) begin // config key part
			wflag <= 1'b1;
			waddr <= 8'h12;
			wdata <= in_wire;
			state <= KEYC1;
		end
		else begin // default key part
		if(div_count[0]) begin
			wflag <= 1'b1;
			waddr <= 8'h12;
			wdata <= default_key[63:32];
			state <= KEYC1;
			if(keylen_ctrl == 3'b010) begin
				keylen_ctrl[0] <= 1'b1;
			end // end of keylen_ctrl == 3'b010
		end // end of div_count[0]
		end // end of default key part
	end // end of KEYC2
	KEYC3: begin 
		if(keylen_ctrl[0]) begin // config key part
			wflag <= 1'b1;
			waddr <= 8'h11;
			wdata <= in_wire;
			state <= KEYC2;
		end
		else begin // default key part
		if(div_count[0]) begin
			wflag <= 1'b1;
			waddr <= 8'h11;
			wdata <= default_key[95:64];
			state <= KEYC2;
		end // end of div_count[0]
		end // end of default key part
	end // end of KEYC3
	KEYC4: begin 
		if(keylen_ctrl[0]) begin // config key part
			wflag <= 1'b1;
			waddr <= 8'h10;
			wdata <= in_wire;
			state <= KEYC3;
		end
		else begin // default key part
			wflag <= 1'b1;
			waddr <= 8'h10;
			wdata <= default_key[127:96];
			state <= KEYC3;
		end
	end // end of KEYC4
	KEYEN: begin
		if(div_count[0])begin
			wflag <= 1'b1;
			waddr <= 8'h08;
			wdata <= 32'h0001;
			state <= ORDER;
		end // end of div_count[0]
		end // end of KEYEN
	default: begin  end
	endcase // end of KEY config case
	end // end of config KEY process
end // end of instruction mode
else begin // data mode of config mode
if(data_write_state[2]) begin //data mode end
	if(div_count[0]) begin
		case(div_count[2:1])
		2'b00: begin waddr <= 8'h08; wdata <= 32'h0000_0002; wflag <= 1'b1; 
				data_ready_count <= 'd0;
				aes_working <= 1'b1;
				data_write_state <= 3'b000;
			end	
		2'b01: begin waddr <= 8'h23; wdata <= data_buffer[31: 0]; wflag <= 1'b1; end
		2'b10: begin waddr <= 8'h22; wdata <= data_buffer[63:32]; wflag <= 1'b1; end
		2'b11: begin waddr <= 8'h21; wdata <= data_buffer[95:64]; wflag <= 1'b1; end	
		default: begin  end
		endcase
	end
end // end of "data mode end"
else begin // data in
	case(data_write_state[1:0])
	2'b00: begin data_buffer[127:96] <= in_wire; end
	2'b01: begin data_buffer[ 95:64] <= in_wire; end
	2'b10: begin data_buffer[ 63:32] <= in_wire; end
	2'b11: begin data_buffer[ 31: 0] <= in_wire; 
		waddr <= 8'h20;
		wdata <= data_buffer[127:96];
		wflag <= 1'b1;
		end
	default: begin  end
	endcase
	data_write_state <= data_write_state + 1'b1;
	if(data_write_state == 3'b011) begin div_count <= 'd8; end /* if this is the end of this group of data,it will delay 2 clocks to write the config data(08)*/
end // end of data in
end // end of data mode
end // end of config mode
else begin //default mode 
	if(state_flag_default_mode == 2'b00 && div_count == 'd1)begin // the initial state, need to send a 0x0a encode/decode instruction
		waddr <= 8'h0a;
		wdata <= id ? 32'h0001 : 32'h0000; // encode/decode config instruction data
		wflag <= 1'b1;
		state_flag_default_mode <= id ? 2'b11 : 2'b10; // switch the state to encode/decode working state
	end // end of the initial state
	if((in_valid || div_count != 'd0) && state_flag_default_mode[1]) begin // working mode of default mode, just send the data to aes module
		if(in_valid) begin
			case(data_write_state[1:0])
			2'b00: begin data_buffer[127:96] <= in_wire; end 
			2'b01: begin data_buffer[ 95:64] <= in_wire; end
			2'b10: begin data_buffer[ 63:32] <= in_wire; end
			2'b11: begin data_buffer[ 31: 0] <= in_wire; 
				div_count <= 'd8; 
				waddr <= 8'h20;
				wdata <= data_buffer[127:96];
				wflag <= 1'b1;
			end
			default: begin  end
			endcase
			data_write_state <= data_write_state + 1'b1;
		end
		if(div_count[0]) begin
				case(div_count[3:1])
				3'b000: begin waddr <= 8'h08; wdata <= 32'h0000_0002; wflag <= 1'b1; data_ready_count <= 'd0; aes_working <= 1'b1; data_write_state <= 3'b000; end
				3'b001: begin waddr <= 8'h23; wdata <= data_buffer[31: 0]; wflag <= 1'b1; end
				3'b010: begin waddr <= 8'h22; wdata <= data_buffer[63:32]; wflag <= 1'b1; end
				3'b011: begin waddr <= 8'h21; wdata <= data_buffer[95:64]; wflag <= 1'b1; end
				default: begin  end
				endcase
		end // end of div_count[0]
	end // end of working mode of default mode 
end // end of default mode
end //shakehand if or counter enable (the enable signal of this processor part)



//write_in
if(wflag | wcount[1]) begin
	if(wflag) begin wflag <= 1'b0; end
	wcount[1] <= wflag;
	address_reg <= waddr;
	data_out_reg <= wdata;
end // end of write_in


//read_out
if(aes_working && data_ready_count >= 'd54) begin // the compelet data could be read out
	case(data_ready_count)
		'd54: begin 
			address_reg <= 8'h30;
			read_en <= 1'b1; 
			outport_shakehand <= 1'b1;
			// this signal is used to control cs(chip select)
		end // end of 'd54
		'd55: begin 
			address_reg <= 8'h31;
		end // end of 'd55
		'd56: begin 
			address_reg <= 8'h32;
		end // end of 'd56
		'd57: begin 
			address_reg <= 8'h33;
		end // end of 'd57
		'd58: begin 
			read_en <= 1'b0;
			outport_shakehand <= 1'b0;
		end // end of 'd58
		'd59: begin 
			aes_working <= 1'b0;
			data_ready_count <= 'd0;
			
		end // end of 'd58
		default: begin  end
	endcase
end // end of read_out




end //begin in biggest else
end //begin in always


endmodule
