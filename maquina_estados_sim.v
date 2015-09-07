`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:05:56 09/06/2015
// Design Name:   MaquinaEstados
// Module Name:   C:/Users/Arturo/Desktop/ControladorElevadorTDD2/trunk/maquina_estados_sim.v
// Project Name:  ControladorElevadorTDD
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MaquinaEstados
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module maquina_estados_sim;

	// Inputs
	reg clk;
	reg reset;
	reg [1:0] accion;
	reg sensor_puerta;
	reg sensor_sobrepeso;
	reg t_expired;

	// Outputs
	wire [3:0] state;
	wire restart_timer;
	wire start_timer;
	wire habilita_verificador;
	wire inicia_Registro_Solicitudes;
	wire subiendo_LED;
	wire bajando_LED;
	wire freno_act_LED;
	wire motor_act_LED;
	wire puerta_abierta_LED;
	wire puerta_cerrada_LED;
	wire sensor_puerta_LED;
	wire sensor_sobrepeso_LED;
	wire ready;

	// Instantiate the Unit Under Test (UUT)
	MaquinaEstados uut (
		.clk(clk), 
		.reset(reset), 
		.state(state), 
		.accion(accion), 
		.sensor_puerta(sensor_puerta), 
		.sensor_sobrepeso(sensor_sobrepeso), 
		.t_expired(t_expired), 
		.restart_timer(restart_timer), 
		.start_timer(start_timer), 
		.habilita_verificador(habilita_verificador), 
		.inicia_Registro_Solicitudes(inicia_Registro_Solicitudes), 
		.subiendo_LED(subiendo_LED), 
		.bajando_LED(bajando_LED), 
		.freno_act_LED(freno_act_LED), 
		.motor_act_LED(motor_act_LED), 
		.puerta_abierta_LED(puerta_abierta_LED), 
		.puerta_cerrada_LED(puerta_cerrada_LED), 
		.sensor_puerta_LED(sensor_puerta_LED), 
		.sensor_sobrepeso_LED(sensor_sobrepeso_LED), 
		.ready(ready)
	);
	
	always 
		begin
			#5 clk = ~clk;
		end
		
	initial begin
		// Initialize Inputs
		reset = 1;
		clk = 1;
		accion = 0;
		sensor_puerta = 0;
		sensor_sobrepeso = 0;
		t_expired = 0;

		// Wait 100 ns for global reset to finish
		#10;
		reset = 0;
		
		#10;
		accion = 2'b10;
		
		#10;
		accion = 2'b10;
		
		#10;
		accion = 2'b01;
		
		#10;
		accion = 2'b00;
		
		/////////////////////
		
		#10;
		accion = 2'b00;
		
		#10;
		accion = 2'b10;
		
		#10;
		accion = 2'b01;
		
		#10;
		accion = 2'b11;
		sensor_puerta = 1'b1;
		
		#10;
		accion = 2'b11;
		sensor_puerta = 1'b0;
		sensor_sobrepeso = 1'b1;
		
		#10;
		accion = 2'b11;
		sensor_sobrepeso = 1'b0;
		t_expired = 1'b1;
		

	end
      
endmodule

