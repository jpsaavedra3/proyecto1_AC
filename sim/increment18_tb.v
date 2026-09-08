module increment18_tb;

reg [17:0] a;
reg enable;

wire [17:0] s;
wire cout;

increment18 dut (
    .a(a),
    .enable(enable),
    .s(s),
    .cout(cout)
);

initial begin

    $display("a                   en | s                   cout");
    $display("------------------------------------------------");

    // enable = 0: conservar valor
    a = 18'b000000000000000000;
    enable = 0;
    #10;

    // 0 + 1 = 1
    a = 18'b000000000000000000;
    enable = 1;
    #10;

    // 5 + 1 = 6
    a = 18'b000000000000000101;
    enable = 1;
    #10;

    // Penultimo valor + 1 = maximo
    a = 18'b111111111111111110;
    enable = 1;
    #10;

    // Maximo + 1 = 0 y cout = 1
    a = 18'b111111111111111111;
    enable = 1;
    #10;

    $finish;

end

initial begin
    $monitor("%b  %b | %b   %b",
             a, enable, s, cout);
end

endmodule
