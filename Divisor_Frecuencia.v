`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////// 
////                                                              ////
////                                                              //// 
////  Divisor de frecuencia                                       //// 
////                                                              ////
////                                                              //// 
////  Este archivo describe el comportamiento                     //// 
////  de un divisor de frecuencia  en Verilog                     //// 
////                                                              //// 
////  Description                                                 //// 
////  Este módulo se encarga de generar un clk de 1Hz. Recibe el  ////
////  reloj del sistema (100MHz) y lo divide para generar un      ////
////  de 1Hz.                                                     ////      
////                                                              //// 
////                                                              //// 
////                                                              //// 
////                                                              //// 
////  Autors    :                                                 //// 
////      - Manuel Zumbado Corrales manu3193@gmail.com            //// 
////      - Arturo Salas Delgado artsaldel@gmail.com              ////  
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

//Modulo del divisor de frecuencia
module Divisor_Frecuencia (
		input  C_100Mhz, //Clock de la fpga = 100MHz
		output  C_1Hz
	);

	reg[31:0] contador = 0; //Variable que almacena Contador
	reg C_1Hz=0;
	 
	always @(posedge C_100Mhz)
		begin
				if (contador == 50000000-1)          //Si ha cuenta 1s enciende led
					begin
					C_1Hz <= ~C_1Hz;
					contador <=0;
					end
				/*if (contador == 200000000-1)          //Si cuenta otro segundo lo apaga y reinicia
					begin
					C_1Hz <= 1'b0;
					contador <=0;
					end*/
				else
					begin
					contador <= contador + 1;        //suma contador
				   end
	  end
endmodule
