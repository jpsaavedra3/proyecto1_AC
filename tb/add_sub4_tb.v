module add_sub4_tb;

reg [3:0] a;
reg [3:0] b;
reg sub;

wire [3:0] s;
wire cout;

add_sub4 dut (
    .a(a),
    .b(b),
    .sub(sub),
    .s(s),
    .cout(cout)
);

initial begin

    $display("   a      b    sub |   s    cout");

    // 3 + 2 = 5
    a = 4'b0011;
    b = 4'b0010;
    sub = 0;
    #10;

    // 5 + 3 = 8
    a = 4'b0101;
    b = 4'b0011;
    sub = 0;
    #10;

    // 5 - 2 = 3
    a = 4'b0101;
    b = 4'b0010;
    sub = 1;
    #10;

    // 2 - 5 = -3
    a = 4'b0010;
    b = 4'b0101;
    sub = 1;
    #10;

    // -3 + 2 = -1
    a = 4'b1101;
    b = 4'b0010;
    sub = 0;
    #10;

    $finish;

end

initial begin
    $monitor("%b   %b    %b  | %b    %b",
             a, b, sub, s, cout);
end

endmodule

