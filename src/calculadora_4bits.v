// ===================================================================
//  Adaptador para el testbench del foro.
//
//  El testbench espera un modulo llamado calculadora_4bits con los
//  nombres de puerto del enunciado. Este envoltorio los traduce a
//  los de nuestro calculator_core, sin tocar el diseno.
// ===================================================================
module calculadora_4bits (
    input  wire       clk,
    input  wire       ejecutar,
    input  wire [2:0] codigo,
    input  wire       sel_op2,
    input  wire [3:0] op1,
    input  wire [3:0] op2_ext,
    output wire [3:0] resultado
);

    calculator_core core (
        .clk      (clk),
        .execute  (ejecutar),
        .op       (codigo),
        .use_prev (sel_op2),
        .op1      (op1),
        .op2_ext  (op2_ext),
        .result   (resultado)
    );

endmodule
