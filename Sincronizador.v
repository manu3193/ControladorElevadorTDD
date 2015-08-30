`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////// 
////                                                              ////
////                                                              //// 
////  Sincronizador                                               //// 
////                                                              ////
////                                                              //// 
////  Este archivo describe el comportamiento                     //// 
////  de un soncronizador antirrebote  en Verilog                 //// 
////                                                              //// 
////  Description                                                 //// 
////  Modulo encargado de sincronizar las entradas con el reloj   ////
////  del sistema. Tiene como entradas 3 bits del identificador   ////
////  del piso en código Gray, la señal binaria del sensor de     ////
////  sobrepeso, la señal binaria del sensor de obtaculización    ////
////  de la puerta y los 2 bits por cada uno de los 5 pisos donde ////
////  el MSB es señal desubida y el LSB de bajada.                ////  
////  Su funcionamiento se basa en tomar  4 muestras de las       ////  
////  entradas cada 10ms y asi se identifica el estado en que     ////  
////  se encuentran.
////                                                              //// 
////                                                              //// 
////                                                              //// 
////                                                              //// 
////  Autor    :                                                  //// 
////      - Manuel Zumbado Corrales manu3193@gmail.com            //// 
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



module Sincronizador( 
	_clk_, 
	piso_actual_i, 
	sensor_sobrePeso_i, 
	sensor_puerta_i, 
	solicitud_ps_i, 
	solicitud_p1_i,
	solicitud_p2_i, 
	solicitud_p3_i, 
	solicitud_p4_i, 
	piso_actual_o, 
	sensor_sobrePeso_o, 
	sensor_puerta_o, 
	solicitud_ps_o, 
	solicitud_p1_o, 
	solicitud_p2_o, 
	solicitud_p3_o,
	solicitud_p4_o
	);
					
	 //Se definen las entradas y salidas del módulo						
	 input sensor_sobrePeso_i, sensor_puerta_i, _clk_;
	 input [2:0] piso_actual_i;
	 input [1:0] solicitud_ps_i, solicitud_p1_i, solicitud_p2_i, solicitud_p3_i, solicitud_p4_i;
	 
	 output reg sensor_sobrePeso_o, sensor_puerta_o;
	 output reg [2:0] piso_actual_o;
	 output reg [1:0] solicitud_ps_o, solicitud_p1_o, solicitud_p2_o, solicitud_p3_o, solicitud_p4_o;
	 
	 //El contador cuenta hasta 10ms, por lo que se almacena 1000000.
	 localparam contador_max= 19'd1000000;
	 
	 //Se crea el primer registro (flip-flop) por cada entrada para sincronizarlos con el clk
	 reg sensor_sobrePeso_sync_0;
	 reg sensor_puerta_sync_0;
	 reg [2:0] piso_actual_sync_0;
	 reg [1:0] solicitud_ps_sync_0;
	 reg [1:0] solicitud_p1_sync_0;
	 reg [1:0] solicitud_p2_sync_0;
	 reg [1:0] solicitud_p3_sync_0;
	 reg [1:0] solicitud_p4_sync_0;
	 
	 //En cada estado positivo del clk, los registros guardan los valores de los botones/switches
	 always @(posedge _clk_) 
		begin
			sensor_sobrePeso_sync_0 <= sensor_sobrePeso_i;
			sensor_puerta_sync_0    <= sensor_puerta_i;
			piso_actual_sync_0      <= piso_actual_i;
			solicitud_ps_sync_0     <= solicitud_ps_i;
			solicitud_p1_sync_0     <= solicitud_p1_i;
			solicitud_p2_sync_0     <= solicitud_p2_i;
			solicitud_p3_sync_0     <= solicitud_p3_i;
			solicitud_p4_sync_0     <= solicitud_p4_i;
		end

	 //Se crea el segundo registro (flip-flop) por cada salida de los registros anteriores para sincronizarlos con el clk
	 reg sensor_sobrePeso_sync_1;
	 reg sensor_puerta_sync_1;
	 reg [2:0] piso_actual_sync_1;
	 reg [1:0] solicitud_ps_sync_1;
	 reg [1:0] solicitud_p1_sync_1;
	 reg [1:0] solicitud_p2_sync_1;
	 reg [1:0] solicitud_p3_sync_1;
	 reg [1:0] solicitud_p4_sync_1;
	 
	 //En cada estado positivo del clk, los registros guardan los valores el registro anterior para sincronizar con el clk
	 always @(posedge _clk_) 
		begin
			sensor_sobrePeso_sync_1 <= sensor_sobrePeso_sync_0;
			sensor_puerta_sync_1    <= sensor_puerta_sync_0;
			piso_actual_sync_1      <= piso_actual_sync_0;
			solicitud_ps_sync_1     <= solicitud_ps_sync_0;
			solicitud_p1_sync_1     <= solicitud_p1_sync_0;
			solicitud_p2_sync_1     <= solicitud_p2_sync_0;
			solicitud_p3_sync_1     <= solicitud_p3_sync_0;
			solicitud_p4_sync_1     <= solicitud_p4_sync_0;
		end
	 
	 //Se crea el registro que almacena el contador
	 reg [19:0] contador;
	 
	 //Se crean los shift registers que almacenan las 4 muestras de los estados de los botones y switches correspondientes
	 reg [3:0] sr_sobrePeso= 4'b0, sr_puerta= 4'b0, sr_piso_actual_0= 4'b0, sr_piso_actual_1= 4'b0, sr_piso_actual_2= 4'b0;
	 reg [3:0] sr_solicitud_ps_0=4'b0, sr_solicitud_ps_1=4'b0, sr_solicitud_p1_0= 4'b0, sr_solicitud_p1_1=4'b0, sr_solicitud_p2_0=4'b0;
	 reg [3:0] sr_solicitud_p2_1=4'b0, sr_solicitud_p3_0=4'b0, sr_solicitud_p3_1=4'b0, sr_solicitud_p4_0= 4'b0, sr_solicitud_p4_1=4'b0;
	 
	 always @(posedge _clk_) 
		begin
			if (contador==contador_max) begin
				
				//Se hace un corrimiento a la izquierda y se almacena el estado de la entrada segun muestreo cada 10ms.
				sr_sobrePeso         <= (sr_sobrePeso      << 1)  | sensor_sobrePeso_sync_1;
				sr_puerta            <= (sr_puerta         << 1)  | sensor_puerta_sync_1;
				sr_piso_actual_0     <= (sr_piso_actual_0  << 1)  | piso_actual_sync_1[0];
				sr_piso_actual_1     <= (sr_piso_actual_1  << 1)  | piso_actual_sync_1[1];
				sr_piso_actual_2     <= (sr_piso_actual_2  << 1)  | piso_actual_sync_1[2];
				sr_solicitud_ps_0    <= (sr_solicitud_ps_0 << 1)  | solicitud_ps_sync_1[0];
				sr_solicitud_ps_1    <= (sr_solicitud_ps_1 << 1)  | solicitud_ps_sync_1[1];
				sr_solicitud_p1_0    <= (sr_solicitud_p1_0 << 1)  | solicitud_p1_sync_1[0];
				sr_solicitud_p1_1    <= (sr_solicitud_p1_1 << 1)  | solicitud_p1_sync_1[1];
				sr_solicitud_p2_0    <= (sr_solicitud_p2_0 << 1)  | solicitud_p2_sync_1[0];
				sr_solicitud_p2_1    <= (sr_solicitud_p2_1 << 1)  | solicitud_p2_sync_1[1];
				sr_solicitud_p3_0    <= (sr_solicitud_p3_0 << 1)  | solicitud_p3_sync_1[0];
				sr_solicitud_p3_1    <= (sr_solicitud_p3_1 << 1)  | solicitud_p3_sync_1[1];
				sr_solicitud_p4_0    <= (sr_solicitud_p4_0 << 1)  | solicitud_p4_sync_1[0];
				sr_solicitud_p4_1    <= (sr_solicitud_p4_1 << 1)  | solicitud_p4_sync_1[1];
			end
		
			//Se escribe en cada salida correspondiente un 1 si los 4 bits muestreados cada 10ns son 1111 y 0 si los 4 bits muestreados fueron 0000
			case (sr_sobrePeso)
						4'b0000: sensor_sobrePeso_o <= 0;
						4'b1111: sensor_sobrePeso_o <= 1;
			endcase
			
			case (sr_puerta)
						4'b0000: sensor_puerta_o <= 0;
						4'b1111: sensor_puerta_o <= 1;
			endcase
			
			case (sr_piso_actual_0)
						4'b0000: piso_actual_o[0] <= 0;
						4'b1111: piso_actual_o[0] <= 1;
			endcase
			
			case (sr_piso_actual_1)
						4'b0000: piso_actual_o[1] <= 0;
						4'b1111: piso_actual_o[1] <= 1;
			endcase
			
			case (sr_piso_actual_2)
						4'b0000: piso_actual_o[2] <= 0;
						4'b1111: piso_actual_o[2] <= 1;
			endcase
			
			case (sr_solicitud_ps_0)
						4'b0000: solicitud_ps_o[0] <= 0;
						4'b1111: solicitud_ps_o[0] <= 1;
			endcase
			
			case (sr_solicitud_ps_1)
						4'b0000: solicitud_ps_o[1] <= 0;
						4'b1111: solicitud_ps_o[1] <= 1;
			endcase
			
			case (sr_solicitud_p1_0)
						4'b0000: solicitud_p1_o[0] <= 0;
						4'b1111: solicitud_p1_o[0] <= 1;
			endcase
			
			case (sr_solicitud_p1_1)
						4'b0000: solicitud_p1_o[1] <= 0;
						4'b1111: solicitud_p1_o[1] <= 1;
			endcase
			
			case (sr_solicitud_p2_0)
						4'b0000: solicitud_p2_o[0] <= 0;
						4'b1111: solicitud_p2_o[0] <= 1;
			endcase
			
			case (sr_solicitud_p2_1)
						4'b0000: solicitud_p2_o[1] <= 0;
						4'b1111: solicitud_p2_o[1] <= 1;
			endcase
			
			case (sr_solicitud_p3_0)
						4'b0000: solicitud_p3_o[0] <= 0;
						4'b1111: solicitud_p3_o[0] <= 1;
			endcase
			
			case (sr_solicitud_p3_1)
						4'b0000: solicitud_p3_o[1] <= 0;
						4'b1111: solicitud_p3_o[1] <= 1;
			endcase
			
			case (sr_solicitud_p4_0)
						4'b0000: solicitud_p4_o[0] <= 0;
						4'b1111: solicitud_p4_o[0] <= 1;
			endcase
			
			case (sr_solicitud_p4_1)
						4'b0000: solicitud_p4_o[1] <= 0;
						4'b1111: solicitud_p4_o[1] <= 1;
			endcase
		end
endmodule
