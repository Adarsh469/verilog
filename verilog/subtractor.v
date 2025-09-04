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

module adder_subtractor4bit (
    input  wire [3:0] A, B,
    input  wire mode,           
    output wire [3:0] Result,
    output wire Cout
);
    wire [3:0] B_mod;

    assign B_mod = B ^ {4{mode}};

    adder4bit U1 (
        .A(A),
        .B(B_mod),
        .Cin(mode),
        .Sum(Result),
        .Cout(Cout)
    );
endmodule
