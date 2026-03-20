module traffic_light_fsm (
    input  logic       clk,
    input  logic       reset,
    input  logic       TAORB,
    output logic [2:0] LA, // 3-bit: {Kırmızı, Sarı, Yeşil}
    output logic [2:0] LB  // 3-bit: {Kırmızı, Sarı, Yeşil}
);

    // Işık renkleri için parametreler
    localparam RED    = 3'b100;
    localparam YELLOW = 3'b010;
    localparam GREEN  = 3'b001;

    // FSM durumları
    typedef enum logic [1:0] {S0, S1, S2, S3} statetype;
    statetype state, nextstate;

    // Sayaç
    logic [2:0] timer;

    // 1. Sayaç mantığı
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            timer <= '0;
        end else begin
            // Sadece S1 ve S3 durumlarında sayacı artır, çıkıldığında sıfırla
            if ((state == S1 && timer < 5) || (state == S3 && timer < 5)) begin
                timer <= timer + 1;
            end else if (state != S1 && state != S3) begin
                timer <= '0;
            end
        end
    end

    // 2. State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= nextstate;
    end

    // 3. Next-state ve output mantığı
    always_comb begin
        nextstate = state;
        LA = RED;
        LB = RED;

        case (state)
            S0: begin
                LA = GREEN;
                LB = RED;
                if (~TAORB) nextstate = S1;
                else        nextstate = S0;
            end

            S1: begin
                LA = YELLOW;
                LB = RED;
                if (~TAORB && timer == 4) nextstate = S2;
                else                      nextstate = S1;
            end

            S2: begin
                LA = RED;
                LB = GREEN;
                if (TAORB) nextstate = S3;
                else       nextstate = S2;
            end

            S3: begin
                LA = RED;
                LB = YELLOW;
                if (TAORB && timer == 4) nextstate = S0;
                else                     nextstate = S3;
            end

            default: nextstate = S0;
        endcase
    end

endmodule