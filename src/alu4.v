module alu4 (
    input wire [3:0] a,
    input wire [3:0] b,
    input wire [2:0] op,
    output wire [3:0] r
);

wire zero;
wire swap;
wire sub;
wire is_shift;
wire dir;
wire nzero;
wire cdesc;

wire [3:0] x;
wire [3:0] y;
wire [3:0] add;
wire [3:0] sh;
wire [3:0] pre;


// 1. Decodificar la operacion
ctrl_decode ctrl (
    .op(op),
    .zero(zero),
    .swap(swap),
    .sub(sub),
    .is_shift(is_shift),
    .dir(dir)
);


// 2. Intercambiar A y B cuando sea necesario
mux2_4 msx (
    .a(b),
    .b(a),
    .sel(swap),
    .y(x)
);

mux2_4 msy (
    .a(a),
    .b(b),
    .sel(swap),
    .y(y)
);


// 3. Suma o resta
add_sub4 asu (
    .a(x),
    .b(y),
    .sub(sub),
    .s(add),
    .cout(cdesc)
);


// 4. Desplazamientos
barrel_shift4 bs (
    .x(a),
    .cant(b[1:0]),
    .dir(dir),
    .z(sh)
);


// 5. Elegir entre resultado aritmetico y shift
mux2_4 mf (
    .a(sh),
    .b(add),
    .sel(is_shift),
    .y(pre)
);


// 6. Reinicio: forzar resultado a 0000
not (nzero, zero);

and (r[0], pre[0], nzero);
and (r[1], pre[1], nzero);
and (r[2], pre[2], nzero);
and (r[3], pre[3], nzero);

endmodule
