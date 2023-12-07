`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/06 11:46:22
// Design Name: 
// Module Name: walls
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module walls(
    output [155:0] horiz_walls, vert_walls
);

// 定义固定的垂直和水平墙体布局
assign vert_walls = {
    13'h1fff,
    13'h1fff,
    13'h1fff,
    13'h1fff,
    13'h1fff,
    13'h1fbf,
    13'h1fbf,
    13'h1fff,
    13'h1fff,
    13'h1fff,
    13'h1fff,
    13'h1fff
};

assign horiz_walls = {
    {12{1'b1}},
    {12{1'b1}},
    {12{1'b1}},
    {12{1'b1}},
    {12{1'b1}},
    {12{1'b1}},
    12'hf9f,
    {12{1'b1}},
    {12{1'b1}},
    {12{1'b1}},
    {12{1'b1}},
    {12{1'b1}},
    {12{1'b1}}
};

endmodule


