module hex7seg_tb;

reg [3:0] hex;

wire a;
wire b;
wire c;
wire d;
wire e;
wire f;
wire g;

hex7seg dut (
    .hex(hex),
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .e(e),
    .f(f),
    .g(g)
);

initial begin

    $display("hex  | abcdefg");
    $display("---------------");

    hex = 4'b0000; #10;   // 0
    hex = 4'b0001; #10;   // 1
    hex = 4'b0010; #10;   // 2
    hex = 4'b0011; #10;   // 3
    hex = 4'b0100; #10;   // 4
    hex = 4'b0101; #10;   // 5
    hex = 4'b0110; #10;   // 6
    hex = 4'b0111; #10;   // 7
    hex = 4'b1000; #10;   // 8
    hex = 4'b1001; #10;   // 9
    hex = 4'b1010; #10;   // A
    hex = 4'b1011; #10;   // b
    hex = 4'b1100; #10;   // C
    hex = 4'b1101; #10;   // d
    hex = 4'b1110; #10;   // E
    hex = 4'b1111; #10;   // F

    $finish;

end

initial begin
    $monitor("%h    | %b%b%b%b%b%b%b",
             hex, a, b, c, d, e, f, g);
end

endmodule
