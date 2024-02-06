module pong #( parameter PADDLE_WIDTH = 8, COLOR_DEPTH=8 ) (
    input wire clk,
    input wire reset,
    input wire p1a,
    input wire p1b,
    input wire p2a,
    input wire p2b,
    output wire [COLOR_DEPTH-1:0] r,
    output wire [COLOR_DEPTH-1:0] g,
    output wire [COLOR_DEPTH-1:0] b
);
    wire p1a_db, p1b_db;
    wire p2a_db, p2b_db;
    wire hsync, vsync;
    wire de;
    reg [9:0] ballx;
    reg [9:0] bally;
    reg [PADDLE_WIDTH-1:0] paddle1;
    reg [PADDLE_WIDTH-1:0] paddle2;
    wire [9:0] sx;
    wire [9:0] sy;

    paddle p1 #( WIDTH=PADDLE_WIDTH ) (
        .clk(clk),
        .reset(reset),
        .a(p1a),
        .b(p1b),
        .value(paddle1));

    paddle p2 #( WIDTH=PADDLE_WIDTH ) (
        .clk(clk),
        .reset(reset),
        .a(p2a),
        .b(p2b),
        .value(paddle2));

    vga vga(.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), .de(de));

    always @(posedge clk) begin
    end
endmodule
