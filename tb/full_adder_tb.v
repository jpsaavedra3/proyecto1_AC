module full_adder_tb;

reg a;
reg b;
reg cin;

wire s;
wire cout;

full_adder dut (
    .a(a),
    .b(b),
    .cin(cin),
    .s(s),
    .cout(cout)
);

initial begin

    $display("a b cin | cout s");

    a = 0; b = 0; cin = 0; #10;
    a = 0; b = 0; cin = 1; #10;
    a = 0; b = 1; cin = 0; #10;
    a = 0; b = 1; cin = 1; #10;
    a = 1; b = 0; cin = 0; #10;
    a = 1; b = 0; cin = 1; #10;
    a = 1; b = 1; cin = 0; #10;
    a = 1; b = 1; cin = 1; #10;

    $finish;

end

initial begin
    $monitor("%b %b  %b  |   %b   %b", a, b, cin, cout, s);
end

endmodule

