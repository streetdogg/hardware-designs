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