module signed_magnitude4_tb;

reg [3:0] value;

wire negative;
wire [3:0] magnitude;

signed_magnitude4 dut (
    .value(value),
    .negative(negative),
    .magnitude(magnitude)
);

initial begin

    $display("value | neg | magnitude");
    $display("-----------------------");

    value = 4'b0011; #10;   // +3
    value = 4'b0111; #10;   // +7
    value = 4'b1101; #10;   // -3
    value = 4'b1111; #10;   // -1
    value = 4'b1000; #10;   // -8

    $finish;

end

initial begin
    $monitor("%b  |  %b  |   %b",
             value, negative, magnitude);
end

endmodule
