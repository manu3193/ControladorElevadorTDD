`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:37:15 08/26/2015 
// Design Name: 
// Module Name:    DecoBCDto7seg 
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


	/*
	 *Módulo que implementa un decodificador de código decimal binario a un dispositivo
	 *7 segmentos.
	 *
	 *
	 */

//modulo 7 segmentos
module DecoBCDto7seg(
		input wire [2:0] i, //cambia depende de lo que pase en la maquina de estados
		output o1, o2, o3, o4, o5, o6, o7, //Las salidas cambian depende de los 3 registros anteriores
		output an1, an2, an3, an4 //Anodos para activar 7 segmentos
	);
	reg o1;
	reg o2;
	reg o3;
	reg o4;
	reg o5;
	reg o6;
	reg o7;
		
	always @(o1,o2,o3,o4,o5,o6,o7)
		begin 
			o1 = !( (!i[0]&!i[2]) | i[1] ); //'C'A+B
			o2 = 1'b0;// siempre 1
			o3 = !( (!i[1]) | i[0] ); //'B+C
			o4 = !( (!i[2]&!i[0]) | i[1] );//'A'C+B
			o5 = !( (!i[2]&!i[0]) );//'A'C
			o6 = !( (!i[1]&!i[0]) );//'B'C
			o7 = !( i[2] | i[1] ); //A+B
			
		end
			
	 //Siempre estn en cero
	 assign an1 = 1'b0;
	 assign an2 = 1'b0;
	 assign an3 = 1'b0;
	 assign an4 = 1'b0;
	 
endmodule