module button_debounce (
    input  wire clk,         // Xung clock hệ thống (ví dụ: 50MHz)
    input  wire reset_n,     // Reset tích cực mức thấp
    input  wire button_in,   // Tín hiệu nút nhấn vào (bị rung)
    output reg  button_out   // Tín hiệu nút nhấn ra (đã làm sạch)
);

    // Giả sử clk = 50MHz (chu kỳ 20ns)
    // Để trễ 10ms, ta cần đếm: 10ms / 20ns = 500,000 chu kỳ.
    // 500,000 cần một bộ đếm 19-bit (2^19 = 524,288).
    parameter DEBOUNCE_LIMIT = 500000;

    reg [18:0] counter;
    reg        btn_sync_0;
    reg        btn_sync_1;

    // 1. Đồng bộ hóa tín hiệu đầu vào để tránh hiện tượng bất ổn định (Metastability)
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            btn_sync_0 <= 1'b1; // Giả sử nút nhấn tích cực mức thấp (mặc định bằng 1)
            btn_sync_1 <= 1'b1;
        end else begin
            btn_sync_0 <= button_in;
            btn_sync_1 <= btn_sync_0;
        end
    end

    // 2. Bộ đếm chống rung
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            counter    <= 0;
            button_out <= 1'b1; // Mặc định ban đầu
        end else begin
            // Nếu trạng thái hiện tại khác với trạng thái đầu ra đã ổn định
            if (btn_sync_1 != button_out) begin
                counter <= counter + 1'b1;
                
                // Nếu bộ đếm đạt giới hạn (nút nhấn đã ổn định đủ lâu)
                if (counter >= DEBOUNCE_LIMIT) begin
                    button_out <= btn_sync_1;
                    counter    <= 0;
                end
            end else begin
                // Nếu trạng thái nút nhấn quay về giống button_out, reset bộ đếm
                counter <= 0;
            end
        end
    end

endmodule