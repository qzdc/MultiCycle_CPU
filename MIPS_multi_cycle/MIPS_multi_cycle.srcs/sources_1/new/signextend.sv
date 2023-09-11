`timescale 1ns / 1ps


module signextend(
    input logic [15:0] a,
    input logic c,
    output logic [31:0] y
    );
    assign y=c?{16'b0,a}:{{16{a[15]}},a};
endmodule
