module display_driver (
    input wire [3:0] value,
    input wire enable,

    output wire s_a,
    output wire s_b,
    output wire s_c,
    output wire s_d,
    output wire s_e,
    output wire s_f,
    output wire s_g,

    output wire h_a,
    output wire h_b,
    output wire h_c,
    output wire h_d,
    output wire h_e,
    output wire h_f,
    output wire h_g
);

wire negative;
wire [3:0] magnitude;

wire sign_a;
wire sign_b;
wire sign_c;
wire sign_d;
wire sign_e;
wire sign_f;
wire sign_g;

wire hex_a;
wire hex_b;
wire hex_c;
wire hex_d;
wire hex_e;
wire hex_f;
wire hex_g;


// ----------------------------------------
// Obtener signo y magnitud
// ----------------------------------------

signed_magnitude4 sm (
    .value(value),
    .negative(negative),
    .magnitude(magnitude)
);


// ----------------------------------------
// Display izquierdo: signo
// ----------------------------------------

sign7seg sign_display (
    .negative(negative),
    .a(sign_a),
    .b(sign_b),
    .c(sign_c),
    .d(sign_d),
    .e(sign_e),
    .f(sign_f),
    .g(sign_g)
);


// ----------------------------------------
// Display derecho: hexadecimal
// ----------------------------------------

hex7seg hex_display (
    .hex(magnitude),
    .a(hex_a),
    .b(hex_b),
    .c(hex_c),
    .d(hex_d),
    .e(hex_e),
    .f(hex_f),
    .g(hex_g)
);


// ----------------------------------------
// enable = 0 -> todos los segmentos = 1
//              todos apagados
//
// enable = 1 -> mostrar displays
// ----------------------------------------

mux2_1 ms_a (.a(sign_a), .b(1'b1), .sel(enable), .y(s_a));
mux2_1 ms_b (.a(sign_b), .b(1'b1), .sel(enable), .y(s_b));
mux2_1 ms_c (.a(sign_c), .b(1'b1), .sel(enable), .y(s_c));
mux2_1 ms_d (.a(sign_d), .b(1'b1), .sel(enable), .y(s_d));
mux2_1 ms_e (.a(sign_e), .b(1'b1), .sel(enable), .y(s_e));
mux2_1 ms_f (.a(sign_f), .b(1'b1), .sel(enable), .y(s_f));
mux2_1 ms_g (.a(sign_g), .b(1'b1), .sel(enable), .y(s_g));

mux2_1 mh_a (.a(hex_a), .b(1'b1), .sel(enable), .y(h_a));
mux2_1 mh_b (.a(hex_b), .b(1'b1), .sel(enable), .y(h_b));
mux2_1 mh_c (.a(hex_c), .b(1'b1), .sel(enable), .y(h_c));
mux2_1 mh_d (.a(hex_d), .b(1'b1), .sel(enable), .y(h_d));
mux2_1 mh_e (.a(hex_e), .b(1'b1), .sel(enable), .y(h_e));
mux2_1 mh_f (.a(hex_f), .b(1'b1), .sel(enable), .y(h_f));
mux2_1 mh_g (.a(hex_g), .b(1'b1), .sel(enable), .y(h_g));

endmodule
