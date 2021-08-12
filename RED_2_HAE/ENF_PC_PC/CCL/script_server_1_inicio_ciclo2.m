
%% Crear objeto

server_1 = tcpip_servidor_pc2;

%% Cargar valores de propiedades de acceso

server_1.ip='192.168.0.15'; % Dirección IPv4 del host remoto
server_1.puerto=30000;      % Puerto del host remoto (Int: 1 - 65535)
server_1.rol='server';      % Rol del host ('server' o 'client')
server_1.tiempo=1;          % Tiempo de espera para completar operaciones
server_1.buffer_in=1;     % Buffer entrada en Bytes
server_1.buffer_out=1;      % Buffer salida en Bytes

%% Llamar métodos

% Crear objeto de comunicación
server_1.obj_tcpip=hacer_com(server_1);

% Abrir comunicación
abrir_comunicacion(server_1)

%% Llamar métodos para transmisión y recepción de datos

while true
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Configuración para la U.C. con medidas%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Operación de lectura
    if server_1.buffer_in==1
        server_1.dato_lectura=lectura_datos_1(server_1);
        
        if isempty(server_1.dato_lectura)==0
            T_IN=server_1.dato_lectura;
            
            if T_IN == 255
                % Parar simulación de simulink
                set_param(gcs, 'SimulationCommand', 'stop');
                
                error('El cliente ha terminado la simulación')
            end
            
            %Actualización de datos de corriente en simulink
            set_param('CCL_2/EMISOR-RECEPTOR/TCP_IP_RX/ESCRITURA', 'Value', 'server_1.dato_lectura');
            
            % Grabación en BD
            grabar_datos_llegada_1(server_1,'BD_datos_llegada1.txt')
            
            %Pausa para correr simulink
            tic
            pause(0.05)
            toc
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Configuración dada por la U.C.%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % Lectura de configuración dada por la U.C. desde simulink
            xto = get_param('CCL_2/EMISOR-RECEPTOR/TCP_IP_TX/LECTURA', 'RuntimeObject');
            server_1.dato_escritura=xto.InputPort(1).Data;
            
            % Ciclo if
            
            if (isempty(server_1.dato_escritura)==0)
                
                % Envío del dato hacia el servidor_1
                escritura_datos_1(server_1,server_1.dato_escritura)
                
                % Grabación en BD
                grabar_datos_salida_1(server_1,'BD_datos_salida1.txt')
                
            end
        end
    end
end
