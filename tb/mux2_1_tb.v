module mux2_1_tb;

reg a;
reg b;
reg sel;

wire y;

mux2_1 dut (
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
);

initial begin

    $display("a b sel | y");

    a = 0;
    b = 0;
    sel = 0;
    #10;

    a = 0;
    b = 1;
    sel = 0;
    #10;

    a = 1;
    b = 0;
    sel = 0;
    #10;

    a = 1;
    b = 1;
    sel = 0;
    #10;

    a = 0;
    b = 0;
    sel = 1;
    #10;

    a = 0;
    b = 1;
    sel = 1;
    #10;

    a = 1;
    b = 0;
    sel = 1;
    #10;

    a = 1;
    b = 1;
    sel = 1;
    #10;

    $finish;

end

initial begin
    $monitor("%b %b  %b  | %b", a, b, sel, y);
end

endmodule
