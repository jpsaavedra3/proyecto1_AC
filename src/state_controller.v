module state_controller (
    input wire clk,
    input wire reset,
    input wire confirm,

    output reg [1:0] state,

    output wire selecting_op,
    output wire entering_op1,
    output wire entering_op2,
    output wire showing_result
);

wire next0;
wire next1;
wire carry;

wire d0;
wire d1;

wire nstate0;
wire nstate1;


// --------------------------------------------------
// Avanzar al siguiente estado cuando confirm = 1
//
// 00 -> 01
// 01 -> 10
// 10 -> 11
// 11 -> 00
// --------------------------------------------------

xor (next0, state[0], confirm);

and (carry, state[0], confirm);
xor (next1, state[1], carry);


// --------------------------------------------------
// Reset:
// reset = 1 -> state = 00
// reset = 0 -> funcionamiento normal
// --------------------------------------------------

mux2_1 reset_mux0 (
    .a(1'b0),
    .b(next0),
    .sel(reset),
    .y(d0)
);

mux2_1 reset_mux1 (
    .a(1'b0),
    .b(next1),
    .sel(reset),
    .y(d1)
);


// --------------------------------------------------
// Registro de estado
// --------------------------------------------------

always @(posedge clk) begin
    state[0] <= d0;
    state[1] <= d1;
end


// --------------------------------------------------
// Decodificar en que estado estamos
// --------------------------------------------------

not (nstate0, state[0]);
not (nstate1, state[1]);

and (selecting_op,   nstate1, nstate0); // 00
and (entering_op1,   nstate1, state[0]); // 01
and (entering_op2,   state[1], nstate0); // 10
and (showing_result, state[1], state[0]); // 11

endmodule
