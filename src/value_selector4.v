module value_selector4 (
    input wire clk,
    input wire reset,
    input wire enable,
    input wire inc,
    input wire dec,
    output reg [3:0] value
);

wire inc_en;
wire dec_en;

wire [3:0] value_inc;
wire [3:0] value_dec;

wire [3:0] after_dec;
wire [3:0] after_inc;
wire [3:0] next_value;

wire cout_inc;
wire cout_dec;


// Los botones solo funcionan cuando enable = 1
and (inc_en, inc, enable);
and (dec_en, dec, enable);


// Calcular value + 1
add_sub4 add_one (
    .a(value),
    .b(4'b0001),
    .sub(1'b0),
    .s(value_inc),
    .cout(cout_inc)
);


// Calcular value - 1
add_sub4 sub_one (
    .a(value),
    .b(4'b0001),
    .sub(1'b1),
    .s(value_dec),
    .cout(cout_dec)
);


// Si dec_en = 1, usar value - 1.
// Si no, conservar value.
mux2_4 select_dec (
    .a(value_dec),
    .b(value),
    .sel(dec_en),
    .y(after_dec)
);


// Si inc_en = 1, usar value + 1.
// Si no, conservar el resultado anterior.
mux2_4 select_inc (
    .a(value_inc),
    .b(after_dec),
    .sel(inc_en),
    .y(after_inc)
);


// Reset fuerza el valor a 0000
mux2_4 select_reset (
    .a(4'b0000),
    .b(after_inc),
    .sel(reset),
    .y(next_value)
);


// Guardar el nuevo valor
always @(posedge clk) begin
    value <= next_value;
end

endmodule
