module sign7seg_tb;

reg negative;

wire a;
wire b;
wire c;
wire d;
wire e;
wire f;
wire g;

sign7seg dut (
    .negative(negative),
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .e(e),
    .f(f),
    .g(g)
);

initial begin

    $display("negative | abcdefg");
    $display("------------------");

    negative = 0;
    #10;

    negative = 1;
    #10;

    $finish;

end

initial begin
    $monitor("    %b    | %b%b%b%b%b%b%b",
             negative, a, b, c, d, e, f, g);
end

endmodule
