`timescale 1ns/1ps

module tb_ULA_aritmetico;

    logic [5:0] A, B;
    logic [3:0] Sel;
    logic Reset;
    logic [5:0] O;
    logic Overflow, Zero;

    // Instância do módulo a ser testado
    ULA_aritmetico dut (
        .A(A),
        .B(B),
        .Sel(Sel),
        .Reset(Reset),
        .O(O),
        .Overflow(Overflow),
        .Zero(Zero)
    );

    // Função para gerar número aleatório entre 0 e 63
    function logic [5:0] random_6bit();
        return $urandom_range(0, 63);
    endfunction

    initial begin
        Reset = 0;
        $display("Iniciando testes aleatórios da ULA_aritmetico...\n");

        for (int i = 0; i < 5; i++) begin
            A = random_6bit();
            B = random_6bit();

            $display("---- Teste %0d: A = %0d, B = %0d ----", i+1, A, B);
            
            for (Sel = 4'b0000; Sel <= 4'b0111; Sel++) begin
                #1; // pequena espera entre operações
                $display("Sel=%b -> O=%0d, Overflow=%b, Zero=%b", 
                         Sel, O, Overflow, Zero);
            end

            $display("");
        end

        $display("Todos os testes concluídos.");
        $stop;
    end

endmodule
