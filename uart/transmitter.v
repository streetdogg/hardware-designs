/* Copyright 2020 pitankar@gmail.com
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

module uart_tx (
    input            clk,
    input [7:0]      data,
    input            start,
    output           in_progress,
    output           tx
);
    parameter LIMIT          = 104;
    parameter IDLE           = 3'b00;
    parameter TRANSMIT       = 3'b01;
    parameter DONE           = 3'b10;

    reg [1:0]  state = IDLE;
    reg [31:0] count = 0;
    reg [3:0]  bit_transmitted = 0;
    reg [8:0]  buffer;

    always @(posedge clk) begin
        case (state)
            IDLE: begin
                if (start == 1'b1) begin
                    tx <= 1'b0;
                    count <= 0;
                    state <= TRANSMIT;
                    in_progress <= 1'b1;
                    buffer <= data[7:0];
                end else begin
                    state <= IDLE;
                    tx <= 1'b1;
                    in_progress <= 1'b0;
                    bit_transmitted <= 0;
                end
            end

            TRANSMIT: begin
                if ( bit_transmitted == 9 ) begin
                    state <= DONE;
                end else if (count == LIMIT) begin
                    count <= 0;
                    tx <= buffer[bit_transmitted];
                    bit_transmitted <= bit_transmitted + 1;
                end else begin
                    tx <= tx;
                    count <= count + 1;
                end
            end

            DONE: begin
                state <= IDLE;
            end

            default: begin
                state <= IDLE;
            end
        endcase
    end
endmodule