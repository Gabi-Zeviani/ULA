module ULA_aritmetico(A, B, Sel, Reset, O, Overflow, Zero);
    input  logic [5:0] A, B;
    input  logic [3:0] Sel;
    input  logic       Reset;
    output logic [5:0] O;
    output logic       Overflow, Zero;

    // === Tasks da ULA ===

    task automatic soma_6_bits(input logic [5:0] A, B,
                                output logic [5:0] S,
                                output logic Overflow, Zero);
        logic [6:0] tmp_result;
        tmp_result = A + B;
        S = tmp_result[5:0];
        Overflow = tmp_result[6];
        Zero = (S == 6'b000000 && !Overflow);
    endtask

    task automatic subtracao_6_bits(input logic [5:0] A, B,
                                     output logic [5:0] S,
                                     output logic Overflow, Zero);
        logic signed [6:0] A_ext_signed, B_ext_signed, result_signed;
        A_ext_signed = {A[5], A};
        B_ext_signed = {B[5], B};
        result_signed = A_ext_signed - B_ext_signed;
        S = result_signed[5:0];
        Overflow = (A[5] != B[5]) && (S[5] != A[5]);
        Zero = (S == 6'b000000);
    endtask

    task automatic soma_inverso_6_bits(input logic [5:0] A, B,
                                       output logic [5:0] S,
                                       output logic Overflow, Zero);
        logic [6:0] tmp_result;
        tmp_result = A + ~B;
        S = tmp_result[5:0];
        Overflow = tmp_result[6];
        Zero = (S == 6'b000000 && !Overflow);
    endtask

    task automatic subtracao_inverso_6_bits(input logic [5:0] A, B,
                                            output logic [5:0] S,
                                            output logic Overflow, Zero);
        logic signed [6:0] A_ext_signed, B_ext_signed, result_signed;
        A_ext_signed = {A[5], A};
        B_ext_signed = {B[5], ~B};
        result_signed = A_ext_signed - B_ext_signed;
        S = result_signed[5:0];
        Overflow = (A[5] != ~B[5]) && (S[5] != A[5]);
        Zero = (S == 6'b000000);
    endtask

    task automatic incremento(input logic [5:0] X,
                              output logic [5:0] S,
                              output logic Overflow, Zero);
        if (X == 6'b111111) begin
            S = X;
            Overflow = 1;
            Zero = 0;
        end else begin
            S = X + 1;
            Overflow = 0;
            Zero = (S == 0);
        end
    endtask

    task automatic decremento(input logic [5:0] X,
                              output logic [5:0] S,
                              output logic Overflow, Zero);
        if (X == 6'b000000) begin
            S = X;
            Overflow = 0;
            Zero = 1;
        end else begin
            S = X - 1;
            Overflow = 0;
            Zero = 0;
        end
    endtask

    // === Lógica principal ===

    always @(*) begin
        if (Reset) begin
            O = 6'b000000;
            Overflow = 0;
            Zero = 1;
        end else begin
            case (Sel)
                4'b0000: soma_6_bits(A, B, O, Overflow, Zero);
                4'b0001: subtracao_6_bits(A, B, O, Overflow, Zero);
                4'b0010: soma_inverso_6_bits(A, B, O, Overflow, Zero);
                4'b0011: subtracao_inverso_6_bits(A, B, O, Overflow, Zero);
                4'b0100: incremento(A, O, Overflow, Zero);
                4'b0101: decremento(A, O, Overflow, Zero);
                4'b0110: incremento(B, O, Overflow, Zero);
                4'b0111: decremento(B, O, Overflow, Zero);
                default: begin
                    O = 6'b000000;
                    Overflow = 0;
                    Zero = 1;
                end
            endcase
        end
    end

endmodule
