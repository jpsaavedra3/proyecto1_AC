module increment18 (
    input wire [17:0] a,
    input wire enable,
    output wire [17:0] s,
    output wire cout
);

wire [16:0] c;

// Bit 0:
// si enable = 1, suma 1
full_adder fa0 (
    .a(a[0]),
    .b(1'b0),
    .cin(enable),
    .s(s[0]),
    .cout(c[0])
);

// Bits 1 a 16
full_adder fa1  (.a(a[1]),  .b(1'b0), .cin(c[0]),  .s(s[1]),  .cout(c[1]));
full_adder fa2  (.a(a[2]),  .b(1'b0), .cin(c[1]),  .s(s[2]),  .cout(c[2]));
full_adder fa3  (.a(a[3]),  .b(1'b0), .cin(c[2]),  .s(s[3]),  .cout(c[3]));
full_adder fa4  (.a(a[4]),  .b(1'b0), .cin(c[3]),  .s(s[4]),  .cout(c[4]));
full_adder fa5  (.a(a[5]),  .b(1'b0), .cin(c[4]),  .s(s[5]),  .cout(c[5]));
full_adder fa6  (.a(a[6]),  .b(1'b0), .cin(c[5]),  .s(s[6]),  .cout(c[6]));
full_adder fa7  (.a(a[7]),  .b(1'b0), .cin(c[6]),  .s(s[7]),  .cout(c[7]));
full_adder fa8  (.a(a[8]),  .b(1'b0), .cin(c[7]),  .s(s[8]),  .cout(c[8]));
full_adder fa9  (.a(a[9]),  .b(1'b0), .cin(c[8]),  .s(s[9]),  .cout(c[9]));
full_adder fa10 (.a(a[10]), .b(1'b0), .cin(c[9]),  .s(s[10]), .cout(c[10]));
full_adder fa11 (.a(a[11]), .b(1'b0), .cin(c[10]), .s(s[11]), .cout(c[11]));
full_adder fa12 (.a(a[12]), .b(1'b0), .cin(c[11]), .s(s[12]), .cout(c[12]));
full_adder fa13 (.a(a[13]), .b(1'b0), .cin(c[12]), .s(s[13]), .cout(c[13]));
full_adder fa14 (.a(a[14]), .b(1'b0), .cin(c[13]), .s(s[14]), .cout(c[14]));
full_adder fa15 (.a(a[15]), .b(1'b0), .cin(c[14]), .s(s[15]), .cout(c[15]));
full_adder fa16 (.a(a[16]), .b(1'b0), .cin(c[15]), .s(s[16]), .cout(c[16]));

full_adder fa17 (
    .a(a[17]),
    .b(1'b0),
    .cin(c[16]),
    .s(s[17]),
    .cout(cout)
);

endmodule
