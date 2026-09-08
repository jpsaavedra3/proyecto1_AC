module register4_tb;

reg [3:0] d;
reg load;
reg clk;

wire [3:0] q;

register4 dut (
    .d(d),
    .load(load),
    .clk(clk),
    .q(q)
);

// Genera el reloj:
// cada 5 unidades cambia entre 0 y 1
always #5 clk = ~clk;

initial begin

    $display("time  clk load   d   |   q");

    clk = 0;
    load = 1;
    d = 4'b0101;

    // En el primer flanco positivo debe guardar 0101
    #10;

    // Cambiamos d, pero load=0
    // El registro debe SEGUIR guardando 0101
    load = 0;
    d = 4'b1111;
    #10;

    // Ahora permitimos guardar el nuevo valor
    load = 1;
    d = 4'b0011;
    #10;

    // Volvemos a bloquear la escritura
    load = 0;
    d = 4'b1000;
    #10;

    $finish;

end

initial begin
    $monitor("%4t   %b    %b   %b | %b",
             $time, clk, load, d, q);
end

endmodule
