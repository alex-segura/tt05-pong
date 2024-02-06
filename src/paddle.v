module paddle #( WIDTH = 8 ) (
    input wire clk,
    input wire reset,
    input wire a,
    input wire b,
    output [WIDTH-1:0] wire value
);
    wire adb, bdb;
    wire [WIDTH-1:0] val;
    debounce dpa(.clk(clk), .reset(reset), .button(a), .debounced(adb));
    debounce dpb(.clk(clk), .reset(reset), .button(b), .debounced(bdb));
    encoder p1 #( WIDTH = PADDLE_WIDTH )
    (.clk(clk), .reset(reset), .a(adb), .b(bdb), .value(value));
endmodule
