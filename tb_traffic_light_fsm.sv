`timescale 1ns / 1ps

module tb_traffic_light_fsm();

    // Testbench sinyalleri
    logic clk;
    logic reset;
    logic TAORB;
    logic [2:0] LA;
    logic [2:0] LB;

    // Test edilecek modülün çağrılması
    traffic_light_fsm uut (
        .clk(clk),
        .reset(reset),
        .TAORB(TAORB),
        .LA(LA),
        .LB(LB)
    );

    // Saat sinyali üretimi - 10 ns periyot
    always #5 clk = ~clk;

    // Simülasyon senaryosu
    initial begin
        // Başlangıç değerleri
        clk = 0;
        reset = 1;
        TAORB = 1; // Başlangıçta A yolunda trafik var, S0'da kalır

        // 20 ns bekle ve reset'i kaldır
        #20;
        reset = 0;
        $display("Zaman=%0t: Reset kaldirildi. Beklenen Durum: S0 (LA=Yesil, LB=Kirmizi)", $time);

        // S0 durumunda biraz bekle
        #30;

        // S0 -> S1 geçişini tetikle
        $display("Zaman=%0t: TAORB = 0 yapildi. S1'e (Sari isik) gecis bekleniyor.", $time);
        TAORB = 0;

        // S1 durumu: 5 clock cycle sürecek
        #70;

        // S1 -> S2 geçişi tamamlandı
        $display("Zaman=%0t: 5 sayim bitti. Beklenen Durum: S2 (LA=Kirmizi, LB=Yesil)", $time);
        #30;

        // S2 -> S3 geçişini tetikle
        $display("Zaman=%0t: TAORB = 1 yapildi. S3'e (Sari isik) gecis bekleniyor.", $time);
        TAORB = 1;

        // S3 durumu: 5 clock cycle sürecek
        #70;

        // S3 -> S0 geçişi tamamlandı
        $display("Zaman=%0t: 5 sayim bitti. Basa donuldu. Beklenen Durum: S0", $time);
        #30;

        // Simülasyonu bitir
        $display("Zaman=%0t: Simulasyon tamamlandi.", $time);
        $finish;
    end

    // Konsol çıktısı
    initial begin
        $monitor("Zaman=%0t | reset=%b | TAORB=%b | LA=%b | LB=%b",
                 $time, reset, TAORB, LA, LB);
    end

endmodule