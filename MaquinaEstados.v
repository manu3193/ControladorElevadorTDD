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
	
	//A continuación los leds que se estrán activando y desactivando
	subiendo_LED,
	bajando_LED,
	freno_act_LED,
	motor_act_LED,
	puerta_abierta_LED,
	puerta_cerrada_LED,
	sensor_puerta_LED,
	sensor_sobrepeso_LED
	 	 
   );
	
	input wire clk, reset;
	input wire [1:0] accion;
	input sensor_puerta, sensor_sobrepeso, t_expired;
	
	output reg restart_timer, start_timer;
	output reg subiendo_LED,
			 bajando_LED,
		    freno_act_LED,
			 motor_act_LED,
			 puerta_abierta_LED,
			 puerta_cerrada_LED,
			 sensor_puerta_LED,
			 sensor_sobrepeso_LED;
			 
	 output [1:0] state;
	 reg[1:0] state, nextState;
	 
	 parameter reposo = 0;
	 parameter movimiento = 1;
	 parameter detener = 2;
	 parameter abre_puerta = 3;
	 parameter inicia_conteo = 4;
	 parameter revisa_seguridad = 5;
	 parameter dispara_alerta = 6;
	 parameter reinicia_conteo = 7;
	 parameter cierra_puerta = 8;
	 
	 //Asignación sincrona del siguiente estado
	 always @(posedge clk or negedge reset)
		if (!reset)
			state <= reposo;
		else 
			state <= nextState;
	 
	 always @(state or accion)
	
	 begin
		case (state)
		
			reposo:
				begin
				freno_act_LED = 1'b1;
				puerta_abierta_LED = 1'b0;
				puerta_cerrada_LED = 1'b1;
				motor_act_LED = 1'b0;
				if (accion[1:0] == 2'b00)
					begin
					nextState = reposo;
					end
				else if (accion[1:0] == 2'b1x)
					begin
					nextState = movimiento;
					end
				else if (accion[1:0] == 2'b01)
					begin
					nextState = abre_puerta;
					end
				end
				
			movimiento:
				begin
				freno_act_LED = 1'b0;
				motor_act_LED = 1'b1;
				
				if (accion[1:0] == 2'b1x)
					begin
					if (accion[1:0] == 2'b10)
						begin
						subiendo_LED = 1'b1;
						bajando_LED = 1'b0;
						end 
					if (accion[1:0] == 2'b11)
						begin
						subiendo_LED = 1'b0;
						bajando_LED = 1'b1;
						end 
					nextState = movimiento;
					end
				else if (accion[1:0] == 2'b01)
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
				if (accion [1:0] == 2'b1x)
					begin 
					nextState = inicia_conteo;
					end
				else if (accion[1:0] == 2'b00)
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







