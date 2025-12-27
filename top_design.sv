`include "baud_gen.sv"
`include "channel.sv"
module multi_uart_top (
    input  wire clk,
    input  wire rst,

    input  wire rx_ch0,
    input  wire rx_ch1,

    input  wire tx_start_ch0,
    input  wire tx_start_ch1,

    input  wire [7:0] tx_data_ch0,
    input  wire [7:0] tx_data_ch1,

    output wire tx_ch0,
    output wire tx_ch1,

    output wire [7:0] rx_data_ch0,
    output wire [7:0] rx_data_ch1,

    output wire rx_done_ch0,
    output wire rx_done_ch1
);

    wire baud_tick;
    wire tx_busy_ch0;
    wire tx_busy_ch1;

    baud_gen bg (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick)
    );

    channel ch0 (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick),
        .rx(rx_ch0),
        .tx_start(tx_start_ch0),
        .tx_data(tx_data_ch0),
        .tx(tx_ch0),
        .rx_data(rx_data_ch0),
        .rx_done(rx_done_ch0),
        .tx_busy(tx_busy_ch0)
    );

    channel ch1 (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick),
        .rx(rx_ch1),
        .tx_start(tx_start_ch1),
        .tx_data(tx_data_ch1),
        .tx(tx_ch1),
        .rx_data(rx_data_ch1),
        .rx_done(rx_done_ch1),
        .tx_busy(tx_busy_ch1)
    );

endmodule
