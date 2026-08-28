module calculator (
    input wire clk,
    input wire reset,

    input wire inc,
    input wire dec,
    input wire confirm,
    input wire select_prev,

    output wire [1:0] state,
    output wire [2:0] op,
    output wire [3:0] op1,
    output wire [3:0] op2,
    output wire [3:0] result,

    output wire use_prev
);

wire selecting_op;
wire entering_op1;
wire entering_op2;
wire showing_result;

wire execute;
wire clear_prev;


// --------------------------------------------------
// 1. Control de entrada
// --------------------------------------------------

input_controller inputs (
    .clk(clk),
    .reset(reset),

    .inc(inc),
    .dec(dec),
    .confirm(confirm),

    .state(state),
    .op(op),
    .op1(op1),
    .op2(op2),

    .selecting_op(selecting_op),
    .entering_op1(entering_op1),
    .entering_op2(entering_op2),
    .showing_result(showing_result)
);


// --------------------------------------------------
// 2. Ejecutar cuando confirmamos op2
// --------------------------------------------------

and (execute, entering_op2, confirm);


// --------------------------------------------------
// 3. Limpiar use_prev cuando salimos del resultado
// --------------------------------------------------

and (clear_prev, showing_result, confirm);


// --------------------------------------------------
// 4. Seleccion de resultado anterior
// --------------------------------------------------

use_prev_selector prev_selector (
    .clk(clk),
    .reset(reset),

    .clear(clear_prev),
    .enable(entering_op2),
    .select_prev(select_prev),

    .use_prev(use_prev)
);


// --------------------------------------------------
// 5. Nucleo de la calculadora
// --------------------------------------------------

calculator_core core (
    .op1(op1),
    .op2_ext(op2),

    .use_prev(use_prev),

    .op(op),

    .execute(execute),
    .clk(clk),

    .result(result)
);

endmodule
