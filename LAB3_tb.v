`timescale 1ns / 1ps

module tb_top_module;

    // Inputs (declared as reg)
    reg clk_en;
    reg rst_n;
    
    // Outputs (declared as wire)
    wire led;

    top_module uut (
        .clk_en (clk_en),
        .rst_n  (rst_n),
        .led    (led)
    );

    defparam uut.u_clk_div.TARGET_COUNT = 26'd4;

    // Generate 50MHz Clock (Period = 20ns, toggles every 10ns)
    always begin
        #10 clk_en = ~clk_en;
    end

    // Stimulus process
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_top_module);

        // Monitor signals in the console window
        $display("-----------------------------------------------------------------------");
        $display("  Time (ns) | Reset (rst_n) | Counter | Enable Pulse | LED State");
        $display("-----------------------------------------------------------------------");
        
        // Initialize signals
        clk_en = 1'b0;
        rst_n  = 1'b0; 
        
        #35;           
        rst_n  = 1'b1; 
        
        #300;          
        
        $display("-----------------------------------------------------------------------");
        $finish;      
    end

    // Print values at every change of interest
    always @(posedge clk_en or negedge rst_n or uut.u_clk_div.clk_en or led) begin
        $display("%t ns |       %b       |   %2d    |       %b      |     %b", 
                 $time, rst_n, uut.u_clk_div.counter, uut.u_clk_div.clk_en, led);
    end

endmodule