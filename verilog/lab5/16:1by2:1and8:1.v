module mux8to1 (
    input  wire [7:0] d,    // data inputs
    input  wire [2:0] sel,  // select line (3 bits)
    output reg  y
);
    always @(*) begin
        case (sel)
            3'b000: y = d[0];
            3'b001: y = d[1];
            3'b010: y = d[2];
            3'b011: y = d[3];
            3'b100: y = d[4];
            3'b101: y = d[5];
            3'b110: y = d[6];
            3'b111: y = d[7];
            default: y = 1'b0; // safety
        endcase
    end
endmodule

module mux2to1 (
    input  wire d0, d1, // inputs
    input  wire sel,    // select line
    output wire y
);
    assign y = sel ? d1 : d0;
endmodule

module mux16to1 (
    input  wire [15:0] d,   // 16 inputs
    input  wire [3:0]  sel, // 4-bit select
    output wire y
);
    wire y0, y1;

    // Lower 8 inputs (d[7:0])
    mux8to1 m1 (.d(d[7:0]), .sel(sel[2:0]), .y(y0));

    // Upper 8 inputs (d[15:8])
    mux8to1 m2 (.d(d[15:8]), .sel(sel[2:0]), .y(y1));

    // Final 2:1 mux decides between y0 and y1
    mux2to1 m3 (.d0(y0), .d1(y1), .sel(sel[3]), .y(y));
endmodule
