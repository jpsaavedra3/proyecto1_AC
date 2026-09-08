module mux2_4_tb;

reg [3:0] a;
reg [3:0] b;
reg sel;

wire [3:0] y;

mux2_4 dut (
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
);

initial begin

    $display("   a      b    sel |   y");

    a = 4'b1011;
    b = 4'b0010;
    sel = 0;
    #10;

    sel = 1;
    #10;

    a = 4'b1111;
    b = 4'b0000;
    sel = 0;
    #10;

    sel = 1;
    #10;

    $finish;

end

initial begin
    $monitor("%b   %b    %b  | %b", a, b, sel, y);
end

endmodule
