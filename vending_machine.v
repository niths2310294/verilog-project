`timescale 1ns/1ps
module vending_machine(
    input clk,
    input reset,
    input coin_5,    // Button for 5 rupee coin
    input coin_10,   // Button for 10 rupee coin
    input select_1,  // Button for Product 1 (cost 15)
    input select_2,  // Button for Product 2 (cost 25)
    output reg dispense_1,
    output reg dispense_2,
    output reg change_5,   // LED for 5 rupee change
    output reg change_10   // LED for 10 rupee change
);

    reg [7:0] total;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            total <= 0;
            dispense_1 <= 0;
            dispense_2 <= 0;
            change_5 <= 0;
            change_10 <= 0;
        end else begin
            dispense_1 <= 0;
            dispense_2 <= 0;
            change_5 <= 0;
            change_10 <= 0;

            // Add coins
            if (coin_5)  total <= total + 5;
            if (coin_10) total <= total + 10;

            // Product 1 costs 15
            if (select_1 && total >= 15) begin
                dispense_1 <= 1;
                if (total > 15) begin
                    if (total - 15 >= 10) change_10 <= 1;
                    else if (total - 15 >= 5) change_5 <= 1;
                end
                total <= 0;
            end

            // Product 2 costs 25
            if (select_2 && total >= 25) begin
                dispense_2 <= 1;
                if (total > 25) begin
                    if (total - 25 >= 10) change_10 <= 1;
                    else if (total - 25 >= 5) change_5 <= 1;
                end
                total <= 0;
            end
        end
    end

endmodule
