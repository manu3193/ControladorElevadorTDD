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
module DecoBCDto7seg(
	
    input A,
    input B,
    input C,
    input D,
	 
    output o1,
    output o2,
    output o3,
    output o4,
    output o5,
    output o6,
    output o7,
	 
	 output an1,
	 output an2,
	 output an3,
	 output an4
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
				o1 = !((!C&!A)| (C&A) | B | D); 
				o2 = !(!C | D| (A&B) | (!A&!B));
				o3 = ! ( (!A&!B) | A | D | C);
				o4 = !((!A&!C) | (B&!C) | D | (!A&B) | (A&!B&C));
				o5 = !( (!A&!C) | (!A&D) | (B&D) | (C&D) | (!A&B));
				o6 = ! ((!A&!B) | D | (!A&C) | (!B&C));
				o7 = !(D | (B&!C) | (!A&C) | (!B&C)); 
				
			end
	 
	 assign an1 = 1'b0;
	 assign an2 = 1'b0;
	 assign an3 = 1'b0;
	 assign an4 = 1'b0;

endmodule