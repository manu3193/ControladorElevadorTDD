`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////// 
////                                                              ////
////                                                              //// 
////  Registro de solicitudes                                     //// 
////                                                              ////
////                                                              //// 
////  Este archivo describe el comportamiento                     //// 
////  del registro de solicitudes  en Verilog                     //// 
////                                                              //// 
////  Description                                                 //// 
////  Este mòdulo se encarga de almacenar las solicitudes que el  ////
////  usuario hace en los pisos. Debe registrar 2 bits por cada   ////  
////  uno de los 5 pisos.                                         ////    
////                                                              //// 
////                                                              //// 
////                                                              //// 
////                                                              //// 
////  Autor    :                                                  //// 
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
/// from http://www.opencores.org/lgpl.shtml                      //// 
////                                                              //// 
//////////////////////////////////////////////////////////////////////



module RegistroSolicitudes(
   input _clk_,reset_in, 
	input solicitud_ps_clear_in, solicitud_p1_clear_in, solicitud_p2_clear_in, solicitud_p3_clear_in, solicitud_p4_clear_in,
   input [1:0] solicitud_ps_in, solicitud_p1_in, solicitud_p2_in, solicitud_p3_in, solicitud_p4_in,
	output [1:0] solicitud_ps_out, solicitud_p1_out, solicitud_p2_out, solicitud_p3_out, solicitud_p4_out
	);
	
	reg clear_ps, clear_p1, clear_p2, clear_p3, clear_p4;
	
	Registro2Bits piso_s (
	._clk_(_clk_),
	.datos_i(solicitud_ps_in),
	.clear_i(clear_ps),
	.salida_o(solicitud_ps_out));
	
	Registro2Bits piso_1 (
	._clk_(_clk_),
	.datos_i(solicitud_p1_in),
	.clear_i(clear_p1),
	.salida_o(solicitud_p1_out));
	
	Registro2Bits piso_2 (
	._clk_(_clk_),
	.datos_i(solicitud_p2_in),
	.clear_i(clear_p2),
	.salida_o(solicitud_p2_out));
	
	Registro2Bits piso_3 (
	._clk_(_clk_),
	.datos_i(solicitud_p3_in),
	.clear_i(clear_p3),
	.salida_o(solicitud_p3_out));
	
	Registro2Bits piso_4 (
	._clk_(_clk_),
	.datos_i(solicitud_p4_in),
	.clear_i(clear_p4),
	.salida_o(solicitud_p4_out));
	
	always @( posedge _clk_ or negedge reset_in) begin
		if(!reset_in) begin
			clear_ps<=1;
			clear_p1<=1;
			clear_p2<=1;
			clear_p3<=1;
			clear_p4<=1;
		end else begin
			clear_ps<=solicitud_ps_clear_in;
			clear_p1<=solicitud_p1_clear_in;
			clear_p2<=solicitud_p2_clear_in;
			clear_p3<=solicitud_p3_clear_in;
			clear_p4<=solicitud_p4_clear_in;
		end
	end
endmodule
