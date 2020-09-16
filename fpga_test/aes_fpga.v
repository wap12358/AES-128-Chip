module aes_fpga(  clk,rst,
						led1,led2,led3);

input clk,rst; 
output led1,led2,led3;


wire test_cu,test_id;
wire [7:0] test_in,test_out;
wire test_shi,test_sho;

aes_top aes_top(  .clk(clk),.rst(rst),
						.cu(test_cu),.id(test_id),
						.user_data(test_in),.shi(test_shi),
						.chip_data(test_out),.sho(test_sho));

aes_test aes_test(.clk(clk),.rst(rst),
						.test_cu(test_cu),.test_id(test_id),
						.test_data(test_in),.test_valid(test_shi));

test_receiver test_receiver(  .clk(clk),.rst(rst),
										.read_en(test_sho),.read_data(test_out),
										.led1(led1),.led2(led2),.led3(led3));



endmodule
