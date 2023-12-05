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

//Input Clock
input clk;

//Input Buttons
input PROCEED;
input RESET;
input CONFIRM;

//Input Switches
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

//Output Seven-seg Encodings
output wire [6:0] dig1;
output wire [6:0] dig2;
output wire [6:0] dig3;
output wire [6:0] dig4;

//Internal Seven-seg Registers
reg [6:0] dig1_reg;
reg [6:0] dig2_reg;
reg [6:0] dig3_reg;
reg [6:0] dig4_reg;


reg [3:0] lfsr_state = 4'b1101;

//Register to store the secret
reg [3:0] secret_reg;

//Register to store the guess made by players
reg [3:0] guess; 


//Rigister to store the number of tries made:
    /*
        numTry starts with the value of 4. 
        Each wrong guess reduces it by 1. When it becomes 0 without a correct guess, the player fails.
        If a correct guess is made, the player wins with a score of numTry (it can be 0,1,2,3).
    */
reg [2:0] numTry;

// Define states
localparam IDLE = 2'b00;
localparam CONFIRM_PRESSED = 2'b01;
// localparam PROCEED_PRESSED = 3'b010;
localparam FAIL = 2'b10;
localparam SUCCESS = 2'b11;        
reg [1:0] state;



always @ (posedge clk or posedge RESET) begin
    if (RESET) begin
        //RESET's checking precedes all others'.
        dig1_reg <= 7'b1111111;
        dig2_reg <= 7'b1111111;
        dig3_reg <= 7'b1111111;
        dig4_reg <= 7'b1111111;
        state <= IDLE;
        numTry <= 4;
        lfsr_state <= lfsr_state ^ (lfsr_state << 1) ^(lfsr_state << 3);
        secret_reg <= lfsr_state % 10;
        guess <= 12; //Use 12 to indicate that no guess has been made yet.
    end
    else begin
        case (state)
            SUCCESS: 
                begin 
                    // Show SUCCESS INFO
                    // Don't transition to any other state. Only reset will transition out SUCCESS state to IDLE.        
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
                    endcase
                end
            FAIL:
                begin
                    // Show Fail INFO
                    // Don't transition to any other state. Only reset will transition out FAIL state to IDLE.   
                    dig1_reg <= 7'b0000000;
                    dig2_reg <= 7'b0000000;
                    dig3_reg <= 7'b0000000;
                    dig4_reg <= 7'b0000000;
                    //TODO: Make the FAIL display more informative
                 end
            IDLE:
                begin
                    if(CONFIRM && guess != 12) begin
                        //If a switch is toggled and the confirm button is pressed
                        numTry <= numTry - 1;
                        state <= CONFIRM_PRESSED; //Transition to CONFIRM_PRESSED state the next clock pulse
                    end

                    dig1_reg <= 7'b1111111;
                    dig2_reg <= 7'b1111111;
        
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
                end

            CONFIRM_PRESSED:
                begin
                    if (guess == secret_reg) begin
                        state <= SUCCESS; //Transition to SUCCESS if it's a right guess.
                    end
                    else if (numTry == 0) begin
                        state <= FAIL; //Transition to FAIL if it's a wrong guess AND numTry is 0.
                    end
    
                    if(PROCEED) begin
                        state <= IDLE; //Transition to IDLE once the PROCEED button is pressed.
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
                 end
             endcase
        end                
    end


assign dig1 = dig1_reg;
assign dig2 = dig2_reg;
assign dig3 = dig3_reg;
assign dig4 = dig4_reg;


endmodule