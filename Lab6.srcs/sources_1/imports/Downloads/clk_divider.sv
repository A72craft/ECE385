module clk_divider (
    input clk_25MHz,    
    output reg frame_clk 
);

// 25MHz / 416667 = 60Hz
parameter DIVIDER = 416667; 
reg [21:0] counter = 0; 

always @(posedge clk_25MHz) begin
    if(counter == DIVIDER - 1) begin
        frame_clk <= ~frame_clk;  // 切换时钟状态
        counter <= 0;              // 重置计数器
    end else begin
        counter <= counter + 1;   // 增加计数器
    end
end

endmodule
