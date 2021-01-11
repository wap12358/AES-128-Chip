//File name  :    random128_reg.v
//Author     :    wap12358
//Time       :    2021/01/05 22:59:10
//Abstract   :        

`timescale 1ns/1ps

module lfsr(
    clk, rst_n,
    require,
    random128
);

//Define pins:
input               clk, rst_n;
input               require;
output  [127:0]     random128;

//Define signals:
reg     [127:0]     random128_reg;

//Edit code:
assign random128 = random128_reg;

always@(posedge clk or negedge rst_n) begin
    if(~rst_n) begin
        random128_reg <= 128'd123456789012345678901234567890123456789;
    end else if (require) begin
        random128_reg[  0] <= random128_reg[127];
        random128_reg[  1] <= random128_reg[  0];
        random128_reg[  2] <= random128_reg[  1] ^ random128_reg[127];
        random128_reg[  3] <= random128_reg[  2];
        random128_reg[  4] <= random128_reg[  3];
        random128_reg[  5] <= random128_reg[  4];
        random128_reg[  6] <= random128_reg[  5];
        random128_reg[  7] <= random128_reg[  6];
        random128_reg[  8] <= random128_reg[  7];
        random128_reg[  9] <= random128_reg[  8];
        random128_reg[ 10] <= random128_reg[  9];
        random128_reg[ 11] <= random128_reg[ 10];
        random128_reg[ 12] <= random128_reg[ 11];
        random128_reg[ 13] <= random128_reg[ 12];
        random128_reg[ 14] <= random128_reg[ 13];
        random128_reg[ 15] <= random128_reg[ 14];
        random128_reg[ 16] <= random128_reg[ 15];
        random128_reg[ 17] <= random128_reg[ 16];
        random128_reg[ 18] <= random128_reg[ 17];
        random128_reg[ 19] <= random128_reg[ 18];
        random128_reg[ 20] <= random128_reg[ 19];
        random128_reg[ 21] <= random128_reg[ 20];
        random128_reg[ 22] <= random128_reg[ 21];
        random128_reg[ 23] <= random128_reg[ 22];
        random128_reg[ 24] <= random128_reg[ 23];
        random128_reg[ 25] <= random128_reg[ 24];
        random128_reg[ 26] <= random128_reg[ 25];
        random128_reg[ 27] <= random128_reg[ 26] ^ random128_reg[127];
        random128_reg[ 28] <= random128_reg[ 27];
        random128_reg[ 29] <= random128_reg[ 28] ^ random128_reg[127];
        random128_reg[ 30] <= random128_reg[ 29];
        random128_reg[ 31] <= random128_reg[ 30];
        random128_reg[ 32] <= random128_reg[ 31];
        random128_reg[ 33] <= random128_reg[ 32];
        random128_reg[ 34] <= random128_reg[ 33];
        random128_reg[ 35] <= random128_reg[ 34];
        random128_reg[ 36] <= random128_reg[ 35];
        random128_reg[ 37] <= random128_reg[ 36];
        random128_reg[ 38] <= random128_reg[ 37];
        random128_reg[ 39] <= random128_reg[ 38];
        random128_reg[ 40] <= random128_reg[ 39];
        random128_reg[ 41] <= random128_reg[ 40];
        random128_reg[ 42] <= random128_reg[ 41];
        random128_reg[ 43] <= random128_reg[ 42];
        random128_reg[ 44] <= random128_reg[ 43];
        random128_reg[ 45] <= random128_reg[ 44];
        random128_reg[ 46] <= random128_reg[ 45];
        random128_reg[ 47] <= random128_reg[ 46];
        random128_reg[ 48] <= random128_reg[ 47];
        random128_reg[ 49] <= random128_reg[ 48];
        random128_reg[ 50] <= random128_reg[ 49];
        random128_reg[ 51] <= random128_reg[ 50];
        random128_reg[ 52] <= random128_reg[ 51];
        random128_reg[ 53] <= random128_reg[ 52];
        random128_reg[ 54] <= random128_reg[ 53];
        random128_reg[ 55] <= random128_reg[ 54];
        random128_reg[ 56] <= random128_reg[ 55];
        random128_reg[ 57] <= random128_reg[ 56];
        random128_reg[ 58] <= random128_reg[ 57];
        random128_reg[ 59] <= random128_reg[ 58];
        random128_reg[ 60] <= random128_reg[ 59];
        random128_reg[ 61] <= random128_reg[ 60];
        random128_reg[ 62] <= random128_reg[ 61];
        random128_reg[ 63] <= random128_reg[ 62];
        random128_reg[ 64] <= random128_reg[ 63];
        random128_reg[ 65] <= random128_reg[ 64];
        random128_reg[ 66] <= random128_reg[ 65];
        random128_reg[ 67] <= random128_reg[ 66];
        random128_reg[ 68] <= random128_reg[ 67];
        random128_reg[ 69] <= random128_reg[ 68];
        random128_reg[ 70] <= random128_reg[ 69];
        random128_reg[ 71] <= random128_reg[ 70];
        random128_reg[ 72] <= random128_reg[ 71];
        random128_reg[ 73] <= random128_reg[ 72];
        random128_reg[ 74] <= random128_reg[ 73];
        random128_reg[ 75] <= random128_reg[ 74];
        random128_reg[ 76] <= random128_reg[ 75];
        random128_reg[ 77] <= random128_reg[ 76];
        random128_reg[ 78] <= random128_reg[ 77];
        random128_reg[ 79] <= random128_reg[ 78];
        random128_reg[ 80] <= random128_reg[ 79];
        random128_reg[ 81] <= random128_reg[ 80];
        random128_reg[ 82] <= random128_reg[ 81];
        random128_reg[ 83] <= random128_reg[ 82];
        random128_reg[ 84] <= random128_reg[ 83];
        random128_reg[ 85] <= random128_reg[ 84];
        random128_reg[ 86] <= random128_reg[ 85];
        random128_reg[ 87] <= random128_reg[ 86];
        random128_reg[ 88] <= random128_reg[ 87];
        random128_reg[ 89] <= random128_reg[ 88];
        random128_reg[ 90] <= random128_reg[ 89];
        random128_reg[ 91] <= random128_reg[ 90];
        random128_reg[ 92] <= random128_reg[ 91];
        random128_reg[ 93] <= random128_reg[ 92];
        random128_reg[ 94] <= random128_reg[ 93];
        random128_reg[ 95] <= random128_reg[ 94];
        random128_reg[ 96] <= random128_reg[ 95];
        random128_reg[ 97] <= random128_reg[ 96];
        random128_reg[ 98] <= random128_reg[ 97];
        random128_reg[ 99] <= random128_reg[ 98];
        random128_reg[100] <= random128_reg[ 99];
        random128_reg[101] <= random128_reg[100];
        random128_reg[102] <= random128_reg[101];
        random128_reg[103] <= random128_reg[102];
        random128_reg[104] <= random128_reg[103];
        random128_reg[105] <= random128_reg[104];
        random128_reg[106] <= random128_reg[105];
        random128_reg[107] <= random128_reg[106];
        random128_reg[108] <= random128_reg[107];
        random128_reg[109] <= random128_reg[108];
        random128_reg[110] <= random128_reg[109];
        random128_reg[111] <= random128_reg[110];
        random128_reg[112] <= random128_reg[111];
        random128_reg[113] <= random128_reg[112];
        random128_reg[114] <= random128_reg[113];
        random128_reg[115] <= random128_reg[114];
        random128_reg[116] <= random128_reg[115];
        random128_reg[117] <= random128_reg[116];
        random128_reg[118] <= random128_reg[117];
        random128_reg[119] <= random128_reg[118];
        random128_reg[120] <= random128_reg[119];
        random128_reg[121] <= random128_reg[120];
        random128_reg[122] <= random128_reg[121];
        random128_reg[123] <= random128_reg[122];
        random128_reg[124] <= random128_reg[123];
        random128_reg[125] <= random128_reg[124];
        random128_reg[126] <= random128_reg[125];
        random128_reg[127] <= random128_reg[126];
    end //the end of biggest if
end //the end of always


endmodule

