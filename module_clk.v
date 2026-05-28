module clk_divider (
    input wire clk_in,     // Xung clock gốc 50MHz từ board ACG525
    input wire rst_n,      // Reset tích cực mức thấp (Active-low reset)
    output reg clk_en      // Xung kích hoạt đầu ra (Clock Enable output)
);

    // Giá trị đếm để đạt tần số 1 Hz (Sửa số này nếu muốn đổi tần số)
    // Target value to get 1 Hz output (Change this constant for other frequencies)
    parameter TARGET_COUNT = 26'd49_999_999; 

    // Bộ đếm 26-bit đủ để chứa giá trị 50 triệu
    reg [25:0] counter;

    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 26'd0;
            clk_en  <= 1'b0;
        end else begin
            if (counter == TARGET_COUNT) begin
                counter <= 26'd0;
                clk_en  <= 1'b1;  // Kích hoạt xung Enable trong 1 chu kỳ clk_in
            end else begin
                counter <= counter + 1'b1;
                clk_en  <= 1'b0;  // Giữ mức thấp ở các chu kỳ còn lại
            end
        end
    end

endmodule