module mux2_1 (
    input wire a,
    input wire b,
    input wire sel,
    output wire y
);

wire nsel;
wire t1;
wire t2;

not (nsel, sel);

and (t1, sel, a);
and (t2, nsel, b);

or (y, t1, t2);

endmodule
