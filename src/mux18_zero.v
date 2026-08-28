module mux18_zero (
    input wire [17:0] a,
    input wire sel,
    output wire [17:0] y
);

mux2_1 m0  (.a(a[0]),  .b(1'b0), .sel(sel), .y(y[0]));
mux2_1 m1  (.a(a[1]),  .b(1'b0), .sel(sel), .y(y[1]));
mux2_1 m2  (.a(a[2]),  .b(1'b0), .sel(sel), .y(y[2]));
mux2_1 m3  (.a(a[3]),  .b(1'b0), .sel(sel), .y(y[3]));
mux2_1 m4  (.a(a[4]),  .b(1'b0), .sel(sel), .y(y[4]));
mux2_1 m5  (.a(a[5]),  .b(1'b0), .sel(sel), .y(y[5]));
mux2_1 m6  (.a(a[6]),  .b(1'b0), .sel(sel), .y(y[6]));
mux2_1 m7  (.a(a[7]),  .b(1'b0), .sel(sel), .y(y[7]));
mux2_1 m8  (.a(a[8]),  .b(1'b0), .sel(sel), .y(y[8]));
mux2_1 m9  (.a(a[9]),  .b(1'b0), .sel(sel), .y(y[9]));
mux2_1 m10 (.a(a[10]), .b(1'b0), .sel(sel), .y(y[10]));
mux2_1 m11 (.a(a[11]), .b(1'b0), .sel(sel), .y(y[11]));
mux2_1 m12 (.a(a[12]), .b(1'b0), .sel(sel), .y(y[12]));
mux2_1 m13 (.a(a[13]), .b(1'b0), .sel(sel), .y(y[13]));
mux2_1 m14 (.a(a[14]), .b(1'b0), .sel(sel), .y(y[14]));
mux2_1 m15 (.a(a[15]), .b(1'b0), .sel(sel), .y(y[15]));
mux2_1 m16 (.a(a[16]), .b(1'b0), .sel(sel), .y(y[16]));
mux2_1 m17 (.a(a[17]), .b(1'b0), .sel(sel), .y(y[17]));

endmodule
