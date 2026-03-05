module ULA (
    input  logic [5:0] A,
    input  logic [5:0] B,
    input  logic [3:0] Sel,         
    input  logic       Reset,
    output logic [5:0] O,           
    output logic       Overflow,   
    output logic       Zero        
);

    
    logic [5:0] saida_logica;
    logic [5:0] saida_aritmetica;
    logic       overflow_aritmetico, zero_aritmetico;

    
    ULA_logico unidade_logica (
		 A,
		 B,
		 Sel,
		 saida_logica
);

    
    ULA_aritmetico unidade_aritmetica (
		 A,
		 B,
		 Sel,
		 Reset,
		 saida_aritmetica,
		 overflow_aritmetico,
		 zero_aritmetico
);

    
    always_comb begin
        if (Sel[3] == 1'b0) begin
            O        = saida_aritmetica;
            Overflow = overflow_aritmetico;
            Zero     = zero_aritmetico;
        end else begin
            O        = saida_logica;
            Overflow = 1'b0; 
            Zero     = (saida_logica == 6'b000000);
        end
    end

endmodule
