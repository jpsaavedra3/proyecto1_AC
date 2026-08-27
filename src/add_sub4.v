module add_sub4 (
    input wire [3:0] a,
    input wire [3:0] b,
    input wire sub,
    output wire [3:0] s,
    output wire cout
);

wire [3:0] be;

wire c0;
wire c1;
wire c2;

xor (be[0], b[0], sub);
xor (be[1], b[1], sub);
xor (be[2], b[2], sub);
xor (be[3], b[3], sub);

full_adder fa0 (
    .a(a[0]),
    .b(be[0]),
    .cin(sub),
    .s(s[0]),
    .cout(c0)
);

full_adder fa1 (
    .a(a[1]),
    .b(be[1]),
    .cin(c0),
    .s(s[1]),
    .cout(c1)
);

full_adder fa2 (
    .a(a[2]),
    .b(be[2]),
    .cin(c1),
    .s(s[2]),
    .cout(c2)
);

full_adder fa3 (
    .a(a[3]),
    .b(be[3]),
    .cin(c2),
    .s(s[3]),
    .cout(cout)
);

endmodule

