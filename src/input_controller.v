module input_controller (
    input wire clk,
    input wire reset,
    input wire inc,
    input wire dec,
    input wire confirm,

    output wire [1:0] state,
    output wire [2:0] op,
    output wire [3:0] op1,
    output wire [3:0] op2,

    output wire selecting_op,
    output wire entering_op1,
    output wire entering_op2,
    output wire showing_result
);


// --------------------------------------------------
// 1. Maquina de estados
// --------------------------------------------------

state_controller states (
    .clk(clk),
    .reset(reset),
    .confirm(confirm),

    .state(state),

    .selecting_op(selecting_op),
    .entering_op1(entering_op1),
    .entering_op2(entering_op2),
    .showing_result(showing_result)
);


// --------------------------------------------------
// 2. Selector de operacion
//
// Solo responde a + y - cuando estamos en state 00
// --------------------------------------------------

operation_selector op_selector (
    .clk(clk),
    .reset(reset),
    .enable(selecting_op),
    .inc(inc),
    .dec(dec),
    .op(op)
);


// --------------------------------------------------
// 3. Selector de op1
//
// Solo responde a + y - cuando estamos en state 01
// --------------------------------------------------

value_selector4 op1_selector (
    .clk(clk),
    .reset(reset),
    .enable(entering_op1),
    .inc(inc),
    .dec(dec),
    .value(op1)
);


// --------------------------------------------------
// 4. Selector de op2
//
// Solo responde a + y - cuando estamos en state 10
// --------------------------------------------------

value_selector4 op2_selector (
    .clk(clk),
    .reset(reset),
    .enable(entering_op2),
    .inc(inc),
    .dec(dec),
    .value(op2)
);

endmodule
