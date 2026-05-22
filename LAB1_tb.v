`timescale 1ns / 1ps

module LAB1_tb;

    // 1. Declare inputs as registers (reg) and outputs as wires
    // 1. Khai báo đầu vào là thanh ghi (reg) và đầu ra là dây (wire)
    reg A;
    reg B;
    reg C;
    
    wire LED1;
    wire LED2;
    wire LED3;

    // 2. Instantiate the Unit Under Test (UUT)
    // 2. Gọi khối mạch cần kiểm tra (UUT)
    LAB1 uut (
        .A(A), 
        .B(B), 
        .C(C), 
        .LED1(LED1), 
        .LED2(LED2), 
        .LED3(LED3)
    );

    // 3. Stimulus process & Waveform Generation
    // 3. Quá trình tạo tín hiệu & Xuất file sóng
    initial begin
        // System tasks to generate VCD (Value Change Dump) file for waveforms
        // Các lệnh hệ thống để tạo file VCD xem dạng sóng
        $dumpfile("LAB1_waveform.vcd"); // Name of the waveform file / Tên file dạng sóng
        $dumpvars(0, LAB1_tb);          // Dump all variables in this testbench / Ghi nhận tất cả biến

        // Test vectors / Các tổ hợp kiểm tra
        A = 0; B = 0; C = 0; #10;
        A = 0; B = 0; C = 1; #10;
        A = 0; B = 1; C = 0; #10;
        A = 0; B = 1; C = 1; #10;
        A = 1; B = 0; C = 0; #10;
        A = 1; B = 0; C = 1; #10;
        A = 1; B = 1; C = 0; #10;
        A = 1; B = 1; C = 1; #10;
        
        // Terminate simulation / Kết thúc mô phỏng
        $finish;
    end
      
endmodule