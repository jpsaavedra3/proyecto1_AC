module display_driver_tb;

reg [3:0] value;
reg enable;

wire s_a, s_b, s_c, s_d, s_e, s_f, s_g;
wire h_a, h_b, h_c, h_d, h_e, h_f, h_g;

display_driver dut (
    .value(value),
    .enable(enable),

    .s_a(s_a),
    .s_b(s_b),
    .s_c(s_c),
    .s_d(s_d),
    .s_e(s_e),
    .s_f(s_f),
    .s_g(s_g),

    .h_a(h_a),
    .h_b(h_b),
    .h_c(h_c),
    .h_d(h_d),
    .h_e(h_e),
    .h_f(h_f),
    .h_g(h_g)
);

initial begin

    $display("value enable | sign    hex");
    $display("---------------------------");

    // Display apagado
    value = 4'b0011;
    enable = 0;
    #10;

    // +3
    value = 4'b0011;
    enable = 1;
    #10;

    // -3
    value = 4'b1101;
    enable = 1;
    #10;

    // -8
    value = 4'b1000;
    enable = 1;
    #10;

    $finish;

end

initial begin
    $monitor("%b    %b    | %b%b%b%b%b%b%b %b%b%b%b%b%b%b",
        value,
        enable,

        s_a, s_b, s_c, s_d, s_e, s_f, s_g,
        h_a, h_b, h_c, h_d, h_e, h_f, h_g
    );
end

endmodule
