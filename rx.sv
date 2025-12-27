module rx (
    input  wire clk,
    input  wire rst,
    input  wire baud_tick,
    input  wire rx,
    output reg  [7:0] rx_data,
    output reg  rx_done
);

    reg [3:0] bit_cnt;
    reg [7:0] rx_shift;
    reg receiving;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bit_cnt <= 0;
            rx_shift <= 0;
            receiving <= 0;
            rx_done <= 0;
        end else begin
            rx_done <= 0;

            if (!receiving && rx == 0) begin
                receiving <= 1;
                bit_cnt <= 0;
            end
            else if (receiving && baud_tick) begin
                bit_cnt <= bit_cnt + 1;

                if (bit_cnt >= 1 && bit_cnt <= 8) begin
                    rx_shift <= {rx, rx_shift[7:1]};
                end

                if (bit_cnt == 9) begin
                    receiving <= 0;
                    rx_data <= rx_shift;
                    rx_done <= 1;
                end
            end
        end
    end

endmodule
