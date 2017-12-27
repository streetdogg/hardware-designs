// test bench for transmitter
`timescale 1us/1us

module transmitter_tb;
    reg clk;
    reg [7:0] data;
    wire in_progress;
    reg start;
    wire tx;

    uart_tx transmitter(clk, data, start, in_progress, tx);

    initial begin
        $dumpfile("transmitter_tb.vcd");
        $dumpvars(0,transmitter_tb);

        clk = 1'b0;
        data = 8'b01010101;
        start = 1'b1;
        #20 start = 1'b0;

        #12480 data = 8'b01010101;
        #1248 start = 1'b1;
        #20 start = 1'b0;
        #12480 $finish;
    end

    always begin
        #6 clk = ~clk;
    end
endmodule