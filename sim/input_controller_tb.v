module input_controller_tb;

reg clk;
reg reset;
reg inc;
reg dec;
reg confirm;

wire [1:0] state;
wire [2:0] op;
wire [3:0] op1;
wire [3:0] op2;

wire selecting_op;
wire entering_op1;
wire entering_op2;
wire showing_result;


input_controller dut (
    .clk(clk),
    .reset(reset),
    .inc(inc),
    .dec(dec),
    .confirm(confirm),

    .state(state),
    .op(op),
    .op1(op1),
    .op2(op2),

    .selecting_op(selecting_op),
    .entering_op1(entering_op1),
    .entering_op2(entering_op2),
    .showing_result(showing_result)
);


// Reloj
always #5 clk = ~clk;


initial begin

    $display("time state | op  op1  op2 | inc dec confirm");
    $display("------------------------------------------------");

    clk = 0;
    reset = 1;
    inc = 0;
    dec = 0;
    confirm = 0;

    // Inicializar todo
    #10;
    reset = 0;


    // ==========================================
    // STATE 00: seleccionar SUMA = 001
    // ==========================================

    // 000 -> 001
    inc = 1;
    #10;
    inc = 0;
    #10;

    // Confirmar operacion
    confirm = 1;
    #10;
    confirm = 0;
    #10;


    // ==========================================
    // STATE 01: ingresar op1 = 3
    // ==========================================

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


    // ==========================================
    // STATE 10: ingresar op2 = 2
    // ==========================================

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

    // Confirmar op2
    confirm = 1;
    #10;
    confirm = 0;
    #10;


    // Ahora deberiamos estar en state 11
    // op  = 001
    // op1 = 0011
    // op2 = 0010

    #10;

    $finish;

end


initial begin
    $monitor(
        "%4t   %b   | %b  %b  %b |  %b   %b    %b",
        $time,
        state,
        op,
        op1,
        op2,
        inc,
        dec,
        confirm
    );
end

endmodule
