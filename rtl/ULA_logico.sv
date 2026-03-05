module ULA_logico (
    input  logic [5:0] A,
    input  logic [5:0] B,
    input  logic [3:0] sel,      
    output logic [5:0] saida_logica
);
    always_comb begin
        case (sel)
            4'b1000: saida_logica = A & B;        
            4'b1001: saida_logica = ~A;           
            4'b1010: saida_logica = ~B;           
            4'b1011: saida_logica = A | B;        
            4'b1100: saida_logica = A ^ B;        
            4'b1101: saida_logica = ~(A & B);     
            4'b1110: saida_logica = A;            
            4'b1111: saida_logica = B;            
            default: saida_logica = 6'b000000;
        endcase
    end
endmodule
