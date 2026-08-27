module shift_left4 (
    input wire [3:0] x,
    input wire [1:0] cant,
    output wire [3:0] z
);

wire [3:0] y;

// Etapa 1: desplaza 1 posicion si cant[0] = 1
mux2_1 e1_3 (
    .a(x[2]),
    .b(x[3]),
    .sel(cant[0]),
    .y(y[3])
);

mux2_1 e1_2 (
    .a(x[1]),
    .b(x[2]),
    .sel(cant[0]),
    .y(y[2])
);

mux2_1 e1_1 (
    .a(x[0]),
    .b(x[1]),
    .sel(cant[0]),
    .y(y[1])
);

mux2_1 e1_0 (
    .a(1'b0),
    .b(x[0]),
    .sel(cant[0]),
    .y(y[0])
);

// Etapa 2: desplaza 2 posiciones si cant[1] = 1
mux2_1 e2_3 (
    .a(y[1]),
    .b(y[3]),
    .sel(cant[1]),
    .y(z[3])
);

mux2_1 e2_2 (
    .a(y[0]),
    .b(y[2]),
    .sel(cant[1]),
    .y(z[2])
);

mux2_1 e2_1 (
    .a(1'b0),
    .b(y[1]),
    .sel(cant[1]),
    .y(z[1])
);

mux2_1 e2_0 (
    .a(1'b0),
    .b(y[0]),
    .sel(cant[1]),
    .y(z[0])
);

endmodule
