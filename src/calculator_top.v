module calculator_top (
    input wire i_Clk,

    input wire i_Switch_1,
    input wire i_Switch_2,
    input wire i_Switch_3,
    input wire i_Switch_4,

    output wire o_LED_1,
    output wire o_LED_2,
    output wire o_LED_3,
    output wire o_LED_4,

    output wire o_Segment1_A,
    output wire o_Segment1_B,
    output wire o_Segment1_C,
    output wire o_Segment1_D,
    output wire o_Segment1_E,
    output wire o_Segment1_F,
    output wire o_Segment1_G,

    output wire o_Segment2_A,
    output wire o_Segment2_B,
    output wire o_Segment2_C,
    output wire o_Segment2_D,
    output wire o_Segment2_E,
    output wire o_Segment2_F,
    output wire o_Segment2_G
);


// ======================================================
// RESET DE ENCENDIDO
// ======================================================

// Los flip-flops de iCE40 parten en 0.
// Durante el primer ciclo reset = 1.
// Despues queda permanentemente en 0.

reg started = 1'b0;
wire reset;

always @(posedge i_Clk) begin
    started <= 1'b1;
end

not (reset, started);


// ======================================================
// BOTONES LIMPIOS
// ======================================================

wire inc_clean;
wire dec_clean;
wire confirm_clean;
wire prev_clean;

wire inc_pulse;
wire dec_pulse;
wire confirm_pulse;
wire prev_pulse;


// SW1 = incrementar

debouncer debounce_inc (
    .clk(i_Clk),
    .reset(reset),
    .button(i_Switch_1),
    .clean(inc_clean)
);

button_pulse pulse_inc (
    .clk(i_Clk),
    .reset(reset),
    .button(inc_clean),
    .pulse(inc_pulse)
);


// SW2 = disminuir

debouncer debounce_dec (
    .clk(i_Clk),
    .reset(reset),
    .button(i_Switch_2),
    .clean(dec_clean)
);

button_pulse pulse_dec (
    .clk(i_Clk),
    .reset(reset),
    .button(dec_clean),
    .pulse(dec_pulse)
);


// SW3 = confirmar

debouncer debounce_confirm (
    .clk(i_Clk),
    .reset(reset),
    .button(i_Switch_3),
    .clean(confirm_clean)
);

button_pulse pulse_confirm (
    .clk(i_Clk),
    .reset(reset),
    .button(confirm_clean),
    .pulse(confirm_pulse)
);


// SW4 = usar resultado anterior

debouncer debounce_prev (
    .clk(i_Clk),
    .reset(reset),
    .button(i_Switch_4),
    .clean(prev_clean)
);

button_pulse pulse_prev (
    .clk(i_Clk),
    .reset(reset),
    .button(prev_clean),
    .pulse(prev_pulse)
);


// ======================================================
// CALCULADORA
// ======================================================

wire [1:0] state;
wire [2:0] op;

wire [3:0] op1;
wire [3:0] op2;
wire [3:0] result;

wire use_prev;

calculator calc (
    .clk(i_Clk),
    .reset(reset),

    .inc(inc_pulse),
    .dec(dec_pulse),
    .confirm(confirm_pulse),
    .select_prev(prev_pulse),

    .state(state),
    .op(op),
    .op1(op1),
    .op2(op2),
    .result(result),
    .use_prev(use_prev)
);


// ======================================================
// LEDS
// Mostrar codigo de operacion
// ======================================================

buf (o_LED_1, op[2]);
buf (o_LED_2, op[1]);
buf (o_LED_3, op[0]);

// LED 4 no utilizado
buf (o_LED_4, 1'b0);


// ======================================================
// ELEGIR QUE VALOR MOSTRAR
// ======================================================

wire [3:0] display_value;
wire display_enable;

display_value_selector display_selector (
    .state(state),
    .op1(op1),
    .op2(op2),
    .result(result),
    .use_prev(use_prev),
    .value(display_value),
    .enable(display_enable)
);


// ======================================================
// DISPLAYS
//
// Segment1 = signo
// Segment2 = magnitud hexadecimal
// ======================================================

display_driver displays (
    .value(display_value),
    .enable(display_enable),

    .s_a(o_Segment1_A),
    .s_b(o_Segment1_B),
    .s_c(o_Segment1_C),
    .s_d(o_Segment1_D),
    .s_e(o_Segment1_E),
    .s_f(o_Segment1_F),
    .s_g(o_Segment1_G),

    .h_a(o_Segment2_A),
    .h_b(o_Segment2_B),
    .h_c(o_Segment2_C),
    .h_d(o_Segment2_D),
    .h_e(o_Segment2_E),
    .h_f(o_Segment2_F),
    .h_g(o_Segment2_G)
);

endmodule
