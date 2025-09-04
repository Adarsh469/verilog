module comp2bit (
    input  wire [1:0] a, b,
    output reg lt, gt, eq
);
    always @(*) begin
        if (a < b) begin
            lt = 1; gt = 0; eq = 0;
        end
        else if (a > b) begin
            lt = 0; gt = 1; eq = 0;
        end
        else begin
            lt = 0; gt = 0; eq = 1;
        end
    end
endmodule

module comp4bit (
    input  wire [3:0] a, b,
    output wire lt, gt, eq
);
    wire lt_high, gt_high, eq_high;
    wire lt_low,  gt_low,  eq_low;

    // Compare high bits (a[3:2] vs b[3:2])
    comp2bit high (.a(a[3:2]), .b(b[3:2]), .lt(lt_high), .gt(gt_high), .eq(eq_high));

    // Compare low bits (a[1:0] vs b[1:0])
    comp2bit low  (.a(a[1:0]), .b(b[1:0]), .lt(lt_low),  .gt(gt_low),  .eq(eq_low));

    // Final decision logic
    assign lt = lt_high | (eq_high & lt_low);
    assign gt = gt_high | (eq_high & gt_low);
    assign eq = eq_high & eq_low;
endmodule
