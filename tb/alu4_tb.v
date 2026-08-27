module alu4_tb;

reg [3:0] a;
reg [3:0] b;
reg [2:0] op;

wire [3:0] r;

alu4 dut (
    .a(a),
    .b(b),
    .op(op),
    .r(r)
);

initial begin

    $display("   a      b     op  |   r");
    $display("--------------------------------");

    // RESET
    a = 4'b0101;
    b = 4'b0010;
    op = 3'b000;
    #10;

    // SUMA: 3 + 2 = 5
    a = 4'b0011;
    b = 4'b0010;
    op = 3'b001;
    #10;

    // RESTA: 5 - 2 = 3
    a = 4'b0101;
    b = 4'b0010;
    op = 3'b010;
    #10;

    // RESTA INVERSA: 2 - 5 = -3
    a = 4'b0101;
    b = 4'b0010;
    op = 3'b011;
    #10;

    // SHIFT LEFT
    // A = 0011
    // B[1:0] = 10 -> desplazar 2
    // Resultado esperado: 1100
    a = 4'b0011;
    b = 4'b0010;
    op = 3'b100;
    #10;

    // SHIFT RIGHT
    // A = 1100
    // B[1:0] = 10 -> desplazar 2
    // Resultado esperado: 0011
    a = 4'b1100;
    b = 4'b0010;
    op = 3'b101;
    #10;

    $finish;

end

initial begin
    $monitor("%b   %b   %b | %b",
             a, b, op, r);
end

endmodule
