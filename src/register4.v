module register4 (
    input wire [3:0] d,
    input wire load,
    input wire clk,
    output reg [3:0] q
);

wire [3:0] next_q;

mux2_4 mux_load (
    .a(d),
    .b(q),
    .sel(load),
    .y(next_q)
);

always @(posedge clk) begin
    q <= next_q;
end

endmodule
