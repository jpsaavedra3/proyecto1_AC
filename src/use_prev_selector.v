module use_prev_selector (
    input wire clk,
    input wire reset,
    input wire clear,
    input wire enable,
    input wire select_prev,
    output reg use_prev
);

wire select_en;
wire keep_or_select;
wire after_clear;
wire next_value;


// El boton solo sirve cuando estamos ingresando op2
and (select_en, select_prev, enable);


// Una vez seleccionado, queda guardado en 1
or (keep_or_select, use_prev, select_en);


// Al comenzar una nueva operacion,
// borrar la seleccion anterior
mux2_1 clear_mux (
    .a(1'b0),
    .b(keep_or_select),
    .sel(clear),
    .y(after_clear)
);


// Reset tambien fuerza use_prev = 0
mux2_1 reset_mux (
    .a(1'b0),
    .b(after_clear),
    .sel(reset),
    .y(next_value)
);


always @(posedge clk) begin
    use_prev <= next_value;
end

endmodule
