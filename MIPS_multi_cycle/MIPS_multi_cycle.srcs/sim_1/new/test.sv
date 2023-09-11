`timescale 1ns / 1ps
module test();

    logic clk;
    logic reset;
    logic [7:0] in,out;
    
    flopenr F(clk,reset,0,in,out);
    
    initial
        begin
            in<=0;
            reset<=1;#22;reset<=0;#18 in<=8'bzzzzzzzz;
        end
        
    always
    begin
        clk<=1;#5;clk<=0;#5;
    end
endmodule