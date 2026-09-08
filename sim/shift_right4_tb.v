module shift_right4_tb;

reg [3:0] x;
reg [1:0] cant;

wire [3:0] z;

shift_right4 dut (
    .x(x),
    .cant(cant),
    .z(z)
);

initial begin

    $display("   x    cant |   z");

    x = 4'b1100;

    cant = 2'b00;
    #10;

    cant = 2'b01;
    #10;

    cant = 2'b10;
    #10;

    cant = 2'b11;
    #10;

    $finish;

end

initial begin
    $monitor("%b     %b  | %b", x, cant, z);
end

endmodule

