`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:53:36 08/29/2015 
// Design Name: 
// Module Name:    Ascensor 
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

module Ascensor( _clk_,_reset_i,solicitud_ps,solicitud_p1,solicitud_p2,solicitud_p3,solicitud_p4,
piso_actual,sobrepeso,puerta,solicitud_ps_out,solicitud_p1_out,solicitud_p2_out,solicitud_p3_out,
solicitud_p4_out,piso_actual_o,sobrepeso_o,puerta_o,clear_ps,clear_p1,clear_p2,clear_p3,clear_p4);

	wire [1:0] conector_1;
	wire conector_2;
	wire conector_3;
	wire conector_4;
	wire conector_5;
	wire conector_6;
	wire conector_7;
	wire conector_8;
	wire conector_9;
	wire conector_10;
	wire conector_11;
	
	
	MaquinaEstados maquina_estados(
		.accion (conector_1),
		.sensor_puerta (conector_2),
		.sensor_sobrepeso (conector_3),
		.clk (conector_4),
		.reset (conector_5),
		.state (conector_6),
		.t_expired (conector_7),
		.restart_timer (conector_8),
		.start_timer (conector_9)		
	);
	
	input _clk_;
	input _reset_i;
	input [1:0] solicitud_ps;
	input [1:0] solicitud_p1;
	input [1:0] solicitud_p2;
	input [1:0] solicitud_p3;
	input [1:0] solicitud_p4;
	input [2:0] piso_actual;
	input sobrepeso;
	input puerta;
	input clear_ps;
	input clear_p1;
	input clear_p2;
	input clear_p3;
	input clear_p4;

	
	

	// Outputs
	output [1:0] solicitud_ps_out;
	output [1:0] solicitud_p1_out;
	output [1:0] solicitud_p2_out;
	output [1:0] solicitud_p3_out;
	output [1:0] solicitud_p4_out;
	output [2:0] piso_actual_o;
	output sobrepeso_o;
	output puerta_o;
	
	wire[1:0] piso_s, piso_1, piso_2,piso_3, piso_4;
	
	Sincronizador sinc(
	._clk_(_clk_), 
	.piso_actual_i(piso_actual),
	.sensor_sobrePeso_i(sobrepeso), 
	.sensor_puerta_i(puerta), 
	.solicitud_ps_i(solicitud_ps), 
	.solicitud_p1_i(solicitud_p1),
	.solicitud_p2_i(solicitud_p2), 
	.solicitud_p3_i(solicitud_p3), 
	.solicitud_p4_i(solicitud_p4), 
	.piso_actual_o(piso_actual_o), 
	.sensor_sobrePeso_o(sobrepeso_o), 
	.sensor_puerta_o(puerta_o), 
	.solicitud_ps_o(piso_s), 
	.solicitud_p1_o(piso_1), 
	.solicitud_p2_o(piso_2), 
	.solicitud_p3_o(piso_3),
	.solicitud_p4_o(piso_4)
	);
	
	RegistroSolicitudes regsol(
	._clk_(_clk_),
	.reset_in(_reset_i),
	.solicitud_ps_clear_in(clear_ps), 
	.solicitud_p1_clear_in(clear_p1), 
	.solicitud_p2_clear_in(clear_p2), 
	.solicitud_p3_clear_in(clear_p3), 
	.solicitud_p4_clear_in(clear_p4),
   .solicitud_ps_in(~piso_s), 
	.solicitud_p1_in(~piso_1), 
	.solicitud_p2_in(~piso_2), 
	.solicitud_p3_in(~piso_3), 
	.solicitud_p4_in(~piso_4),
	.solicitud_ps_out(solicitud_ps_out), 
	.solicitud_p1_out(solicitud_p1_out), 
	.solicitud_p2_out(solicitud_p2_out), 
	.solicitud_p3_out(solicitud_p3_out), 
	.solicitud_p4_out(solicitud_p4_out));
	/*
	//_clk_, start_timer, restart, t_expired,a
	entrada_gray, 
	o1, o2, o3, o4, o5, o6, o7,
	an1, an2, an3, an4
	);
	*/
	
	/*input _clk_, start_timer, restart;
	output wire t_expired;
	output wire a;
	
	output o1, o2, o3, o4, o5, o6, o7;
	output an1, an2, an3, an4;
	
	input [2:0] entrada_gray;
	wire [2:0] salida_gray;
	
	
	DecoGreytoBCD deco_gray (
		.entradas_i (entrada_gray),	
		.salidas_o (salida_gray)
	);
	
	DecoBCDto7seg (
		.i(salida_gray),
		.o1(o1),
		.o2(o2),
		.o3(o3),
		.o4(o4),
		.o5(o5),
		.o6(o6),
		.o7(o7),
		.an1(an1),
		.an2(an2),
		.an3(an3),
		.an4(an4)
	);
	
	Divisor_Frecuencia div(
		.C_100Mhz(_clk_),
		.C_1Hz(a));
		
	Temporizador temp(
		._clk_(a),
		.start_i(start_timer),
		.restart_i(restart),
		.t_expired_o(t_expired));*/
		
	
		
	
	
endmodule
