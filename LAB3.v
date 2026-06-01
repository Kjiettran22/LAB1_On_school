module led_toggle (
    input clk,
    input rst_n,
    input sw_n,
    output reg led = 1'b1
);


    reg sw_d1, sw_d2;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sw_d1 <= 1'b1;
            sw_d2 <= 1'b1;
        end else begin
            sw_d1 <= sw_n;
            sw_d2 <= sw_d1;
        end
    end
    
    wire sw_released = sw_d1 & ~sw_d2;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            led <= 1'b1;
        end else if (sw_released) begin
            led <= ~led;
        end
    end


endmodule

