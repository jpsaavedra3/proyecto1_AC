module operation_selector (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire inc,
    input wire dec,
    output reg [2:0] op
);

wire inc_en;
wire dec_en;

wire [3:0] op4;
wire [3:0] raw_inc;
wire [3:0] raw_dec;

wire cout_inc;
wire cout_dec;

wire is_five;
wire is_zero;

wire [3:0] inc_value;
wire [3:0] dec_value;

wire [3:0] after_dec;
wire [3:0] after_inc;
wire [3:0] next_value;

wire nop2;
wire nop1;
wire nop0;


// Extender op de 3 bits a 4 bits
buf (op4[0], op[0]);
buf (op4[1], op[1]);
buf (op4[2], op[2]);
buf (op4[3], 1'b0);


// Los botones solo funcionan cuando enable = 1
and (inc_en, inc, enable);
and (dec_en, dec, enable);


// Calcular op + 1
add_sub4 add_one (
    .a(op4),
    .b(4'b0001),
    .sub(1'b0),
    .s(raw_inc),
    .cout(cout_inc)
);


// Calcular op - 1
add_sub4 sub_one (
    .a(op4),
    .b(4'b0001),
    .sub(1'b1),
    .s(raw_dec),
    .cout(cout_dec)
);


// Detectar op = 101 (5)
not (nop1, op[1]);

and (is_five, op[2], nop1, op[0]);


// Detectar op = 000
not (nop2, op[2]);
not (nop0, op[0]);

and (is_zero, nop2, nop1, nop0);


// Si estamos en 101 y aumentamos,
// volver a 000
mux2_4 wrap_inc (
    .a(4'b0000),
    .b(raw_inc),
    .sel(is_five),
    .y(inc_value)
);


// Si estamos en 000 y disminuimos,
// volver a 101
mux2_4 wrap_dec (
    .a(4'b0101),
    .b(raw_dec),
    .sel(is_zero),
    .y(dec_value)
);


// Aplicar decremento si corresponde
mux2_4 select_dec (
    .a(dec_value),
    .b(op4),
    .sel(dec_en),
    .y(after_dec)
);


// Aplicar incremento si corresponde
mux2_4 select_inc (
    .a(inc_value),
    .b(after_dec),
    .sel(inc_en),
    .y(after_inc)
);


// Reset -> operación 000
mux2_4 select_reset (
    .a(4'b0000),
    .b(after_inc),
    .sel(reset),
    .y(next_value)
);


// Guardar operación
always @(posedge clk) begin
    op[0] <= next_value[0];
    op[1] <= next_value[1];
    op[2] <= next_value[2];
end

endmodule
