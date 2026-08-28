module display_value_selector (
    input wire [1:0] state,
    input wire [3:0] op1,
    input wire [3:0] op2,
    input wire [3:0] result,
    input wire use_prev,
    output wire [3:0] value,
    output wire enable
);

wire [3:0] op2_eff;
wire [3:0] low_state;
wire [3:0] high_state;


// ---------------------------------------
// Segundo operando:
// use_prev = 0 -> op2 externo
// use_prev = 1 -> resultado anterior
// ---------------------------------------

mux2_4 mux_op2 (
    .a(result),
    .b(op2),
    .sel(use_prev),
    .y(op2_eff)
);


// ---------------------------------------
// state[1] = 0:
//
// 00 -> 0000
// 01 -> op1
// ---------------------------------------

mux2_4 mux_low (
    .a(op1),
    .b(4'b0000),
    .sel(state[0]),
    .y(low_state)
);


// ---------------------------------------
// state[1] = 1:
//
// 10 -> op2_eff
// 11 -> result
// ---------------------------------------

mux2_4 mux_high (
    .a(result),
    .b(op2_eff),
    .sel(state[0]),
    .y(high_state)
);


// Elegir entre ambas mitades

mux2_4 mux_final (
    .a(high_state),
    .b(low_state),
    .sel(state[1]),
    .y(value)
);


// El display queda habilitado en
// estados 01, 10 y 11.
// En 00 queda apagado.

or (enable, state[1], state[0]);

endmodule
