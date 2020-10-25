/*
 * Blinks the Green LED on the Lattice ice40 stick
 */
module top(input clk, output g, output r1, r2, r3, r4);
    reg [23:0]   counter;
    reg [0:0]    ff;

    always @(posedge clk) begin
        if (counter == 2000000) 
            begin
            counter <= 0;
            ff[0] <= ~ff[0];
            end
        else 
            counter <= counter + 1;
    end

    assign g = ff[0];
    assign r1 = 1'b0;
    assign r2 = 1'b0;
    assign r3 = 1'b0;
    assign r4 = 1'b0;
endmodule