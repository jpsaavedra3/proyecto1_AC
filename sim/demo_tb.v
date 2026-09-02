`timescale 1ns/1ps

// ===================================================================
//  TESTBENCH DE DEMOSTRACION
//
//  Para cambiar los valores de la evaluacion, edita SOLO el bloque
//  marcado como "VALORES" mas abajo. Cada linea es una operacion.
//
//      ejecutar( <operacion>, <op1>, <op2> );
//
//  Codigos de operacion:
//      3'b000  reinicio        3'b011  resta inversa (B - A)
//      3'b001  suma            3'b100  shift left
//      3'b010  resta (A - B)   3'b101  shift right
// ===================================================================

module demo_tb;

    reg  [3:0] op1, op2;
    reg  [2:0] op;
    wire [3:0] resultado;

    alu4 dut (.a(op1), .b(op2), .op(op), .r(resultado));

    reg [8*14:1] nombre;

    task ejecutar (input [2:0] t_op, input [3:0] t_op1, input [3:0] t_op2);
        begin
            op = t_op; op1 = t_op1; op2 = t_op2;
            #10;
            case (t_op)
                3'b000: nombre = "reinicio";
                3'b001: nombre = "suma";
                3'b010: nombre = "resta";
                3'b011: nombre = "resta inversa";
                3'b100: nombre = "shift left";
                3'b101: nombre = "shift right";
                default: nombre = "no valida";
            endcase
            $display("  %b  %-14s  op1=%b (%2d)   op2=%b (%2d)   ->  %b  (%0d sin signo, %0d con signo)",
                     op, nombre, op1, op1, op2, op2, resultado, resultado, $signed(resultado));
            #10;
        end
    endtask

    initial begin
        $dumpfile("build/demo.vcd");
        $dumpvars(0, demo_tb);

        $display("");
        $display("  op     operacion       operandos                     resultado");
        $display("  -------------------------------------------------------------------------");

        // ===============================================================
        //  VALORES  -  editar solo estas lineas
        // ===============================================================

        ejecutar(3'b001, 4'd5, 4'd2);   // suma
        ejecutar(3'b010, 4'd5, 4'd3);   // resta
        ejecutar(3'b011, 4'd3, 4'd5);   // resta inversa
        ejecutar(3'b100, 4'd3, 4'd2);   // shift left
        ejecutar(3'b101, 4'd12, 4'd2);  // shift right
        ejecutar(3'b000, 4'd9, 4'd9);   // reinicio

        // ===============================================================

        $display("");
        #20;
        $finish;
    end

endmodule
