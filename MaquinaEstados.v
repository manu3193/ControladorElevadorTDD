`timescale 1ns / 1ps


module MaquinaEstados(

	clk, //Clock de la maquina de estados
	reset, //Reset de la maquina de estados
	state, //para la maquina de estados
	
	accion, //00:reposo,01:llegado a destino,10:subir, 11:bajar
	sensor_puerta, //Indicador de puerta atascada (1: atascado, 0 libre)
	sensor_sobrepeso, //Indicador de sobrepeso (1: si hay, 0 no hay)
	t_expired,
	
	restart_timer, //reinicia el timer 
	start_timer, //inicia el timer
	
	//Se;al que habilitan el verificador de movimiento
	habilita_verificador,
	inicia_Registro_Solicitudes,
	
	
	//A continuacin los leds que se estrn activando y desactivando
	subiendo_LED,
	bajando_LED,
	freno_act_LED,
	motor_act_LED,
	puerta_abierta_LED,
	puerta_cerrada_LED,
	sensor_puerta_LED,
	sensor_sobrepeso_LED,
	
	//Se;al de finalizaci'on
	ready
	

	 	 
   );
	
	input wire clk, reset;
	input wire [1:0] accion;
	input sensor_puerta, sensor_sobrepeso, t_expired;
	
	output reg restart_timer, start_timer, ready, habilita_verificador, inicia_Registro_Solicitudes;
	output reg subiendo_LED,
			 bajando_LED,
		    freno_act_LED,
			 motor_act_LED,
			 puerta_abierta_LED,
			 puerta_cerrada_LED,
			 sensor_puerta_LED,
			 sensor_sobrepeso_LED;
			 
	 output [1:0] state;
	 reg[3:0] state, nextState;
	 
	 parameter inicio=4'd0;
	 parameter reposo = 4'd1;
	 parameter movimiento = 4'd2;
	 parameter detener = 4'd3;
	 parameter abre_puerta = 4'd4;
	 parameter inicia_conteo = 4'd5;
	 parameter revisa_seguridad = 4'd6;
	 parameter dispara_alerta = 4'd7;
	 parameter reinicia_conteo = 4'd8;
	 parameter cierra_puerta = 4'd9;
	 
	 //Asignacin sincrona del siguiente estado
	 always @(posedge clk or posedge reset)
		if (reset)
			state <= inicio;
		else 
			state <= nextState;
	
	 
	 
	 always @(state or accion) begin
	 nextState=4'bxxxx;
		case (state)
			inicio:
				begin
					habilita_verificador=1'b1;
					inicia_Registro_Solicitudes=1'b1;
					nextState = reposo;
				end
			reposo:
				begin
					freno_act_LED = 1'b1;
					puerta_abierta_LED = 1'b0;
					puerta_cerrada_LED = 1'b1;
					motor_act_LED = 1'b0;
					if (accion == 2'b00) begin
						nextState = reposo;
					end
					else if (accion == 2'b10 || accion == 2'b11) begin
					nextState = movimiento;
					end
					else if (accion == 2'b01) begin
					nextState = abre_puerta;
					end
				end
				
			movimiento:
				begin
				freno_act_LED = 1'b0;
				motor_act_LED = 1'b1;
				if (accion == 2'b10) begin
					subiendo_LED = 1'b1;
					bajando_LED = 1'b0;
					//Agregar se activa el 7seg subiendo
					nextState = movimiento;
				end 
				else if (accion == 2'b11) begin
					subiendo_LED = 1'b0;
					bajando_LED = 1'b1;
					//Agregar se activa el 7 seg bajando
					nextState = movimiento;
				end 
				else if (accion == 2'b01)
					begin
					nextState = detener;
					end
				end
				
			detener:
				begin
				freno_act_LED = 1'b1;
				motor_act_LED = 1'b0;
				nextState = abre_puerta;
				end
				
			abre_puerta:
				begin
				puerta_abierta_LED = 1'b1;
				puerta_cerrada_LED = 1'b0;
				ready= 1'b1;
				if (accion == 2'b10 || accion == 2'b11)
					begin 
					nextState = inicia_conteo;
					end
				else if (accion == 2'b00)
					begin 
					nextState = reposo;
					end
				end
				
			inicia_conteo:
				begin
				start_timer = 1'b1;
				nextState = revisa_seguridad;
				end
				
			revisa_seguridad:
				begin
				if (!(sensor_puerta) & !(sensor_sobrepeso) & !(t_expired))
					begin
					nextState = revisa_seguridad;
					end
				else if (sensor_sobrepeso | sensor_puerta & !(t_expired))
					begin
					nextState = dispara_alerta;
					end
				else if (t_expired)
					begin
					nextState = cierra_puerta;
					end
				end
				
			dispara_alerta:
				begin
				if (sensor_sobrepeso)
					begin
					sensor_sobrepeso_LED = 1'b1;
					end
				if (sensor_puerta)
					begin
					sensor_puerta_LED = 1'b1;
					end 
				nextState = reinicia_conteo;
				end
				
			reinicia_conteo:
				begin
				restart_timer = 1'b1;
				nextState = revisa_seguridad;
				end
				
			cierra_puerta:
				begin
				puerta_abierta_LED = 1'b0;
				puerta_cerrada_LED = 1'b1;
				nextState = movimiento;
				end
			
			default: nextState = reposo;
			
		endcase
	end
endmodule








