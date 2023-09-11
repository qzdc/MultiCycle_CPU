`timescale 1ns / 1ps


module mips_top(
    input logic clk,res,
    output logic [31:0]writedata,adr,
    output logic memwr
    );
    logic [31:0] readdata;
    memory Memory(clk,memwr,adr,writedata,readdata);
    mips MIPS(clk,res,readdata,memwr,adr,writedata);
endmodule
