`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////// 
////                                                              ////
////                                                              //// 
////  Sincronizador                                               //// 
////                                                              ////
////                                                              //// 
////  Este archivo describe el comportamiento                     //// 
////  de un temporizador en Verilog                               //// 
////                                                              //// 
////  Description                                                 //// 
////  Este módulo es un temporizador que cuenta 7 segundos para   ////
////  enviar una señal a la maquina de estados y cerrar la puerta ////  
////  del ascensor. Tiene 3 entradas: _clk_ el reloj de 1Hz,      ////  
////  start_i que habilita la cuenta y restart_i que se encarga de////  
////  reiniciar la cuenta. La salida es una señal t_expired que se////  
////  habilita en un ciclo de reloj cuando la cuenta llega a 7.   ////    
////                                                              //// 
////                                                              //// 
////                                                              //// 
////                                                              //// 
////  Autor    :                                                  //// 
////      - Manuel Zumbado Corrales manu3193@gmail.com            //// 
////      - Arturo Salas Delgado    artsaldel@gmail.com           ////  
////                                                              //// 
////////////////////////////////////////////////////////////////////// 
////                                                              //// 
//// Copyright (C) 2009 Authors and OPENCORES.ORG                 //// 
////                                                              //// 
//// This source file may be used and distributed without         //// 
//// restriction provided that this copyright statement is not    //// 
//// removed from the file and that any derivative work contains  //// 
//// the original copyright notice and the associated disclaimer. //// 
////                                                              //// 
//// This source file is free software; you can redistribute it   //// 
//// and/or modify it under the terms of the GNU Lesser General   //// 
//// Public License as published by the Free Software Foundation; //// 
//// either version 2.1 of the License, or (at your option) any   //// 
//// later version.                                               //// 
////                                                              //// 
//// This source is distributed in the hope that it will be       //// 
//// useful, but WITHOUT ANY WARRANTY; without even the implied   //// 
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      //// 
//// PURPOSE.  See the GNU Lesser General Public License for more //// 
//// details.                                                     //// 
////                                                              //// 
//// You should have received a copy of the GNU Lesser General    //// 
//// Public License along with this source; if not, download it   //// 
/// from http://www.opencores.org/lgpl.shtml                     //// 
////                                                              //// 
//////////////////////////////////////////////////////////////////////

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
