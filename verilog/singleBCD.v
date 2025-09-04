module full_adder (
    input  wire a, b, cin,
    output wire sum, cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module adder4bit (
    input  wire [3:0] A, B,
    input  wire Cin,
    output wire [3:0] Sum,
    output wire Cout
);
    wire c1, c2, c3;

    full_adder fa0 (.a(A[0]), .b(B[0]), .cin(Cin), .sum(Sum[0]), .cout(c1));
    full_adder fa1 (.a(A[1]), .b(B[1]), .cin(c1),  .sum(Sum[1]), .cout(c2));
    full_adder fa2 (.a(A[2]), .b(B[2]), .cin(c2),  .sum(Sum[2]), .cout(c3));
    full_adder fa3 (.a(A[3]), .b(B[3]), .cin(c3),  .sum(Sum[3]), .cout(Cout));
endmodule
module bcd_adder (
    input  wire [3:0] A, B,   // BCD inputs (0–9)
    input  wire Cin,          // carry in
    output wire [3:0] Sum,    // BCD sum
    output wire Cout          // carry out
);
    wire [3:0] temp_sum;
    wire c1, c2;
    wire correction_needed;

    // Step 1: Add A + B + Cin
    adder4bit add1 (
        .A(A), .B(B), .Cin(Cin),
        .Sum(temp_sum), .Cout(c1)
    );

    // Step 2: Check if correction is needed
    assign correction_needed = c1 | (temp_sum > 4'b1001);

    // Step 3: Add correction (6 if needed)
    adder4bit add2 (
        .A(temp_sum),
        .B(correction_needed ? 4'b0110 : 4'b0000),
        .Cin(1'b0),
        .Sum(Sum),
        .Cout(c2)
    );

    assign Cout = correction_needed | c2;
endmodule
