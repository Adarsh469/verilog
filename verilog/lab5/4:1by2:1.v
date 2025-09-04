module mux2to1 (
    input  wire d0, d1,   // data inputs
    input  wire sel,      // select line
    output reg  y         // output
);
    always @(*) begin
        if (sel == 1'b0)
            y = d0;
        else
            y = d1;
    end
endmodule


module mux4to1 (
    input  wire [3:0] d,   // 4 data inputs
    input  wire [1:0] sel, // 2-bit select
    output wire y          // output
);
    wire y1, y2;

    // First stage: two 2:1 muxes
    mux2to1 m1 (.d0(d[0]), .d1(d[1]), .sel(sel[0]), .y(y1));
    mux2to1 m2 (.d0(d[2]), .d1(d[3]), .sel(sel[0]), .y(y2));

    // Second stage: one 2:1 mux
    mux2to1 m3 (.d0(y1), .d1(y2), .sel(sel[1]), .y(y));
endmodule
