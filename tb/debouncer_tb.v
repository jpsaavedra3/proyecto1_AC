`timescale 1ns/1ps

module debouncer_tb;

reg clk;
reg reset;
reg button;

wire clean;

debouncer dut (
    .clk(clk),
    .reset(reset),
    .button(button),
    .clean(clean)
);


// Reloj
always #1 clk = ~clk;


initial begin

    clk = 0;
    reset = 1;
    button = 0;

    $display("PRUEBA DEL DEBOUNCER");
    $display("--------------------");

    // Reset
    repeat (5) @(posedge clk);
    @(negedge clk);
    reset = 0;


    // ---------------------------------
    // Simular rebotes al PRESIONAR
    // ---------------------------------

    @(negedge clk);
    button = 1;

    repeat (10) @(posedge clk);

    @(negedge clk);
    button = 0;

    repeat (10) @(posedge clk);

    @(negedge clk);
    button = 1;

    repeat (10) @(posedge clk);

    @(negedge clk);
    button = 0;

    repeat (10) @(posedge clk);

    #1;
    $display("Despues de rebotes cortos:");
    $display("button = %b, clean = %b", button, clean);


    // ---------------------------------
    // Ahora mantener boton estable en 1
    // ---------------------------------

    @(negedge clk);
    button = 1;

    repeat (262160) @(posedge clk);

    #1;
    $display("");
    $display("Despues de mantener boton en 1:");
    $display("button = %b, clean = %b", button, clean);


    // ---------------------------------
    // Simular rebotes al SOLTAR
    // ---------------------------------

    @(negedge clk);
    button = 0;

    repeat (10) @(posedge clk);

    @(negedge clk);
    button = 1;

    repeat (10) @(posedge clk);

    @(negedge clk);
    button = 0;

    repeat (10) @(posedge clk);

    #1;
    $display("");
    $display("Durante rebotes al soltar:");
    $display("button = %b, clean = %b", button, clean);


    // ---------------------------------
    // Mantener boton estable en 0
    // ---------------------------------

    repeat (262160) @(posedge clk);

    #1;
    $display("");
    $display("Despues de mantener boton en 0:");
    $display("button = %b, clean = %b", button, clean);


    $finish;

end

endmodule
