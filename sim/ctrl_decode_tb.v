module ctrl_decode_tb;

reg [2:0] op;

wire zero;
wire swap;
wire sub;
wire is_shift;
wire dir;

ctrl_decode dut (
    .op(op),
    .zero(zero),
    .swap(swap),
    .sub(sub),
    .is_shift(is_shift),
    .dir(dir)
);

initial begin

    $display(" op | zero swap sub shift dir");
    $display("--------------------------------");

    op = 3'b000; #10;
    op = 3'b001; #10;
    op = 3'b010; #10;
    op = 3'b011; #10;
    op = 3'b100; #10;
    op = 3'b101; #10;

    $finish;

end

initial begin
    $monitor("%b |   %b    %b    %b    %b    %b",
             op, zero, swap, sub, is_shift, dir);
end

endmodule
