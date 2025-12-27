module tx (
    input  wire clk,
    input  wire rst,
    input  wire baud_tick,
    input  wire tx_start,
    input  wire [7:0] tx_data,
    output reg  tx,
    output reg  tx_busy
);

    reg [3:0] bit_cnt;
    reg [9:0] shift_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx <= 1'b1;
            tx_busy <= 0;
            bit_cnt <= 0;
            shift_reg <= 0;
        end else begin
            if (tx_start && !tx_busy) begin
                shift_reg <= {1'b1, tx_data, 1'b0};
                tx_busy <= 1;
                bit_cnt <= 0;
            end
            else if (baud_tick && tx_busy) begin
                tx <= shift_reg[0];
                shift_reg <= shift_reg >> 1;
                bit_cnt <= bit_cnt + 1;

                if (bit_cnt == 9) begin
                    tx_busy <= 0;
                    tx <= 1'b1;
                end
            end
        end
    end

endmodule
