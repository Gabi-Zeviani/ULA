`timescale 1ns/1ps

module tb_ULA_logico;

    logic [5:0] A, B;
    logic [3:0] sel;
    logic [5:0] saida_logica;

    // Instância do módulo ULA_logico
    ULA_logico dut (
        .A(A),
        .B(B),
        .sel(sel),
        .saida_logica(saida_logica)
    );

    // Arrays para guardar os 5 valores aleatórios de A e B
    logic [5:0] A_values [0:4];
    logic [5:0] B_values [0:4];

    integer i, j;

    initial begin
        // Gerar 5 valores aleatórios para A e B
        for (i = 0; i < 5; i = i + 1) begin
            A_values[i] = $urandom_range(0, 63); // 6 bits, valor de 0 a 63
            B_values[i] = $urandom_range(0, 63);
        end

        // Testar todas as combinações dos valores A, B e sel
        for (i = 0; i < 5; i = i + 1) begin
            A = A_values[i];
            B = B_values[i];
            for (j = 8; j <= 15; j = j + 1) begin
                sel = j;
                #10; // esperar 10 unidades de tempo para estabilizar a saída
                $display("Tempo %0t | A = %06b (%0d) | B = %06b (%0d) | sel = %04b | saida_logica = %06b",
                         $time, A, A, B, B, sel, saida_logica);
            end
        end

        $finish;
    end

endmodule
