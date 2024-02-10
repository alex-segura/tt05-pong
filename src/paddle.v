`default_nettype none
`timescale 1ns/1ns
module paddle (
    input wire clk,
    input wire reset,
    input wire a,
    input wire b,
    output wire [9:0] move
);
    wire adb, bdb;
    debounce #(.HIST_LEN(4)) dpa(.clk(clk), .reset(reset), .button(a), .debounced(adb));
    debounce #(.HIST_LEN(4)) dpb(.clk(clk), .reset(reset), .button(b), .debounced(bdb));
    encoder #(.WIDTH(10)) enc(.clk(clk), .reset(reset), .a(adb), .b(bdb), .value(move));
endmodule
