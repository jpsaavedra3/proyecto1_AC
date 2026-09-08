module display_value_selector_tb;

reg [1:0] state;
reg [3:0] op1;
reg [3:0] op2;
reg [3:0] result;
reg use_prev;

wire [3:0] value;
wire enable;

display_value_selector dut (
    .state(state),
    .op1(op1),
    .op2(op2),
    .result(result),
    .use_prev(use_prev),
    .value(value),
    .enable(enable)
);

initial begin

    $display("state use_prev | value enable");
    $display("-----------------------------");

    op1 = 4'b0011;      // 3
    op2 = 4'b0010;      // 2
    result = 4'b0101;   // 5
    use_prev = 0;


    // Seleccionando operacion
    state = 2'b00;
    #10;


    // Ingresando op1
    state = 2'b01;
    #10;


    // Ingresando op2 externo
    state = 2'b10;
    #10;


    // Mostrando resultado
    state = 2'b11;
    #10;


    // Ingresando op2 usando resultado anterior
    state = 2'b10;
    use_prev = 1;
    #10;


    $finish;

end


initial begin
    $monitor(" %b       %b    | %b    %b",
             state, use_prev, value, enable);
end

endmodule
