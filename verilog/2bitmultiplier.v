module half_adder (
    input  wire a, b,
    output wire sum, carry
);
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule
module multiplier2bit (
    input  wire [1:0] A, B,
    output wire [3:0] P
);
    wire pp0, pp1, pp2, pp3;   // partial products
    wire s1, c1;               // first half adder
    wire s2, c2;               // second half adder

    // Partial products
    assign pp0 = A[0] & B[0];  // LSB
    assign pp1 = A[1] & B[0];
    assign pp2 = A[0] & B[1];
    assign pp3 = A[1] & B[1];  // MSB

    // First addition (pp1 + pp2)
    half_adder HA1 (
        .a(pp1), .b(pp2),
        .sum(s1), .carry(c1)
    );

    // Second addition (pp3 + carry from HA1)
    half_adder HA2 (
        .a(pp3), .b(c1),
        .sum(s2), .carry(c2)
    );

    // Final product
    assign P[0] = pp0;  // LSB
    assign P[1] = s1;
    assign P[2] = s2;
    assign P[3] = c2;   // MSB

endmodule
