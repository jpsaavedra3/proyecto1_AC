module debouncer (
    input wire clk,
    input wire reset,
    input wire button,
    output reg clean
);

reg button_sync1;
reg button_sync2;

reg [17:0] count;

wire d_sync1;
wire d_sync2;

wire different;

wire [17:0] count_inc;
wire count_cout;

wire [17:0] count_if_diff;
wire [17:0] next_count;

wire clean_after_wait;
wire next_clean;

wire nreset;
// --------------------------------------------------
// 1. Sincronizar boton fisico con el reloj
// --------------------------------------------------

mux2_1 reset_sync1 (
    .a(1'b0),
    .b(button),
    .sel(reset),
    .y(d_sync1)
);

mux2_1 reset_sync2 (
    .a(1'b0),
    .b(button_sync1),
    .sel(reset),
    .y(d_sync2)
);


// --------------------------------------------------
// 2. Ver si el boton sincronizado es distinto
//    del valor actualmente aceptado
// --------------------------------------------------

xor (different, button_sync2, clean);


// --------------------------------------------------
// 3. Incrementar contador mientras sean distintos
// --------------------------------------------------

increment18 counter_inc (
    .a(count),
    .enable(different),
    .s(count_inc),
    .cout(count_cout)
);


// Si different = 0 -> contador = 0
// Si different = 1 -> contador incrementado

mux18_zero select_count (
    .a(count_inc),
    .sel(different),
    .y(count_if_diff)
);

not(nreset, reset);
// Reset tambien fuerza contador a cero

mux18_zero reset_count (
    .a(count_if_diff),
    .sel(nreset),
    .y(next_count)
);


// --------------------------------------------------
// 4. Cuando el contador desborda,
//    aceptar el nuevo estado del boton
// --------------------------------------------------

mux2_1 accept_button (
    .a(button_sync2),
    .b(clean),
    .sel(count_cout),
    .y(clean_after_wait)
);


// Reset -> clean = 0

mux2_1 reset_clean (
    .a(1'b0),
    .b(clean_after_wait),
    .sel(reset),
    .y(next_clean)
);


// --------------------------------------------------
// 5. Registros
// --------------------------------------------------

always @(posedge clk) begin
    button_sync1 <= d_sync1;
    button_sync2 <= d_sync2;

    count <= next_count;
    clean <= next_clean;
end

endmodule
