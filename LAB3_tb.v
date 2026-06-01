`timescale 1ns / 1ps
module tb_led_toggle();


    reg clk;
    reg rst_n;
    reg sw_n;
    wire led;


    led_toggle uut (
        .clk(clk),
        .rst_n(rst_n),
        .sw_n(sw_n),
        .led(led)
    );


    always #10 clk = ~clk;


    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_led_toggle);
        
        clk = 0;
        rst_n = 1;
        sw_n = 1;


        #100 rst_n = 0; 
        #50  rst_n = 1; 


        #100 sw_n = 0;
        #100 sw_n = 1;


        #100 sw_n = 0;
        #100 sw_n = 1;


        #100 $finish;
    end

