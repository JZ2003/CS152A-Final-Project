`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2023 03:10:48 PM
// Design Name: 
// Module Name: clocks
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


module clocks(master_clk, RESET, fast_clk);

    input master_clk;
    input RESET;
    // output wire one_clk;
    // output wire two_clk;
    output wire fast_clk;
    // output wire blink_clk;
    
    // reg [31:0] one_clk_counter;
    // reg [31:0] two_clk_counter;
    reg [31:0] fast_clk_counter;
    // reg [31:0] blink_clk_counter;
    
    // reg curr_one_clk;
    // reg curr_two_clk;
    reg curr_fast_clk;
    // reg curr_blink_clk;
    
    // add RESET later
    always @ (posedge master_clk or posedge RESET) begin
    
        // one hz clock
        // if (RESET == 1'b1) begin
        //     curr_one_clk <= 1'b0;
        //     one_clk_counter <= 32'd0;
        // end
        // else if (one_clk_counter == 32'd50000000 - 32'b1) begin
        //     curr_one_clk <= ~one_clk;
        //     one_clk_counter <= 32'b0;
        // end
        // else begin
        //     one_clk_counter <= one_clk_counter + 1;
        //     curr_one_clk <= one_clk;
        // end
    
        // // two hz clock
        // if (RESET == 1'b1) begin
        //     curr_two_clk <= 1'b0;
        //     two_clk_counter <= 32'd0;
        // end
        // else if (two_clk_counter == 32'd25000000 - 32'd1) begin
        //     curr_two_clk <= ~two_clk;
        //     two_clk_counter <= 32'b0;
        // end
        // else begin
        //     two_clk_counter <= two_clk_counter + 1;
        //     curr_two_clk <= two_clk;
        // end

        // ~ 600 hz fast clock
        if (RESET == 1'b1) begin
            curr_fast_clk <= 1'b0;
            fast_clk_counter <= 32'd0;
        end
        else if (fast_clk_counter == 32'd83333 - 32'd1) begin
            curr_fast_clk <= ~fast_clk;
            fast_clk_counter <= 32'd0;
        end
        else begin
            fast_clk_counter <= fast_clk_counter + 1;
            curr_fast_clk <= fast_clk;
        end
        
        // blink
        // if (RESET == 1'b1) begin
        //     curr_blink_clk <= 1'b0;
        //     blink_clk_counter <= 32'd0;
        // end
        // else if (blink_clk_counter == 32'd12500000 - 32'd1) begin
        //     curr_blink_clk <= ~blink_clk;
        //     blink_clk_counter <= 32'd0;
        // end
        // else begin
        //     blink_clk_counter <= blink_clk_counter + 1;
        //     curr_blink_clk <= blink_clk;
        // end

    end
    
    // assign one_clk = curr_one_clk;
    // assign two_clk = curr_two_clk;
    assign fast_clk = curr_fast_clk;
    // assign blink_clk = curr_blink_clk;
    
endmodule
