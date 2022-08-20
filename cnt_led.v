`timescale 1ns / 1ps

module cnt_led
(
input rst,clk,
input key1, key0,
input [3:0] enc,
output [3:0] kled, tled,
output [7:0] led
);

wire krst, ksel;

reg k0,k1;
reg cnt_md;

reg [31:0] cnt;
reg [15:0] qout;

assign ksel = ~key0;
assign krst = key1;

always@(negedge rst, posedge clk)
if(rst == 0 )
    begin 
        k0 <= 0;
        k1 <= 0;
        cnt_md <= 0;
    end 
else
    begin
            k0 <= ksel;
            k1 <= k0;
            if(k0 & ~k1)
                cnt_md <= ~cnt_md;
    end 

//Counter    
    
always@(negedge rst, posedge clk)
if(rst ==0)
    cnt <= 0;
else
    if(krst ==0)
        cnt <= 0;
    else if(cnt_md == 1)
        cnt <= cnt +1;
        
// output selection      
always@(negedge rst, posedge clk)
if(rst == 0)
    qout <=0;
else
    case (~enc)

        4'hf    :  qout <= cnt[31:16];      
        4'he    :  qout <= cnt[30:15];      
        4'hd    :  qout <= cnt[29:14];      
        4'hc    :  qout <= cnt[28:13];
        4'hb    :  qout <= cnt[27:12];      
        4'ha    :  qout <= cnt[26:11];      
        4'h9    :  qout <= cnt[25:10];      
        4'h8    :  qout <= cnt[24:9];     
        4'h7    :  qout <= cnt[23:8];      
        4'h6    :  qout <= cnt[22:7];      
        4'h5    :  qout <= cnt[21:6];      
        4'h4    :  qout <= cnt[20:5];    
        4'h3    :  qout <= cnt[19:4];      
        4'h2    :  qout <= cnt[18:3];      
        4'h1    :  qout <= cnt[17:2];      
        default    :  qout <= cnt[16:1];    
    endcase 
    
//fpga output port assign 
assign tled = ~qout[15:12];
assign kled = ~qout[11:8];
assign led = ~qout[7:0];

endmodule    
    
    
    
    
    
    
    
    
    
    
