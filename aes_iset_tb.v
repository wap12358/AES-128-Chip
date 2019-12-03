`timescale 1 ps/ 1 ps
module aes_iset_tb();

// basic parameter
parameter clk_half_period = 1;
parameter clk_period = 2 * clk_half_period;

// reg to the input of aes_iset
reg clk, rst;
reg cu, id;
reg in_valid;
reg [31:0] in_wire;
reg [31:0] compelet_data_in;

wire [7:0] address_pass;
wire [31:0] data_pass;
wire cs_en, we_en;
wire outport_shakehand_wire;
wire [31:0] outport_data_wire;
wire [3:0] outport_speed_wire;

aes_iset aes_iset(
    .clk(clk),//
    .rst(rst),//
    .cu(cu),//
    .id(id),//
    .in_wire(in_wire),//
    .in_valid(in_valid),//
    .compelet_data_in(compelet_data_in),//
    .address_pass(address_pass),
    .data_pass(data_pass),
    .cs_en(cs_en),
    .we_en(we_en),
    .outport_shakehand_wire(outport_shakehand_wire),
    .outport_data_wire(outport_data_wire),
    .outport_speed_wire(outport_speed_wire)
);

//config instructions
parameter MODE = 32'h4D4F4445; 
parameter MODD = 32'h4D4F4444; 
parameter KEYF = 32'h4B455946; 
parameter KEYH = 32'h4B455948; 
parameter KEYQ = 32'h4B455951; 
parameter KEYN = 32'h4B45594E; 
parameter SPD = 24'h535044; 

initial begin
    clk = 1'b1;
    rst = 1'b0;

    cu = 1'b1;
    id = 1'b1;

    in_valid <= 1'b0;
    in_wire <= 32'h0000_0000;
    
    compelet_data_in <= 32'h01020304;

    #(2 * clk_period);
    rst = 1'b1; // reset finish

    
    // test
    iset_test();

end // end of initial

always begin
    #clk_half_period;
    clk = ~clk;
end

always begin
    #clk_period;
    compelet_data_in <= compelet_data_in + 1;

end


task in(input [31 : 0] instruc);
    begin
        in_wire = instruc;
        #(2 * clk_period);
        in_valid = 1'b1;
        #(1 * clk_period);
        in_valid = 1'b0;
        #(13 * clk_period);
        in_wire = 32'h0000_0000;
        #(48 * clk_period);
    end
endtask


task iset_test;
reg [127 : 0] nist_aes128_key; 
reg [127 : 0] nist_plaintext0;
reg [127 : 0] nist_plaintext1;
reg [127 : 0] nist_plaintext2;
reg [127 : 0] nist_plaintext3;

begin // test

//config data of test
nist_aes128_key = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
nist_plaintext0 = 128'h6bc1bee2_2e409f96_e93d7e11_7393172a;
nist_plaintext1 = 128'hae2d8a57_1e03ac9c_9eb76fac_45af8e51;
nist_plaintext2 = 128'h30c81c46_a35ce411_e5fbc119_1a0a52ef;
nist_plaintext3 = 128'hf69f2445_df4f9b17_ad2b417b_e66c3710;


// test begin
#(64*clk_period);
in(MODE);
in(KEYQ);
in(32'h19990521);
in({SPD,8'h08});
in(KEYN);

#(16 * clk_period);
id = 1'd0;

#(16 * clk_period);
in(nist_plaintext0[127: 96]);
in(nist_plaintext0[ 95: 64]);
in(nist_plaintext0[ 63: 32]);
in(nist_plaintext0[ 31:  0]);
in(nist_plaintext1[127: 96]);
in(nist_plaintext1[ 95: 64]);
in(nist_plaintext1[ 63: 32]);
in(nist_plaintext1[ 31:  0]);

end // end of test


endtask



endmodule