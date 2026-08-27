module ctrl_decode (
    input wire [2:0] op,
    output wire zero,
    output wire swap,
    output wire sub,
    output wire is_shift,
    output wire dir
);

wire nop2;
wire nop1;
wire nop0;
wire z1;

not (nop2, op[2]);
not (nop1, op[1]);
not (nop0, op[0]);

and (z1, nop2, nop1);
and (zero, z1, nop0);

buf (sub, op[1]);

and (swap, op[1], op[0]);

buf (is_shift, op[2]);

buf (dir, op[0]);

endmodule
