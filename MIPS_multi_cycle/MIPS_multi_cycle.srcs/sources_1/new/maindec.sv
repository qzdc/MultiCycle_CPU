`timescale 1ns / 1ps


module maindec(
    input logic clk,res,
    input logic [5:0] op,
    output logic pcwrite,memwrite,irwrite,regwrite,alusrca,branch,iord,memtoreg,regdst,
    output logic [1:0] alusrcb,pcsrc,
    output logic [2:0] aluop
    );
    
    localparam fetch=4'b0000,decode=4'b0001,memadr=4'b0010,memrd=4'b0011,
               memwb=4'b0100,memwr=4'b0101,rtypeex=4'b0110,rtypewb=4'b0111,
               bex=4'b1000,addiex=4'b1001,iwb=4'b1010,jex=4'b1011,
               subiex=4'b1100,andiex=4'b1101,oriex=4'b1110;
               
    localparam lw=6'b100011,sw=6'b101011,rtype=6'b000000,beq=6'b000100,
               addi=6'b001000,j=6'b000010,andi=6'b001100,ori=6'b001101,
               slti=6'b001010,bne=6'b000101,subi=6'b001001;
    
    logic [3:0]state,nextstate;
    logic [15:0]controls;
    
    always_ff @(posedge clk or posedge res)
        if(res) state<=fetch;
        else    state<=nextstate;
        
    always_comb
        case(state)
            fetch:  nextstate=decode;
            decode:case(op)
                    lw:     nextstate=memadr;
                    sw:     nextstate=memadr;
                    rtype:  nextstate=rtypeex;
                    beq:    nextstate=bex;
                    bne:   nextstate=bex;
                    addi:   nextstate=addiex;
                    j:      nextstate=jex;
                    subi:   nextstate=subiex;
                    andi:   nextstate=andiex;
                    ori:    nextstate=oriex;
                    default:nextstate=4'bxxxx;
                endcase
            memadr:case(op)
                    lw:     nextstate=memrd;
                    sw:     nextstate=memwr;
                    default:nextstate=4'bxxxx;
                endcase
            memrd:      nextstate=memwb;
            memwb:      nextstate=fetch;
            memwr:      nextstate=fetch;
            rtypeex:    nextstate=rtypewb;
            rtypewb:    nextstate=fetch;
            bex:        nextstate=fetch;
            addiex:     nextstate=iwb;
            andiex:     nextstate=iwb;
            subiex:     nextstate=iwb;
            oriex:     nextstate=iwb;
            iwb:     nextstate=fetch;
            jex:        nextstate=fetch;
            default:    nextstate=4'bxxxx;
        endcase
    
    assign {pcwrite,memwrite,irwrite,regwrite,alusrca,
            branch,iord,memtoreg,regdst,alusrcb,pcsrc,aluop}=controls;
            
    always_comb
        case(state)
            fetch:  controls=16'b1010000000100000;
            decode: controls=16'b0000000001100000;
            memadr: controls=16'b0000100001000000;
            memrd:  controls=16'b0000001000000000;
            memwb:  controls=16'b0001000100000000;
            memwr:  controls=16'b0100001000000000;
            rtypeex:controls=16'b0000100000000010;
            rtypewb:controls=16'b0001000010000000;
            bex:    controls=16'b0000110000001001;
            addiex: controls=16'b0000100001000000;
            subiex: controls=16'b0000100001000001;
            andiex: controls=16'b0000100001000100;
            oriex:  controls=16'b0000100001000101;
            iwb:    controls=16'b0001000000000000;
            jex:    controls=16'b1000000000010000;
            default:controls=16'bxxxx;
        endcase
    
endmodule
