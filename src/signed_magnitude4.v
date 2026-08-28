module signed_magnitude4 (
    input wire [3:0] value,
    output wire negative,
    output wire [3:0] magnitude
);

wire cout;

// El bit 3 indica el signo
buf (negative, value[3]);

// Si negative = 0:
//     0 + value = value
//
// Si negative = 1:
//     0 - value = magnitud

add_sub4 magnitude_calc (
    .a(4'b0000),
    .b(value),
    .sub(negative),
    .s(magnitude),
    .cout(cout)
);

endmodule
