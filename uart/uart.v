/*
    UART loopback, take whats coming on the Rx and put it back on Tx
 */

 `include "transmitter.v"
 `include "reciever.v"

module top(
    input clk,
    input rx,
    output tx,
    output flag,
    output in_progress
);
    reg [7:0] buffer;

    uart_rx reciever(clk, rx, in_progress, buffer, flag);
    uart_tx transmitter(clk, buffer, flag, in_progress, tx);
endmodule