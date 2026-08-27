module barrel_shift4 (
    input wire [3:0] x,
    input wire [1:0] cant,
    input wire dir,
    output wire [3:0] z
);

wire [3:0] left;
wire [3:0] right;

shift_left4 sl (
    .x(x),
    .cant(cant),
    .z(left)
);

shift_right4 sr (
    .x(x),
    .cant(cant),
    .z(right)
);

mux2_4 mux_dir (
    .a(right),
    .b(left),
    .sel(dir),
    .y(z)
);

endmodule
