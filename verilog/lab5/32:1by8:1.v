module mux8to1 (
    input  wire [7:0] d,     // data inputs
    input  wire [2:0] sel,   // 3-bit select
    output reg  y
);
    always @(*) begin
        if      (sel == 3'b000) y = d[0];
        else if (sel == 3'b001) y = d[1];
        else if (sel == 3'b010) y = d[2];
        else if (sel == 3'b011) y = d[3];
        else if (sel == 3'b100) y = d[4];
        else if (sel == 3'b101) y = d[5];
        else if (sel == 3'b110) y = d[6];
        else                    y = d[7];  // 3'b111
    end
endmodule

module mux4to1 (
    input  wire [3:0] d,
    input  wire [1:0] sel,
    output wire y
);
    assign y = (sel == 2'b00) ? d[0] :
               (sel == 2'b01) ? d[1] :
               (sel == 2'b10) ? d[2] :
                                d[3];
endmodule

module mux32to1 (
    input  wire [31:0] d,    // 32 inputs
    input  wire [4:0]  sel,  // 5-bit select
    output wire y
);
    wire [3:0] y_group;

    // Four 8:1 muxes handle groups of 8
    mux8to1 m0 (.d(d[7:0]),    .sel(sel[2:0]), .y(y_group[0]));
    mux8to1 m1 (.d(d[15:8]),   .sel(sel[2:0]), .y(y_group[1]));
    mux8to1 m2 (.d(d[23:16]),  .sel(sel[2:0]), .y(y_group[2]));
    mux8to1 m3 (.d(d[31:24]),  .sel(sel[2:0]), .y(y_group[3]));

    // Final 4:1 mux chooses among groups
    mux4to1 m4 (.d(y_group), .sel(sel[4:3]), .y(y));
endmodule
