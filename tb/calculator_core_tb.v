module calculator_core_tb;

reg [3:0] op1;
reg [3:0] op2_ext;
reg use_prev;
reg [2:0] op;
reg execute;
reg clk;

wire [3:0] result;

calculator_core dut (
    .op1(op1),
    .op2_ext(op2_ext),
    .use_prev(use_prev),
    .op(op),
    .execute(execute),
    .clk(clk),
    .result(result)
);

// Reloj:
// cambia de 0 a 1 o de 1 a 0 cada 5 unidades
always #5 clk = ~clk;

initial begin

    $display("time clk exec prev | op1  op2   op  | result");
    $display("------------------------------------------------");

    clk = 0;

    // ---------------------------------
    // OPERACION 1:
    // 3 + 2 = 5
    // ---------------------------------

    op1 = 4'b0011;       // 3
    op2_ext = 4'b0010;   // 2
    use_prev = 0;        // usar op2 externo
    op = 3'b001;         // suma
    execute = 1;         // guardar resultado

    #10;

    // En t=5 ocurrio un flanco positivo.
    // El registro ya debe contener 0101 = 5.

    execute = 0;

    #10;


    // ---------------------------------
    // OPERACION 2:
    // 1 + resultado anterior
    // 1 + 5 = 6
    // ---------------------------------

    op1 = 4'b0001;       // 1
    op2_ext = 4'b1111;   // debe ser ignorado
    use_prev = 1;        // usar resultado anterior
    op = 3'b001;         // suma
    execute = 1;         // guardar nuevo resultado

    #10;

    // En t=25 deberia guardar 0110 = 6.

    execute = 0;

    #10;

    $finish;

end

initial begin
    $monitor("%4t   %b    %b    %b   | %b  %b  %b |  %b",
             $time, clk, execute, use_prev,
             op1, op2_ext, op, result);
end

endmodule
