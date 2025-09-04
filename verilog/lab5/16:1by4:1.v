module mux4to1 (
    input  wire [3:0] d,   // data inputs
    input  wire [1:0] sel, // 2-bit select
    output wire y          // output
);
    assign y = (sel == 2'b00) ? d[0] :
               (sel == 2'b01) ? d[1] :
               (sel == 2'b10) ? d[2] :
                                d[3];
endmodule

module mux16to1 (
    input  wire [15:0] d,   // 16 data inputs
    input  wire [3:0]  sel, // 4-bit select
    output wire y           // output
);
    wire y0, y1, y2, y3;

    // Four 4:1 muxes handle 4 groups
    mux4to1 m0 (.d(d[3:0]),    .sel(sel[1:0]), .y(y0));
    mux4to1 m1 (.d(d[7:4]),    .sel(sel[1:0]), .y(y1));
    mux4to1 m2 (.d(d[11:8]),   .sel(sel[1:0]), .y(y2));
    mux4to1 m3 (.d(d[15:12]),  .sel(sel[1:0]), .y(y3));

    // Final 4:1 mux chooses among y0–y3
    mux4to1 m4 (.d({y3,y2,y1,y0}), .sel(sel[3:2]), .y(y));
endmodule
