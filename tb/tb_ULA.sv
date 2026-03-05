`timescale 1ns/1ps

module tb_ULA;

    logic [5:0] A, B;
    logic [3:0] Sel;
    logic Reset;
    logic [5:0] O;
    logic Overflow;
    logic Zero;

    // Instancia a ULA
    ULA dut (
        .A(A),
        .B(B),
        .Sel(Sel),
        .Reset(Reset),
        .O(O),
        .Overflow(Overflow),
        .Zero(Zero)
    );

    logic [5:0] A_values [0:4];
    logic [5:0] B_values [0:4];

    integer i, j, k;

    initial begin
        // Gerar 5 valores aleatórios para A e B
        for (i = 0; i < 5; i = i + 1) begin
            A_values[i] = $urandom_range(0, 63);
            B_values[i] = $urandom_range(0, 63);
        end

        // Testar todas as combinações de A, B, Sel e Reset
        for (i = 0; i < 5; i = i + 1) begin
            A = A_values[i];
            B = B_values[i];
            for (j = 0; j <= 15; j = j + 1) begin
                Sel = j;
                for (k = 0; k <= 1; k = k + 1) begin
                    Reset = k;
                    #10; // espera estabilizar saída
                    $display("Tempo %0t | Reset=%b | Sel=%04b | A=%06b (%0d) | B=%06b (%0d) | O=%06b | Overflow=%b | Zero=%b",
                             $time, Reset, Sel, A, A, B, B, O, Overflow, Zero);
                end
            end
        end

        $finish;
    end

endmodule
