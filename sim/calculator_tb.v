module calculator_tb;

reg clk;
reg reset;

reg inc;
reg dec;
reg confirm;
reg select_prev;

wire [1:0] state;
wire [2:0] op;
wire [3:0] op1;
wire [3:0] op2;
wire [3:0] result;
wire use_prev;


calculator dut (
    .clk(clk),
    .reset(reset),

    .inc(inc),
    .dec(dec),
    .confirm(confirm),
    .select_prev(select_prev),

    .state(state),
    .op(op),
    .op1(op1),
    .op2(op2),
    .result(result),

    .use_prev(use_prev)
);


// Reloj
always #5 clk = ~clk;


initial begin

    $display("time state | op  op1  op2 | prev | result | inc dec conf sel_prev");
    $display("----------------------------------------------------------------");

    clk = 0;
    reset = 1;

    inc = 0;
    dec = 0;
    confirm = 0;
    select_prev = 0;

    // Inicializar
    #10;
    reset = 0;


    // ============================================================
    // PRIMERA OPERACION
    // 3 + 2 = 5
    // ============================================================


    // ------------------------------------------------------------
    // STATE 00: seleccionar SUMA
    // 000 -> 001
    // ------------------------------------------------------------

    inc = 1;
    #10;
    inc = 0;
    #10;

    // Confirmar operacion
    confirm = 1;
    #10;
    confirm = 0;
    #10;


    // ------------------------------------------------------------
    // STATE 01: ingresar OP1 = 3
    // ------------------------------------------------------------

    // 0 -> 1
    inc = 1;
    #10;
    inc = 0;
    #10;

    // 1 -> 2
    inc = 1;
    #10;
    inc = 0;
    #10;

    // 2 -> 3
    inc = 1;
    #10;
    inc = 0;
    #10;

    // Confirmar op1
    confirm = 1;
    #10;
    confirm = 0;
    #10;


    // ------------------------------------------------------------
    // STATE 10: ingresar OP2 = 2
    // ------------------------------------------------------------

    // 0 -> 1
    inc = 1;
    #10;
    inc = 0;
    #10;

    // 1 -> 2
    inc = 1;
    #10;
    inc = 0;
    #10;

    // Confirmar op2 y EJECUTAR
    confirm = 1;
    #10;
    confirm = 0;
    #10;


    // Ahora:
    // state  = 11
    // result = 0101 = 5


    // ------------------------------------------------------------
    // Volver al inicio para una nueva operacion
    // ------------------------------------------------------------

    confirm = 1;
    #10;
    confirm = 0;
    #10;


    // ============================================================
    // SEGUNDA OPERACION
    // 1 + resultado anterior
    // 1 + 5 = 6
    // ============================================================


    // ------------------------------------------------------------
    // STATE 00
    //
    // op ya sigue siendo 001 = suma,
    // por lo que no necesitamos modificarlo.
    // ------------------------------------------------------------

    confirm = 1;
    #10;
    confirm = 0;
    #10;


    // ------------------------------------------------------------
    // STATE 01
    //
    // op1 actualmente vale 3.
    // Lo bajamos hasta 1.
    // ------------------------------------------------------------

    // 3 -> 2
    dec = 1;
    #10;
    dec = 0;
    #10;

    // 2 -> 1
    dec = 1;
    #10;
    dec = 0;
    #10;

    // Confirmar op1
    confirm = 1;
    #10;
    confirm = 0;
    #10;


    // ------------------------------------------------------------
    // STATE 10
    //
    // Elegir RESULTADO ANTERIOR como segundo operando.
    // El op2 que está guardado se debe ignorar.
    // ------------------------------------------------------------

    select_prev = 1;
    #10;

    select_prev = 0;
    #10;


    // Ahora use_prev debe quedar guardado en 1.

    // Confirmar op2 y ejecutar
    confirm = 1;
    #10;
    confirm = 0;
    #10;


    // Ahora deberíamos tener:
    //
    // result = 0110 = 6
    // porque:
    //
    // 1 + resultado anterior
    // 1 + 5 = 6


    #20;

    $finish;

end


initial begin

    $monitor(
        "%4t   %b   | %b  %b  %b |  %b   |  %b   |  %b   %b   %b    %b",
        $time,
        state,
        op,
        op1,
        op2,
        use_prev,
        result,
        inc,
        dec,
        confirm,
        select_prev
    );

end


// Archivo para GTKWave
initial begin
    $dumpfile("calculator.vcd");
    $dumpvars(0, calculator_tb);
end


endmodule
