`include "tx.sv"
`include "rx.sv"
module channel (
    input  wire clk,
    input  wire rst,
    input  wire baud_tick,

    input  wire rx,
    input  wire tx_start,
    input  wire [7:0] tx_data,

    output wire tx,
    output wire [7:0] rx_data,
    output wire rx_done,
    output wire tx_busy
);

    tx tx_inst (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    rx rx_inst (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick),
        .rx(rx),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

endmodule
