module full_adder (
    input wire a,
    input wire b,
    input wire cin,
    output wire s,
    output wire cout
);

wire ab;
wire w1;
wire w2;

xor (ab, a, b);
xor (s, ab, cin);

and (w1, a, b);
and (w2, ab, cin);

or (cout, w1, w2);

endmodule
