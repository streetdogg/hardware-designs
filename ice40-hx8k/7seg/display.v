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
 * Given a nibble, represent as a hex digit.
 */

module display (
  input clk,
  input [3:0] value,
  output [7:0] display
);

  reg [7:0] display_buff;

  always @(posedge clk) begin
    case (value)
      4'h0: display_buff <= 8'hC0;
      4'h1: display_buff <= 8'hF9;
      4'h2: display_buff <= 8'hA4;
      4'h3: display_buff <= 8'hB0;
      4'h4: display_buff <= 8'h99;
      4'h5: display_buff <= 8'h92;
      4'h6: display_buff <= 8'h82;
      4'h7: display_buff <= 8'hF8;
      4'h8: display_buff <= 8'h80;
      4'h9: display_buff <= 8'h90;
      4'ha: display_buff <= 8'h88;
      4'hb: display_buff <= 8'h83;
      4'hc: display_buff <= 8'hc6;
      4'hd: display_buff <= 8'ha1;
      4'he: display_buff <= 8'h86;
      4'hf: display_buff <= 8'h8e;
      default: display_buff <= display_buff;
    endcase
  end

  assign display = display_buff;
endmodule










