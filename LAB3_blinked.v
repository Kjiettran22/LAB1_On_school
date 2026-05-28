module top_module (
    input wire clk_en,     // Kết nối tới chân Clock 50MHz trên board
    input wire rst_n,   // Nút nhấn Reset trên board
    output reg led      // Chân điều khiển LED
);

    wire clk_1hz_en;    // Dây nối tín hiệu Enable từ bộ chia xung

    clk_divider u_clk_div (
        .clk_in (clk_en),
        .rst_n  (rst_n),
        .clk_en (clk_1hz_en) // Nhận tín hiệu kích hoạt tại đây
    );

    always @(posedge clk_en or negedge rst_n) begin
        if (!rst_n) begin
            led <= 1'b0;
        end else if (clk_1hz_en) begin
            led <= ~led; // Đảo trạng thái LED mỗi khi nhận được xung 1Hz
        end
    end

endmodule