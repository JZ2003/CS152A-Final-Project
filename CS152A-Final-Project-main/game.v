module game(clk,btnU,btnR,btnL,sw,an,seg);
    input clk;
    input btnR;
    input btnL;
    input btnU;
    input [9:0] sw;
    output [3:0] an;
    output [6:0] seg;
    
    wire debounced0;
    wire debounced1;
    wire debounced2;
    wire debounced3;
    wire debounced4;
    wire debounced5;
    wire debounced6;
    wire debounced7;
    wire debounced8;
    wire debounced9;
    wire debouncedRst;
    wire debouncedCfm;
    wire debouncedPcd;
    
    debounce debounce0(.in(sw[0]),.master_clk(clk),.out(debounced0));
    debounce debounce1(.in(sw[1]),.master_clk(clk),.out(debounced1));
    debounce debounce2(.in(sw[2]),.master_clk(clk),.out(debounced2));
    debounce debounce3(.in(sw[3]),.master_clk(clk),.out(debounced3));
    debounce debounce4(.in(sw[4]),.master_clk(clk),.out(debounced4));
    debounce debounce5(.in(sw[5]),.master_clk(clk),.out(debounced5));
    debounce debounce6(.in(sw[6]),.master_clk(clk),.out(debounced6));
    debounce debounce7(.in(sw[7]),.master_clk(clk),.out(debounced7));
    debounce debounce8(.in(sw[8]),.master_clk(clk),.out(debounced8));
    debounce debounce9(.in(sw[9]),.master_clk(clk),.out(debounced9));
    debounce debounceRst(.in(btnR),.master_clk(clk),.out(debouncedRst));
    debounce debounceCfm(.in(btnL),.master_clk(clk),.out(debouncedCfm));
    debounce debouncePcd(.in(btnU),.master_clk(clk),.out(debouncedPcd));


    wire fast_clk;

    clocks clk_div(.master_clk(clk),.RESET(debouncedRst),.fast_clk(fast_clk));
    
    
    wire [6:0] dig1;
    wire [6:0] dig2;
    wire [6:0] dig3;
    wire [6:0] dig4;
    
    control controlUnit(.clk(clk),.CONFIRM(debouncedCfm),.RESET(debouncedRst),.PROCEED(debouncedPcd),.num_0_db(debounced0),.num_1_db(debounced1),.num_2_db(debounced2),.num_3_db(debounced3),
    .num_4_db(debounced4),.num_5_db(debounced5),.num_6_db(debounced6),.num_7_db(debounced7),.num_8_db(debounced8),
    .num_9_db(debounced9),.dig1(dig1),.dig2(dig2),.dig3(dig3),.dig4(dig4));

    cathode_and_anode display(.fast_clk(fast_clk),.dig1(dig1),.dig2(dig2),.dig3(dig3),.dig4(dig4),.cathode(seg),.anode(an));

endmodule