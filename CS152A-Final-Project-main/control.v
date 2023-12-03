module control(
    clk,
    RESET,
    PROCEED,
    CONFIRM,
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

input proceed;
input clk;
input RESET;
input CONFIRM;

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

reg [6:0] dig1_reg;
reg [6:0] dig2_reg;
reg [6:0] dig3_reg;
reg [6:0] dig4_reg;

reg [1:0] time_reg;

reg [3:0] secret_reg;

reg [3:0] guess; 

// reg confirmed;
// reg proceed;

reg [2:0] numTry;
reg [2:0] state;
// Define states
localparam IDLE = 3'b000;
localparam CONFIRM_PRESSED = 3'b001;
localparam PROCEED_PRESSED = 3'b010;
localparam FAIL = 3'b011;
localparam SUCCESS = 3'b100;        



always @ (posedge clk or posedge RESET) begin
    if (RESET) begin
        dig1_reg <= 7'b1111111;
        dig2_reg <= 7'b1111111;
        dig3_reg <= 7'b1111111;
        dig4_reg <= 7'b1111111;
        // status_confirm <= 0;
        state <= IDLE;
        numTry <= 4;
        secret_reg <= $urandom % 10;
        guess <= 12; //Indicate that no guess has been made yet.
    end
    else begin
        case (state)
            SUCCESS: 
                // Show SUCCESS INFO
                // Don't transition to any other state. Only reset will change FAIL state.        
                dig1_reg <= 7'b0010010; // 'S'
                dig2_reg <= 7'b1000110; //'C'
                dig3_reg <= 7'b1111111;
                case (numTry)
                    3:
                        dig4_reg <= 7'b0110000;
                    2:
                        dig4_reg <= 7'b0100100;
                    1:
                        dig4_reg <= 7'b1111001;
                    0:                
                        dig4_reg <= 7'b1000000;     
            FAIL:
                // Show Fail INFO
                // Don't transition to any other state. Only reset will change FAIL state.
                dig1_reg <= 7'b0000000;
                dig2_reg <= 7'b0000000;
                dig3_reg <= 7'b0000000;
                dig4_reg <= 7'b0000000;

            IDLE:
                if (numTry == 0) begin
                    state <= FAIL;
                end
                else if(CONFIRM && guess != 12) begin
                    numTry <= numTry - 1;
                    state <= CONFIRM_PRESSED;
                end
    
                //Display and remember the user selected number
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
                    guess <= 12;
                end 

            CONFIRM_PRESSED:
                if(PROCEED) begin
                    state <= PROCEED_PRESSED;
                end

                if (guess == secret_reg) begin
                    state <= SUCCESS;

                end
                else if (guess < secret_reg) begin 
                    dig1_reg <= 7'b1000111; //'L'
                    dig2_reg <= 7'b1000000; // 'O'
                    dig3_reg <= 7'b1111111;
                    dig4_reg <= 7'b1111111;         
                end
                else if (guess > secret_reg) begin 
                    dig1_reg <= 7'b0001001; //'H'
                    dig2_reg <= 7'b1111001; // 'I'
                    dig3_reg <= 7'b1111111;
                    dig4_reg <= 7'b1111111;         
                end
                 
            PROCEED_PRESSED:
                if (!PROCEED) begin
                    state <= IDLE;
                end
        end                

        
    end


assign dig1 = dig1_reg;
assign dig2 = dig2_reg;
assign dig3 = dig3_reg;
assign dig4 = dig4_reg;


endmodule