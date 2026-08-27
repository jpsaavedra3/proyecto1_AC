module barrel_shift4_tb;

reg [3:0] x;
reg [1:0] cant;
reg dir;

wire [3:0] z;

barrel_shift4 dut (
    .x(x),
    .cant(cant),
    .dir(dir),
    .z(z)
);

initial begin

    $display("   x    cant dir |   z");

    x = 4'b0011;

    // Shift left
    dir = 0;

    cant = 2'b00; #10;
    cant = 2'b01; #10;
    cant = 2'b10; #10;
    cant = 2'b11; #10;

    // Shift right
    x = 4'b1100;
    dir = 1;

    cant = 2'b00; #10;
    cant = 2'b01; #10;
    cant = 2'b10; #10;
    cant = 2'b11; #10;

    $finish;

end

initial begin
    $monitor("%b     %b   %b  | %b", x, cant, dir, z);
end

endmodule
