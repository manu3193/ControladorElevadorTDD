`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:25:21 08/30/2015 
// Design Name: 
// Module Name:    Temporizador 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Temporizador( _clk_, start_i, restart_i, t_expired_o);

	input _clk_, start_i, restart_i;
	output reg t_expired_o;


	reg[10:0] contador = 4'b0; //registro que almacena Contador
	
	
	always @(posedge _clk_) begin
		if (start_i) begin
			if(restart_i) begin
				t_expired_o<= 1'b0;
				contador <=0;
			end				
			if(contador==7) begin
				t_expired_o<=1'b1;
				contador <=0;
			end
			else begin
				t_expired_o<= 1'b0;
				contador <= contador+1;
			end
		end
	end
endmodule
