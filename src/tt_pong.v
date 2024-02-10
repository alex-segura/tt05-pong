`default_nettype none

module tt_pong (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
    );
    wire reset = !rst_n;
    wire r, g, b;
    wire hsync, vsync, de;
    wire [9:0] hpos;
    wire [9:0] vpos;
    wire [9:0] paddle1_next;
    wire [9:0] paddle2_next;
    paddle p1 (.clk(clk), .reset(reset), .a(ui_in[0]), .b(ui_in[1]), .move(paddle1_next));
    paddle p2 (.clk(clk), .reset(reset), .a(ui_in[2]), .b(ui_in[3]), .move(paddle2_next));
    hvsync_generator hvsync_generator(
        .clk(clk),
        .reset(sim_rst),
        .hsync(hsync),
        .vsync(vsync),
        .sx(hpos),
        .sy(vpos),
        .de(de));
    pong pong(
        .clk(clk),
        .reset(reset),
        .vsync(vsync),
        .hpos(hpos),
        .vpos(vpos),
        .de(de),
        .paddle1_next(paddle1_next),
        .paddle2_next(paddle2_next),
        .r(r),
        .g(g),
        .b(b));
    assign uo_out[1] = vsync;
    assign uo_out[3:2] = {2{r}};
    assign uo_out[5:4] = {2{g}};
    assign uo_out[7:6] = {2{b}};
endmodule
