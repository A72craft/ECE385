//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input  logic [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
                       output logic [3:0]  Red, Green, Blue );
    
    logic ball_on;
    logic wall_on;
    logic [7:0]sprite_addr;
//    logic [7:0]oghost_addr;
//    logic [7:0]bghost_addr;
//    logic [7:0]rghost_addr;
//    logic [7:0]pghost_addr;
     
     logic [0:31]sprite_data;
//     logic [31:0]oghost_data;
//     logic [31:0]bghost_data;
//     logic [31:0]rghost_data;
//     logic [31:0]pghost_data;
    
     logic [9:0]wall_addr;
     logic [415:0]wall_data;
     
//     logic [2:0] dot_addr;
//     logic [1:0] dot_data;
     
     
     logic [9:0] xp2, yp2;
     assign xp2 = DrawX + 2 - 32;
     assign yp2 = DrawY + 2 - 32;
     
     
     logic [9:0] tmp1;
     //assign tmp1 = (DrawY - BallY + Ball_size + 96 + 32 * Direction);
    
    spriteData spritePac(.addr(sprite_addr), .data(sprite_data));
    wallData wallMap (.addr(wall_addr), .data(wall_data));
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*BallS, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))
       )

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 120 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
    int DistX, DistY, Size;
    assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
  
    always_comb
    begin:Ball_on_proc
        if ( (DistX*DistX + DistY*DistY) <= (Size * Size) )
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
     end 
       
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1) && sprite_data[DrawX - BallX + Ball_size] == 1'b1)
        begin
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
        end
		  /*else if(dot_on == 1'b1 && dot_data[])//pacdots
		  begin
		  
		  end*/
//		  else if(oghost_on == 1'b1 && oghost_data[DrawX - oghostx + Ball_size] == 1'b1)
//		  begin
//            Red = 8'hff;
//            Green = 8'hb8;
//            Blue = 8'h51;
//        end
        
//		  else if(bghost_on == 1'b1 && bghost_data[DrawX - bghostx + Ball_size] == 1'b1)
//		  begin
//            Red = 8'h01;
//            Green = 8'hff;
//            Blue = 8'hff;
//        end
        
//		  else if(rghost_on == 1'b1 && rghost_data[DrawX - rghostx + Ball_size] == 1'b1)
//		  begin
//            Red = 8'hff;
//            Green = 8'h5f;
//            Blue = 8'h5f;
//        end
        
//		  else if(pghost_on == 1'b1 && pghost_data[DrawX - pghostx + Ball_size] == 1'b1)
//		  begin
//            Red = 8'hff;
//            Green = 8'hb8;
//            Blue = 8'hff;
//        end
        
//		  else if(dot_on == 1'b1 && dot_data[xp2[1:0]] == 1'b1)
//		  begin
//				Red = 8'hff;
//            Green = 8'hff;
//            Blue = 8'h00;
//		  end
		  else if(wall_on == 1'b1 && wall_data[DrawX] == 1'b1)
        begin
				Red = 8'h00;
				Green = 8'h00;
				Blue = 8'hff;
        end
		  else
		  begin
				Red = 8'h00;
				Green = 8'h00;
				Blue = 8'h00;// - DrawX[9:3];
		  end
    end
    
    
    
   if(DrawX < 416 && DrawY <= 400)
			begin
			  if(2'b01 == 2'b01)
			  begin
					wall_addr = DrawY + 220;// + 400*1'b0;
			  end
			  wall_on = 1'b1;
			end
			else
			begin
			  wall_addr = 10'b0000000000;
			  wall_on = 1'b0;
			end
endmodule
