`timescale 1ns / 1ps

module mux2 #(parameter W=8)(
    input logic s,
    input logic [W-1:0] a,b,
    output logic [W-1:0] y
    );
    always@(*)
        case(s)
        1'b0: y=a;
        1'b1: y=b;
        endcase
endmodule

module mux4 #(parameter W=8)(
    input logic [1:0]s,
    input logic [W-1:0] a,b,c,d,
    output logic [W-1:0] y
    );
    always@(*)
        case(s)
        2'b00: y=a;
        2'b01: y=b;
        2'b10: y=c;
        2'b11: y=d;
        endcase
endmodule