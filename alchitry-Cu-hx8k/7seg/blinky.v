/* Copyright 2023 pitankar@gmail.com
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

/*
 * Blink the LED array on the Alchitry IO board and represent the
 * hex starting 24th bit on the 7-segment display array.
 */

`include "display.v"

module top (
  input clk,
  input reset_n,
  output [3:0] ioboard_displaySelector,
  output [7:0] ioboard_display,
  output [23:0] ioboard_leds
);

  localparam NIBBLE         = 4;
  localparam LOWEST_BIT     = 24;
  localparam DIGIT_0        = 0;
  localparam DIGIT_1        = 1;
  localparam DIGIT_2        = 2;
  localparam DIGIT_3        = 3;
  localparam DISPLAY_BUFFER = 4;
  localparam REFRESH_BIT    = 20;

  reg  [47:0] counter;
  reg  [3:0]  display_sel;
  wire [7:0]  display_buff[DISPLAY_BUFFER : DIGIT_0];

  display digit3(.clk(clk),
                 .value(counter[LOWEST_BIT + 4*NIBBLE - 1:LOWEST_BIT + 3*NIBBLE]),
                 .display(display_buff[DIGIT_3]));
  display digit2(.clk(clk),
                 .value(counter[LOWEST_BIT + 3*NIBBLE - 1:LOWEST_BIT + 2*NIBBLE]),
                 .display(display_buff[DIGIT_2]));
  display digit1(.clk(clk),
                 .value(counter[LOWEST_BIT + 2*NIBBLE - 1:LOWEST_BIT + NIBBLE]),
                 .display(display_buff[DIGIT_1]));
  display digit0(.clk(clk),
                 .value(counter[LOWEST_BIT + NIBBLE - 1:LOWEST_BIT]),
                 .display(display_buff[DIGIT_0]));

  /*
   * Increament the counter for every clock tick.
   */
  always @(posedge clk) begin
    if (!reset_n)
      counter <= 0;
    else
      counter <= counter + 1;
  end

  /*
   * Refresh the Displays!
   */
  always @(posedge clk) begin
    case(counter[REFRESH_BIT:REFRESH_BIT-1])
      2'h0: begin
        display_sel <= 4'b1110;
        display_buff[DISPLAY_BUFFER] <= display_buff[DIGIT_0];
      end
      2'h1: begin
        display_sel <= 4'b1101;
        display_buff[DISPLAY_BUFFER] <= display_buff[DIGIT_1];
      end
      2'h2: begin
        display_sel <= 4'b1011;
        display_buff[DISPLAY_BUFFER] <= display_buff[DIGIT_2];
      end
      default: begin
        display_sel <= 4'b0111;
        display_buff[DISPLAY_BUFFER] <= display_buff[DIGIT_3];
      end
    endcase
  end

  /*
   * Wire the buffers out to the module
   */
  assign ioboard_displaySelector =  display_sel;
  assign ioboard_leds = counter[LOWEST_BIT + 4*NIBBLE - 1:LOWEST_BIT];
  assign ioboard_display = display_buff[DISPLAY_BUFFER];
endmodule
