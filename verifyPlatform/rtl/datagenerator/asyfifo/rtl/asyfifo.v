module  asyfifo
#(
　　parameter WSIZE = 32;
　　parameter DSIZE = 8;
)
(
　　input wr_clk,
　　input rst,
　　input wr_en,
　　input [WSIZE-1 : 0]din,
　　input rd_clk,
　　input rd_en,
　　output [WSIZE-1 : 0]dout,
　　output reg rempty,
　　output reg wfull
);

//定义变量
reg [WSIZE-1 :0] mem [DSIZE-1 : 0];
reg [WSIZE-1 : 0] waddr,raddr;
reg [WSIZE : 0] wbin,rbin,wbin_next,rbin_next;
reg [WSIZE : 0] wgray_next,rgray_next;
reg [WSIZE : 0] wp,rp;
reg [WSIZE : 0] wr1_rp,wr2_rp,rd1_wp,rd2_wp;
wire rempty_val,wfull_val;

//输出数据
assign dout = mem[raddr];

//输入数据
always@(posedge wr_clk)
　　if(wr_en && !wfull)
　　　　mem[waddr] <= din;

//1.产生存储实体的读地址raddr; 2.将普通二进制转化为格雷码，并赋给读指针rp
always@(posedge rd_clk or negedge rst_n)
　　if(!rst_n)
　　　　{rbin,rp} <= 0;
　　else
　　　　{rbin,rp} <= {rbin_next,rgray_next};

assign raddr = rbin[WSIZE-1 : 0];
assign rbin_next = rbin + (rd_en & ~rempty);
assign rgray_next = rbin_next ^ (rbin_next >> 1);

//1.产生存储实体的写地址waddr; 2.将普通二进制转化为格雷码，并赋给写指针wp
always@(posedge wr_clk or negedge rst_n)
　　if(!rst_n)
　　　　{wbin,wp} <= 0;
　　else
　　　　{wbin,wp} <= {wbin_next,wgray_next};

assign waddr = wbin[WSIZE-1 : 0];
assign wbin_next = wbin + (wr_en & ~wfull);
assign wgray_next = wbin_next ^ (wbin_next >> 1);

//将读指针rp同步到写时钟域
always@(posedge wr_clk or negedge rst_n)
　　if(!rst_n)
　　　　{wr2_rp,wr1_rp} <= 0;
　　else
　　　　{wr2_rp,wr1_rp} <= {wr1_rp,rp};

//将写指针wp同步到读时钟域
always@(posedge rd_clk or negedge rst_n)
　　if(!rst_n)
　　　　{rd2_wp,rd1_wp} <= 0;
　　else
　　　　{rd2_wp,rd1_wp} <= {rd1_wp,wp};

//产生读空信号rempty
assign rempty_val = (rd2_wp == rgray_next);
always@(posedge rd_clk or negedge rst_n)
　　if(rst_n)
　　　　rempty <= 1'b1;
　　else
　　　　rempty <= rempty_val;

//产生写满信号wfull
assign wfull_val = ((~(wr2_rp[WSIZE : WSIZE-1]),wr2_rp[WSIZE-2 : 0]) == wgray_next);
always@(posedge wr_clk or negedge rst_n)
　　if(!rst_n)
　　　　wfull <= 1'b0;
　　else
　　　　wfull <= wfull_val;

endmodule