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