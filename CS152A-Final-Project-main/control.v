module control(
    clk,
    RESET,
    num_0_db,
    num_1_db,
    num_2_db,
    num_3_db,
    num_4_db,
    num_5_db,
    num_6_db,
    num_7_db,
    num_8_db,
    num_9_db,
    dig1,
    dig2,
    dig3,
    dig4
);

input clk;
input RESET,

input num_0_db;
input num_1_db;
input num_2_db;
input num_3_db;
input num_4_db;
input num_5_db;
input num_6_db;
input num_7_db;
input num_8_db;
input num_9_db;

output wire [6:0] dig1;
output wire [6:0] dig2;
output wire [6:0] dig3;
output wire [6:0] dig4;


wire [3:0] secret;
reg [3:0] guess = 0;

random random_generate(.RESET(RESET),.secret(secret))



reg [6:0] dig1_reg = 7'b1111111;
reg [6:0] dig2_reg = 7'b1111111;
reg [6:0] dig3_reg = 7'b1111111;
reg [6:0] dig4_reg = 7'b1000000;


assign dig1 = dig1_reg;
assign dig2 = dig2_reg;
assign dig3 = dig3_reg;
assign dig4 = dig4_reg;

reg [1:0] time_reg = 2'b00;

always @ (posedge clk) begin
    if (num_0_db == 1'b1) begin
        dig4_reg <= 7'b1000000;
        guess <= 0;
    end
    else if (num_1_db == 1'b1) begin 
        dig4_reg <= 7'b1111001;
        guess <= 1;
    end 
    else if (num_2_db == 1'b1) begin 
        dig4_reg <= 7'b0100100;
        guess <= 2;
    end     
    else if (num_3_db == 1'b1) begin 
        dig4_reg <= 7'b0110000;
        guess <= 3;
    end 
    else if (num_4_db == 1'b1) begin 
        dig4_reg <= 7'b0011001;
        guess <= 4;
    end     
    else if (num_5_db == 1'b1) begin 
        dig4_reg <= 7'b0010010;
        guess <= 5;
    end     
    else if (num_6_db == 1'b1) begin 
        dig4_reg <= 7'b0000010;
        guess <= 6;
    end     
    else if (num_7_db == 1'b1) begin 
        dig4_reg <= 7'b1111000;
        guess <= 7;
    end 
    else if (num_8_db == 1'b1) begin 
        dig4_reg <= 7'b0000000;
        guess <= 8;
    end     
    else if (num_9_db == 1'b1) begin 
        dig4_reg <= 7'b0010000;
        guess <= 9;
    end 
    else begin
        dig4_reg <= 7'b1111111;
    end 

    

end 









endmodule