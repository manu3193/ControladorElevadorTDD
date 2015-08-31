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
	output  t_expired_o;


	reg[3:0] contador = 4'b0; //registro que almacena Contador
	localparam contador_max=7; //Se cuentan 7 segundos
	reg t_expired_o=0;
	
	
	always @(posedge _clk_) begin
		t_expired_o<=0;
		if(restart_i) 
			contador <=0;	
		else begin
			if (start_i) begin		
				if(contador==contador_max-1) begin
					t_expired_o<=1'b1;
					contador <=0;
				end
				else begin
					contador <= contador+1;
				end
			end
		end
	end
endmodule
