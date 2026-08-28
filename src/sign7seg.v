module sign7seg (
    input wire negative,
    output wire a,
    output wire b,
    output wire c,
    output wire d,
    output wire e,
    output wire f,
    output wire g
);

// Segmentos a-f siempre apagados
buf (a, 1'b1);
buf (b, 1'b1);
buf (c, 1'b1);
buf (d, 1'b1);
buf (e, 1'b1);
buf (f, 1'b1);

// negative = 0 -> g = 1 -> apagado
// negative = 1 -> g = 0 -> encendido
not (g, negative);

endmodule
