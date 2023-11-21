`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2023 03:38:24 PM
// Design Name: 
// Module Name: cathode_and_anode
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cathode_and_anode(clk,dig1,dig2,dig3,dig4,cathode, anode);
    // input switches
//    input ADJ;
//    input SEL;
    input clk; // Messing Around
    // input clks
//    input blink_clk;
//    input fast_clk;
    // input lights (L->R)
    input [6:0] dig1;
    input [6:0] dig2;
    input [6:0] dig3;
    input [6:0] dig4;
    // outputs (cathodes and anodes)
    output [6:0] cathode;
    output [3:0] anode;
    
    reg [6:0] cathode_reg; 
    reg [3:0] anode_reg;
    reg [1:0] itr = 2'b00;
    

    always @(posedge fast_clk) begin //Messing Around
        if(itr == 0) begin
            itr <= itr + 2'b1;
            anode_reg <= 4'b0111;
            if (ADJ && !SEL) begin
                if (blink_clk) begin
                    cathode_reg <= minsTens; 
                end
                else begin
                    cathode_reg <= 7'b1111111;
                end
            end
            else begin 
                cathode_reg <= minsTens;
            end 
        end
        
        else if (itr == 1) begin
            itr <= itr + 2'b1;
            anode_reg <= 4'b1011;
            if (ADJ && !SEL) begin
                if (blink_clk) begin
                    cathode_reg <= minsOnes; 
                end
                else begin
                    cathode_reg <= 7'b1111111;
                end
            end
            else begin 
                cathode_reg <= minsOnes;
            end       
        end
        
        else if (itr == 2) begin
            itr <= itr + 2'b1;
            anode_reg <= 4'b1101;
            if (ADJ && SEL) begin
                if (blink_clk) begin
                    cathode_reg <= secsTens; 
                end
                else begin
                    cathode_reg <= 7'b1111111;
                end
            end
            else begin 
                cathode_reg <= secsTens;
            end
        
        end
        
        else if (itr == 3) begin
            itr <= 2'b00;
            anode_reg <= 4'b1110;
            if (ADJ && SEL) begin
                if (blink_clk) begin
                    cathode_reg <= secsOnes; 
                end
                else begin
                    cathode_reg <= 7'b1111111;
                end
            end
            else begin 
                cathode_reg <= secsOnes;
            end
        end
        
    end
    
    assign cathode = cathode_reg;
    assign anode = anode_reg;
    
    


endmodule
