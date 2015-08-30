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

module Ascensor( _clk_, start_timer, restart, t_expired);
/*
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
	);*/
	
	input _clk_, start_timer, restart;
	output wire t_expired;
	wire a;
	
	
	Divisor_Frecuencia div(
		.C_100Mhz(_clk_),
		.C_1Hz(a));
		
	Temporizador temp(
		._clk_(a),
		.start_i(start_timer),
		.restart_i(restart),
		.t_expired_o(t_expired));
endmodule
