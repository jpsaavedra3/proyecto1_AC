module hex7seg (
    input wire [3:0] hex,
    output wire a,
    output wire b,
    output wire c,
    output wire d,
    output wire e,
    output wire f,
    output wire g
);

wire n3;
wire n2;
wire n1;
wire n0;

wire d0;
wire d1;
wire d2;
wire d3;
wire d4;
wire d5;
wire d6;
wire d7;
wire d8;
wire d9;
wire d10;
wire d11;
wire d12;
wire d13;
wire d14;
wire d15;

wire a_on;
wire b_on;
wire c_on;
wire d_on;
wire e_on;
wire f_on;
wire g_on;


// Invertir entradas

not (n3, hex[3]);
not (n2, hex[2]);
not (n1, hex[1]);
not (n0, hex[0]);


// Decoder 4 a 16

and (d0,  n3, n2, n1, n0);
and (d1,  n3, n2, n1, hex[0]);
and (d2,  n3, n2, hex[1], n0);
and (d3,  n3, n2, hex[1], hex[0]);

and (d4,  n3, hex[2], n1, n0);
and (d5,  n3, hex[2], n1, hex[0]);
and (d6,  n3, hex[2], hex[1], n0);
and (d7,  n3, hex[2], hex[1], hex[0]);

and (d8,  hex[3], n2, n1, n0);
and (d9,  hex[3], n2, n1, hex[0]);
and (d10, hex[3], n2, hex[1], n0);
and (d11, hex[3], n2, hex[1], hex[0]);

and (d12, hex[3], hex[2], n1, n0);
and (d13, hex[3], hex[2], n1, hex[0]);
and (d14, hex[3], hex[2], hex[1], n0);
and (d15, hex[3], hex[2], hex[1], hex[0]);


// Segmento A encendido para:
// 0,2,3,5,6,7,8,9,A,C,E,F

or (a_on,
    d0, d2, d3, d5, d6, d7,
    d8, d9, d10, d12, d14, d15);


// Segmento B
// 0,1,2,3,4,7,8,9,A,d

or (b_on,
    d0, d1, d2, d3, d4,
    d7, d8, d9, d10, d13);


// Segmento C
// 0,1,3,4,5,6,7,8,9,A,b,d

or (c_on,
    d0, d1, d3, d4, d5, d6,
    d7, d8, d9, d10, d11, d13);


// Segmento D
// 0,2,3,5,6,8,9,b,C,d,E

or (d_on,
    d0, d2, d3, d5, d6,
    d8, d9, d11, d12, d13, d14);


// Segmento E
// 0,2,6,8,A,b,C,d,E,F

or (e_on,
    d0, d2, d6, d8, d10,
    d11, d12, d13, d14, d15);


// Segmento F
// 0,4,5,6,8,9,A,b,C,E,F

or (f_on,
    d0, d4, d5, d6, d8, d9,
    d10, d11, d12, d14, d15);


// Segmento G
// 2,3,4,5,6,8,9,A,b,d,E,F

or (g_on,
    d2, d3, d4, d5, d6, d8,
    d9, d10, d11, d13, d14, d15);


// La Go Board usa segmentos activos en bajo.
// on = 1 internamente -> salida fisica = 0

not (a, a_on);
not (b, b_on);
not (c, c_on);
not (d, d_on);
not (e, e_on);
not (f, f_on);
not (g, g_on);

endmodule
