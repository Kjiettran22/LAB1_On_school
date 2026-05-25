`timescale 1ns / 1ps
module LAB2_LED_logic_tb;

    reg [1:0] sw;
    wire LED;

    // Instantiate the Unit Under Test (UUT)
    LAB2_LED_logic uut (
        .sw(sw),
        .LED(LED)
    );

    initial begin
        $dumpfile("LAB2_LED_logic_tb.vcd");
        $dumpvars(0, LAB2_LED_logic_tb);
        // Initialize inputs
        sw = 2'b00; #10;
        sw = 2'b01; #10;
        sw = 2'b10; #10;
        sw = 2'b11; #10;

        // Finish simulation
        $finish;
    end