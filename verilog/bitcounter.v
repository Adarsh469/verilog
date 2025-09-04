module bit_counter_6 (
    input  wire [5:0] X,
    output reg  [2:0] Count
);
    integer i;
    always @(*) begin
        Count = 0;
        for (i=0; i<6; i=i+1) begin
            Count = Count + X[i];
        end
    end
endmodule
