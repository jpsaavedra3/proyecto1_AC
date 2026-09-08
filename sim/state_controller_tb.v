module state_controller_tb;

reg clk;
reg reset;
reg confirm;

wire [1:0] state;
wire selecting_op;
wire entering_op1;
wire entering_op2;
wire showing_result;

state_controller dut (
    .clk(clk),
    .reset(reset),
    .confirm(confirm),
    .state(state),
    .selecting_op(selecting_op),
    .entering_op1(entering_op1),
    .entering_op2(entering_op2),
    .showing_result(showing_result)
);

// Reloj
always #5 clk = ~clk;

initial begin

    $display("time clk reset confirm | state | sel_op op1 op2 result");
    $display("------------------------------------------------------");

    clk = 0;
    reset = 1;
    confirm = 0;

    // Primer flanco: forzar estado inicial 00
    #10;

    reset = 0;

    // Confirmacion 1: 00 -> 01
    confirm = 1;
    #10;
    confirm = 0;
    #10;

    // Confirmacion 2: 01 -> 10
    confirm = 1;
    #10;
    confirm = 0;
    #10;

    // Confirmacion 3: 10 -> 11
    confirm = 1;
    #10;
    confirm = 0;
    #10;

    // Confirmacion 4: 11 -> 00
    confirm = 1;
    #10;
    confirm = 0;
    #10;

    $finish;

end

initial begin
    $monitor(
        "%4t  %b    %b      %b    |  %b   |   %b     %b   %b    %b",
        $time,
        clk,
        reset,
        confirm,
        state,
        selecting_op,
        entering_op1,
        entering_op2,
        showing_result
    );
end

endmodule
