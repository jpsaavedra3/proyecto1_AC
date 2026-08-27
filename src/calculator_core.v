module calculator_core (
    input wire [3:0] op1,
    input wire [3:0] op2_ext,
    input wire use_prev,
    input wire [2:0] op,
    input wire execute,
    input wire clk,
    output wire [3:0] result
);

wire [3:0] op2_eff;
wire [3:0] alu_result;


// 1. Elegir segundo operando:
// use_prev = 0 -> op2 externo
// use_prev = 1 -> resultado anterior
mux2_4 select_op2 (
    .a(result),
    .b(op2_ext),
    .sel(use_prev),
    .y(op2_eff)
);


// 2. Realizar la operacion
alu4 alu (
    .a(op1),
    .b(op2_eff),
    .op(op),
    .r(alu_result)
);


// 3. Guardar el resultado cuando execute = 1
register4 result_register (
    .d(alu_result),
    .load(execute),
    .clk(clk),
    .q(result)
);

endmodule

