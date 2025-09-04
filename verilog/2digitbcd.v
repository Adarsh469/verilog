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
    input  wire [3:0] A, B,
    input  wire Cin,
    output wire [3:0] Sum,
    output wire Cout
);
    wire [3:0] temp_sum;
    wire c1, c2;
    wire correction_needed;

    adder4bit add1 (.A(A), .B(B), .Cin(Cin), .Sum(temp_sum), .Cout(c1));

    assign correction_needed = c1 | (temp_sum > 4'b1001);

    adder4bit add2 (
        .A(temp_sum),
        .B(correction_needed ? 4'b0110 : 4'b0000),
        .Cin(1'b0),
        .Sum(Sum),
        .Cout(c2)
    );

    assign Cout = correction_needed | c2;
endmodule

module bcd_adder_2digit (
    input  wire [3:0] A1, A0,   // Tens and Ones digit of A
    input  wire [3:0] B1, B0,   // Tens and Ones digit of B
    output wire [3:0] S1, S0,   // Tens and Ones digit of Sum
    output wire Cout            // Carry out (for >99)
);
    wire c1;  // carry from ones digit

    // Add ones place
    bcd_adder ones (
        .A(A0), .B(B0), .Cin(1'b0),
        .Sum(S0), .Cout(c1)
    );

    // Add tens place with carry from ones
    bcd_adder tens (
        .A(A1), .B(B1), .Cin(c1),
        .Sum(S1), .Cout(Cout)
    );
endmodule
