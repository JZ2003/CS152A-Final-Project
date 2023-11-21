module control(
    clk,
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


reg [6:0] dig1_reg = 7'b1111111;
reg [6:0] dig2_reg = 7'b1111111;
reg [6:0] dig3_reg = 7'b1111111;
reg [6:0] dig4_reg;


assign dig1 = dig1_reg;
assign dig2 = dig2_reg;
assign dig3 = dig3_reg;
assign dig4 = dig4_reg;

reg [1:0] time_reg = 2'b00;

always @ (posedge clk) begin
    if (num_0_db == 1'b1) begin
         dig4_reg <= 7'b1000000;
    end
    else if (num_1_db == 1'b1) begin 
        dig4_reg <= 7'b1111001;
    end 
    else if (num_2_db == 1'b1) begin 
        dig4_reg <= 7'b0100100;
    end     
    else if (num_3_db == 1'b1) begin 
        dig4_reg <= 7'b0110000;
    end 
    else if (num_4_db == 1'b1) begin 
        dig4_reg <= 7'b0011001;
    end     
    else if (num_5_db == 1'b1) begin 
        dig4_reg <= 7'b0010010;
    end     
    else if (num_6_db == 1'b1) begin 
        dig4_reg <= 7'b0000010;
    end     
    else if (num_7_db == 1'b1) begin 
        dig4_reg <= 7'b1111000;
    end 
    else if (num_8_db == 1'b1) begin 
        dig4_reg <= 7'b0000000;
    end     
    else if (num_9_db == 1'b1) begin 
        dig4_reg <= 7'b0010000;
    end     
    

end 









endmodule