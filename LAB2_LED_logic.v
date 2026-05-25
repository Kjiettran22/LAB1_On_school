module LAB2_LED_logic(
    input wire [1:0] sw,
    output reg LED
);

    always @(*) begin
        LED = sw[0] & sw[1];
    end

endmodule