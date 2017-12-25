// test bench for reciever
`timescale 1us/1us

module reciever_tb;
    reg clk;
    wire [7:0] data;
    reg  [7:0] stored_data;
    wire flag;
    reg clear;
    reg rx;

    uart_rx reciever(clk, rx, clear, data, flag);

    initial begin
        $dumpfile("reciever_tb.vcd");
        $dumpvars(0,reciever_tb);
        rx = 1'b1;
        clk = 1'b0;
        clear = 1'b1;
        #100 clear = 1'b0;
        rx = 1'b0;
        #1248 rx = 1'b1;
        #1248 rx = 1'b0;
        #1248 rx = 1'b1;
        #1248 rx = 1'b0;
        #1248 rx = 1'b1;
        #1248 rx = 1'b0;
        #1248 rx = 1'b1;
        #1248 rx = 1'b0;
        #1248 rx = 1'b1;
        #1248 rx = 1'b1;
        #1248 clear = 1'b1;
        #100  clear = 1'b0;
        #100  rx = 1'b0;
        #1248 rx = 1'b1;
        #1248 rx = 1'b0;
        #1248 rx = 1'b1;
        #1248 rx = 1'b0;
        #1248 rx = 1'b1;
        #1248 rx = 1'b0;
        #1248 rx = 1'b1;
        #1248 rx = 1'b0;
        #1248 rx = 1'b1;
        #1248 rx = 1'b1;
        #2496 $finish;
    end

    always begin
        #6 clk = ~clk;
        stored_data <= data;
    end
endmodule