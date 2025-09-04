module tb;
    reg a, b, cin;        // inputs
    wire s_f, cout_f;     // full adder outputs
    wire s_h, cout_h;     // half adder outputs

    // Instantiate Full Adder
    fulladd FA (
        .a(a), .b(b), .cin(cin),
        .s(s_f), .cout(cout_f)
    );

    // Instantiate Half Adder
    halfadd HA (
        .a(a), .b(b),
        .s(s_h), .cout(cout_h)
    );

    initial begin
        $dumpfile("adders.vcd");   // for GTKWave
        $dumpvars(0, tb);

        $display("a b cin | Hs Hc | Fs Fc");
        $display("------------------------");

        // Test all input combinations manually
        a=0; b=0; cin=0; #5 $display("%b %b  %b  |  %b  %b |  %b  %b", a,b,cin,s_h,cout_h,s_f,cout_f);
        a=0; b=0; cin=1; #5 $display("%b %b  %b  |  %b  %b |  %b  %b", a,b,cin,s_h,cout_h,s_f,cout_f);
        a=0; b=1; cin=0; #5 $display("%b %b  %b  |  %b  %b |  %b  %b", a,b,cin,s_h,cout_h,s_f,cout_f);
        a=0; b=1; cin=1; #5 $display("%b %b  %b  |  %b  %b |  %b  %b", a,b,cin,s_h,cout_h,s_f,cout_f);
        a=1; b=0; cin=0; #5 $display("%b %b  %b  |  %b  %b |  %b  %b", a,b,cin,s_h,cout_h,s_f,cout_f);
        a=1; b=0; cin=1; #5 $display("%b %b  %b  |  %b  %b |  %b  %b", a,b,cin,s_h,cout_h,s_f,cout_f);
        a=1; b=1; cin=0; #5 $display("%b %b  %b  |  %b  %b |  %b  %b", a,b,cin,s_h,cout_h,s_f,cout_f);
        a=1; b=1; cin=1; #5 $display("%b %b  %b  |  %b  %b |  %b  %b", a,b,cin,s_h,cout_h,s_f,cout_f);

        $finish;
    end
endmodule
