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

module uart_rx (
    input            clk,
    input            rx,
    input            clear,
    output reg [7:0] data,
    output           done
);
    parameter LIMIT          = 104;
    parameter SAMPLE         = LIMIT/2;
    parameter IDLE           = 3'b00;
    parameter RECIEVE        = 3'b01;
    parameter DONE           = 3'b10;

    reg [1:0]  state = IDLE;
    reg [31:0] count = 0;
    reg [1:0]  stop_bits = 0;
    reg [2:0]  bit_recieved = 0;
    reg        op_complete = 0;

    always @(posedge clk) begin
        if (count == LIMIT) begin
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end

    always @(posedge clk) begin
        if (clear == 1'b1) begin
            done <= 1'b0;
        end else if (op_complete == 1'b1) begin
            done <= op_complete;
        end else begin
            done <= done;
        end
    end

    always @(posedge clk) begin
        case (state)
            IDLE: begin
                if (rx == 1'b0 && count == SAMPLE && done == 1'b0) begin
                    state <= RECIEVE;
                    data <= 0;
                end else begin
                    state <= IDLE;
                    bit_recieved <= 0;
                    stop_bits <= 0;
                    op_complete <= 1'b0;
                end
            end

            RECIEVE: begin
                if (bit_recieved < 8 && count == SAMPLE) begin
                    data[bit_recieved] <= rx;
                    bit_recieved <= bit_recieved + 1;
                end else if (bit_recieved == 7) begin
                    state <= DONE;
                end else begin
                    state <= RECIEVE;
                end
            end

            DONE: begin
                if (stop_bits < 3 && count == SAMPLE) begin
                    stop_bits <= stop_bits + 1;
                end else if (stop_bits == 3) begin
                    state <= IDLE;
                    op_complete <= 1'b1;
                end else begin
                    state <= DONE;
                end
            end

            default: begin
                state <= IDLE;
            end
        endcase
    end
endmodule