`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2023 02:25:06 PM
// Design Name: 
// Module Name: debounce
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


module debounce(in, master_clk, out);
    input in; // button signal
    input master_clk;
    output out; // debounced state of button
    
    reg meta_sync0; // sync button to clk
    reg meta_sync1;
    reg debouncer; // store debounce state
    reg [15:0] cnt = 16'd0; // track time
    
    // sync button signal to the clock
    always @ (posedge master_clk) begin
        // capture button signal on each rising edge of clock
        meta_sync0 <= in;
    end
    always @ (posedge master_clk) begin
        // capture synced sig on next rising edge
        meta_sync1 <= meta_sync0;
    end
    
    // check if debounced state matches the synced button signal
    // if match then reset
    // if not match then update debounce state when cnt reaches its max val ffff
    always @ (posedge master_clk) begin
        if (debouncer == meta_sync1) begin
            cnt <= 16'd0;
        end
        else begin
            cnt <= cnt + 1'b1;
            if (cnt == 16'hffff) begin
                // button must stay pushed for ffff time in order to be consdered a push and not noise
                    debouncer <= ~out;
            end
        end
    end
    
    // set outputs
    assign out = debouncer;


endmodule
