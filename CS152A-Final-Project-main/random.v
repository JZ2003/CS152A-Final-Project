module(RESET,secret);
    input RESET;
    output wire [3:0] secret = 0;

    reg [3:0] secret_reg = 0;

    assign secret = secret_reg;

    always @(posedge RESET) begin
        if (RESET) begin
            secret_reg <= $random % 10;
        end
    end


endmodule