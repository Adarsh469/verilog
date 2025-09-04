module fulladd (
    input a,b,cin,
    output s,cout
);
    assign s = a^b^cin;
    assign cout = (a&b)|(a&cin)|(b&cin);
endmodule 

module halfadd (
    input a,b,
    output s,cout
);
    assign s = a^b;
    assign cout = a&b;
endmodule 