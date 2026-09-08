module use_prev_selector_tb;

reg clk;
reg reset;
reg clear;
reg enable;
reg select_prev;

wire use_prev;

use_prev_selector dut (
    .clk(clk),
    .reset(reset),
    .clear(clear),
    .enable(enable),
    .select_prev(select_prev),
    .use_prev(use_prev)
);

// Reloj
always #5 clk = ~clk;

initial begin

    $display("time clk reset clear en select | use_prev");
    $display("------------------------------------------");

    clk = 0;
    reset = 1;
    clear = 0;
    enable = 0;
    select_prev = 0;

    // Reset -> use_prev = 0
    #10;

    reset = 0;

    // Intentar seleccionar fuera del estado op2:
    // enable = 0, no debe cambiar
    select_prev = 1;
    #10;
    select_prev = 0;
    #10;

    // Ahora habilitamos selección de resultado anterior
    enable = 1;

    // Pulsar botón -> use_prev debe pasar a 1
    select_prev = 1;
    #10;
    select_prev = 0;
    #10;

    // Aunque soltamos el botón,
    // use_prev debe seguir siendo 1
    #10;

    // Limpiar para una nueva operación
    clear = 1;
    #10;
    clear = 0;
    #10;

    $finish;

end

initial begin
    $monitor(
        "%4t  %b    %b     %b    %b    %b    |    %b",
        $time,
        clk,
        reset,
        clear,
        enable,
        select_prev,
        use_prev
    );
end

endmodule
