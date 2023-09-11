`timescale 1ns / 1ps

module flopenr#(parameter x=8)(
    input logic clk,res,en,
    input logic [x-1:0] d,
    output logic [x-1:0] q
    );
    
    always_ff@(posedge clk,posedge res)
    begin
        if(res)q<=0;
        else if(en)q<=d;
    end
endmodule

