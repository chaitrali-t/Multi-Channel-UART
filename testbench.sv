module testbench;
    logic clk;
    logic rst;
    logic rx_ch0;
    logic rx_ch1;
    logic tx_start_ch0;
    logic tx_start_ch1;
    logic [7:0] tx_data_ch0;
    logic [7:0] tx_data_ch1;
    logic tx_ch0;
    logic tx_ch1;
    logic [7:0] rx_data_ch0;
    logic [7:0] rx_data_ch1;
    logic rx_done_ch0;
    logic rx_done_ch1;

    multi_uart_top dut (
        .clk(clk),
        .rst(rst),

        .rx_ch0(rx_ch0),
        .rx_ch1(rx_ch1),

        .tx_start_ch0(tx_start_ch0),
        .tx_start_ch1(tx_start_ch1),

        .tx_data_ch0(tx_data_ch0),
        .tx_data_ch1(tx_data_ch1),

        .tx_ch0(tx_ch0),
        .tx_ch1(tx_ch1),

        .rx_data_ch0(rx_data_ch0),
        .rx_data_ch1(rx_data_ch1),

        .rx_done_ch0(rx_done_ch0),
        .rx_done_ch1(rx_done_ch1)
    );
  
    always #10 clk = ~clk;
    initial begin
      	$dumpfile("dump.vcd"); 
      	$dumpvars;
        clk = 0;
        rst = 1;
        tx_start_ch0 = 0;
        tx_start_ch1 = 0;
       	rx_ch0 = 1;
      	rx_ch1 = 1;
      	tx_data_ch0=8'b00;
      	tx_data_ch1 = 8'b00;
      
        #100 rst = 0;

        #200 tx_start_ch0 = 1;
        #20  tx_start_ch0 = 0; 
      	tx_data_ch0 = 8'b1100_0011;
        

        #500 tx_start_ch1 = 1;
        #20    tx_start_ch1 = 0;
      	tx_data_ch1 = 8'b1010_1010;
        #200 $stop;
    end

endmodule
