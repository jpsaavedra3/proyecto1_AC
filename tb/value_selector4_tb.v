module value_selector4_tb;

reg clk;
reg reset;
reg enable;
reg inc;
reg dec;

wire [3:0] value;

value_selector4 dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .inc(inc),
    .dec(dec),
    .value(value)
);

// Reloj
always #5 clk = ~clk;

initial begin

    $display("time clk reset en inc dec | value");
    $display("--------------------------------");

    clk = 0;
    reset = 1;
    enable = 0;
    inc = 0;
    dec = 0;

    // Primer flanco: reset -> 0000
    #10;

    reset = 0;
    enable = 1;

    // Incrementar: 0000 -> 0001
    inc = 1;
    #10;
    inc = 0;
    #10;

    // Incrementar: 0001 -> 0010
    inc = 1;
    #10;
    inc = 0;
    #10;

    // Decrementar: 0010 -> 0001
    dec = 1;
    #10;
    dec = 0;
    #10;

    // Desactivar selector
    enable = 0;

    // Intentar incrementar:
    // value debe quedarse en 0001
    inc = 1;
    #10;
    inc = 0;
    #10;

    $finish;

end

initial begin
    $monitor(
        "%4t  %b    %b    %b   %b   %b  | %b",
        $time,
        clk,
        reset,
        enable,
        inc,
        dec,
        value
    );
end

endmodule
