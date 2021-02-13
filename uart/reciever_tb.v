/* Copyright 2021 pitankar@gmail.com
 * 
 * Permission is hereby granted, free of charge, 
 * to any person obtaining a copy of this software
 * and associated documentation files (the "Software"),
 * to deal in the Software without restriction,
 * including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit
 * persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * 
 * The above copyright notice and this permission
 * notice shall be included in all copies or
 * substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY
 * OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
 * LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
 * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
 * OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 **/

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