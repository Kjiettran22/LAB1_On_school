`timescale 1ns / 1ps

module tb_button_debounce;

    // 1. Khai báo các tín hiệu kết nối với UUT
    reg  clk;
    reg  reset_n;
    reg  button_in;
    wire button_out;

    // 2. Khởi tạo UUT (Ghi đè DEBOUNCE_LIMIT xuống 5 chu kỳ để mô phỏng nhanh)
    button_debounce #(
        .DEBOUNCE_LIMIT(5) 
    ) uut (
        .clk(clk),
        .reset_n(reset_n),
        .button_in(button_in),
        .button_out(button_out)
    );

    // 3. Tạo xung Clock hệ thống (50MHz -> Chu kỳ 20ns)
    always begin
        #10 clk = ~clk;
    end

    // 4. Ghi file Sóng (Waveform) và Giám sát Màn hình (Monitor)
    initial begin
        // --- CẤU HÌNH XUẤT SÓNG VCD (Dùng cho GTKWave, ModelSim, Vivado...) ---
        $dumpfile("button_debounce_tb.vcd"); // Tên file chứa dữ liệu sóng
        $dumpvars(0, tb_button_debounce);    // Trích xuất tất cả biến trong testbench này

        // --- CẤU HÌNH IN RA MONITOR ---
        // Hàm $monitor sẽ tự động in ra màn hình BẤT CỨ KHI NÀO có sự thay đổi giá trị của các biến truyền vào
        $display("--------------------------------------------------                    ");
        $display(" Thoi-gian | Reset_n | Button_In (Rung) | Button_Out (Sach)           ");
        $display("--------------------------------------------------                    ");
        $monitor("   %5t ns |    %b    |        %b        |         %b", 
                 $time, reset_n, button_in, button_out);
    end

    // 5. Kịch bản mô phỏng sinh công cụ kích thích (Stimulus)
    initial begin
        // Khởi tạo trạng thái ban đầu
        clk = 0;
        reset_n = 0;
        button_in = 1; // Mặc định nút nhả ra là mức 1

        // Hệ thống Reset
        #40;
        reset_n = 1;
        #20;

        // ---- MÔ PHỎNG: NHẤN NÚT (Có nhiễu rung) ----
        #20 button_in = 0; // Chớm nhấn
        #20 button_in = 1; // Rung nảy lên 1
        #20 button_in = 0; // Rung xuống 0
        #20 button_in = 1; // Rung nảy lên 1 lại
        
        // Nút nhấn bắt đầu giữ ổn định ở mức 0 (Nhấn hẳn xuống)
        #20 button_in = 0; 
        
        // Chờ 200ns để mạch đếm đủ 5 chu kỳ clock ổn định và cập nhật đầu ra
        #200;

        // ---- MÔ PHỎNG: NHẢ NÚT (Có nhiễu rung) ----
        #20 button_in = 1; // Chớm nhả tay
        #20 button_in = 0; // Rung sập xuống 0
        #20 button_in = 1; // Rung nảy lên 1
        #20 button_in = 0; // Rung sập xuống 0
        
        // Nút nhấn đã buông tay hoàn toàn, ổn định ở mức 1
        #20 button_in = 1;
        
        // Chờ xem đầu ra cập nhật lại mức 1 sạch sẽ
        #200;

        // Kết thúc mô phỏng
        $display("--------------------------------------------------");
        $display(" Simulation finished successfully!                ");
        $display("--------------------------------------------------");
        $finish;
    end
      
endmodule