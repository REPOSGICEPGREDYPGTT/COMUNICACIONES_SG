%% Llamar m�todos

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Env�o datos de corriente RMS 3F      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Lectura de datos de corriente dados por los P.C.C. de la red el�ctrica
rto = get_param('MICRORRED/EMISOR-RECEPTOR/TCP_IP_TX/LECTURA', 'RuntimeObject');
datos_simulink=rto.InputPort(1).Data;

if client_1.buffer_out==1
    IA=fix(datos_simulink(1));
%     IB=fix(datos_simulink(2));
%     IC=fix(datos_simulink(3)); 
    
    dato3=uint8(IA);
    
    client_1.dato_escritura=dato3;
    
    % Operaci�n de escritura de datos hac�a el server_1enario_1_art_JA_v6_RE/TCP_IP
    escritura_datos_1(client_1,client_1.dato_escritura)
    % Grabaci�n en BD
    grabar_datos_salida_1(client_1,'BD_datos_salida3.txt')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Recibo configuraci�n dada por la U.C.%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Operaci�n de lectura
if client_1.buffer_in==1
    client_1.dato_lectura=lectura_datos_1(client_1);
    
    if isempty(client_1.dato_lectura) ==0
        client_1.dato_lectura=str2double(char(client_1.dato_lectura));             
        % Grabaci�n en BD
        grabar_datos_llegada_2(client_1,'BD_datos_llegada1.txt')
        % Actualizaci�n de la configuraci�n enviada en simulink
        [puerto,e]=duracion(client_1,'BD_datos_salida3.txt','BD_datos_llegada1.txt');
        set_param('MICRORRED/EMISOR-RECEPTOR/TCP_IP_RX3/ESCRITURA', 'Value', 'client_1.dato_lectura')
        set_param('MICRORRED/EMISOR-RECEPTOR/TCP_IP_RX3/RETARDO', 'Value', 'e')
    end
end