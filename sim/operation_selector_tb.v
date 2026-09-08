module operation_selector_tb;

reg clk;
reg reset;
reg enable;
reg inc;
reg dec;

wire [2:0] op;

operation_selector dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .inc(inc),
    .dec(dec),
    .op(op)
);

// Reloj
always #5 clk = ~clk;

initial begin

    $display("time clk reset en inc dec | op");
    $display("--------------------------------");

    clk = 0;
    reset = 1;
    enable = 0;
    inc = 0;
    dec = 0;

    // Reset -> 000
    #10;

    reset = 0;
    enable = 1;

    // ------------------------
    // SUBIR OPERACIONES
    // ------------------------

    // 000 -> 001
    inc = 1; #10;
    inc = 0; #10;

    // 001 -> 010
    inc = 1; #10;
    inc = 0; #10;

    // 010 -> 011
    inc = 1; #10;
    inc = 0; #10;

    // 011 -> 100
    inc = 1; #10;
    inc = 0; #10;

    // 100 -> 101
    inc = 1; #10;
    inc = 0; #10;

    // 101 -> 000
    inc = 1; #10;
    inc = 0; #10;


    // ------------------------
    // BAJAR OPERACIONES
    // ------------------------

    // 000 -> 101
    dec = 1; #10;
    dec = 0; #10;

    // 101 -> 100
    dec = 1; #10;
    dec = 0; #10;

    // 100 -> 011
    dec = 1; #10;
    dec = 0; #10;


    // ------------------------
    // PROBAR ENABLE = 0
    // ------------------------

    enable = 0;

    // No debería cambiar
    inc = 1; #10;
    inc = 0; #10;

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
        op
    );
end

endmodule
