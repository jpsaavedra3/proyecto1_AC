module button_pulse_tb;

reg clk;
reg reset;
reg button;

wire pulse;

button_pulse dut (
    .clk(clk),
    .reset(reset),
    .button(button),
    .pulse(pulse)
);


// Reloj
always #5 clk = ~clk;


initial begin

    $display("time clk reset button | pulse");
    $display("-----------------------------");

    clk = 0;
    reset = 1;
    button = 0;

    // Inicializar
    #20;

    reset = 0;


    // --------------------------------
    // Primera pulsacion
    // Mantener boton apretado bastante
    // --------------------------------

    #10;
    button = 1;

    // Lo dejamos apretado 40 unidades
    #40;

    button = 0;

    #30;


    // --------------------------------
    // Segunda pulsacion
    // --------------------------------

    button = 1;

    #30;

    button = 0;

    #30;


    $finish;

end


initial begin

    $monitor(
        "%4t  %b    %b      %b    |   %b",
        $time,
        clk,
        reset,
        button,
        pulse
    );

end

endmodule
