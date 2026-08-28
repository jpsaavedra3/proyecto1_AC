module button_pulse (
    input wire clk,
    input wire reset,
    input wire button,
    output wire pulse
);

reg button_sync1;
reg button_sync2;
reg button_prev;

wire d_sync1;
wire d_sync2;
wire d_prev;

wire nprev;


// Reset = 1 -> guardar 0
// Reset = 0 -> funcionamiento normal

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

mux2_1 reset_prev (
    .a(1'b0),
    .b(button_sync2),
    .sel(reset),
    .y(d_prev)
);


// Registros de sincronizacion y estado anterior

always @(posedge clk) begin
    button_sync1 <= d_sync1;
    button_sync2 <= d_sync2;
    button_prev  <= d_prev;
end


// Detectar flanco 0 -> 1

not (nprev, button_prev);
and (pulse, button_sync2, nprev);

endmodule
