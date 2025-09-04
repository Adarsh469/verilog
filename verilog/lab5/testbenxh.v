`timescale 1ns/1ps
module tb_mux4to1;

    reg  [3:0] d;
    reg  [1:0] sel;
    wire y;

    mux4to1 uut (.d(d), .sel(sel), .y(y));

    initial begin
        $dumpfile("mux4to1.vcd");
        $dumpvars(0, tb_mux4to1);

        $display("Time | d sel | y");
        $display("-----------------");

        d = 4'b1010; // inputs = {d3,d2,d1,d0} = 1,0,1,0

        sel=2'b00; #10; $display("%4t | %b %b | %b",$time,d,sel,y);
        sel=2'b01; #10; $display("%4t | %b %b | %b",$time,d,sel,y);
        sel=2'b10; #10; $display("%4t | %b %b | %b",$time,d,sel,y);
        sel=2'b11; #10; $display("%4t | %b %b | %b",$time,d,sel,y);

        $finish;
    end
endmodule
