
%% Crear objeto

server_1 = tcpip_servidor_pc1;

%% Cargar valores de propiedades de acceso

server_1.ip='192.168.0.15'; % Dirección IPv4 del host remoto
server_1.puerto=30000;      % Puerto del host remoto (Int: 1 - 65535)
server_1.rol='server';      % Rol del host ('server' o 'client')
server_1.tiempo=1;          % Tiempo de espera para completar operaciones
server_1.buffer_in=6;       % Buffer entrada en Bytes
server_1.buffer_out=512;    % Buffer salida en Bytes

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
    if server_1.buffer_in==6
        server_1.dato_lectura=lectura_datos_6(server_1);
        
        if isempty(server_1.dato_lectura)==0
            [RE, GD1, GD2]=arreglo_datos_s2_c6(server_1);
            server_1.dato_lectura=[RE, GD1, GD2];
            
            %Actualización de datos de corriente en simulink
            set_param('CCL_1/EMISOR-RECEPTOR/TCP_IP_RX/ESCRITURA', 'Value', 'server_1.dato_lectura');
            
            % Grabación en BD
            grabar_datos_llegada_6(server_1,'BD_datos_llegada6.txt')
            
            %Pausa para correr simulink
            tic
            pause(0.05)
            toc
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % Configuración dada por la U.C.%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            % Lectura de configuración dada por la U.C. desde simulink
            xto = get_param('CCL_1/EMISOR-RECEPTOR/TCP_IP_TX/LECTURA', 'RuntimeObject');
            datos_simulink=xto.InputPort(1).Data;
            
            % Ciclo if, si el dato no está actualizado, no lo envíe
            
            if (isempty(datos_simulink)==0)
                
                CONF1_INT=fix(datos_simulink(1));
                CONF1_DEC=1e4*mod(abs(datos_simulink(1)),1);
                K1_INT=fix(datos_simulink(2));
                K1_DEC=1e4*mod(abs(datos_simulink(2)),1);
                ALFA1_INT=fix(datos_simulink(3));
                ALFA1_DEC=1e4*mod(abs(datos_simulink(3)),1);
                B1_INT=fix(datos_simulink(4));
                B1_DEC=1e4*mod(abs(datos_simulink(4)),1);
                PS1_INT=fix(datos_simulink(5));
                PS1_DEC=1e4*mod(abs(datos_simulink(5)),1);
                TMS1_INT=fix(datos_simulink(6));
                TMS1_DEC=1e4*mod(abs(datos_simulink(6)),1);
                TINS1_INT=fix(datos_simulink(7));
                TINS1_DEC=1e4*mod(abs(datos_simulink(7)),1);
                ESC1_INT=fix(datos_simulink(8));
                ESC1_DEC=1e4*mod(abs(datos_simulink(8)),1);
                
                CONF2_INT=fix(datos_simulink(9));
                CONF2_DEC=1e4*mod(abs(datos_simulink(9)),1);
                K2_INT=fix(datos_simulink(10));
                K2_DEC=1e4*mod(abs(datos_simulink(10)),1);
                ALFA2_INT=fix(datos_simulink(11));
                ALFA2_DEC=1e4*mod(abs(datos_simulink(11)),1);
                B2_INT=fix(datos_simulink(12));
                B2_DEC=1e4*mod(abs(datos_simulink(12)),1);
                PS2_INT=fix(datos_simulink(13));
                PS2_DEC=1e4*mod(abs(datos_simulink(13)),1);
                TMS2_INT=fix(datos_simulink(14));
                TMS2_DEC=1e4*mod(abs(datos_simulink(14)),1);
                TINS2_INT=fix(datos_simulink(15));
                TINS2_DEC=1e4*mod(abs(datos_simulink(15)),1);
                ESC2_INT=fix(datos_simulink(16));
                ESC2_DEC=1e4*mod(abs(datos_simulink(16)),1);
                
                CONF3_INT=fix(datos_simulink(17));
                CONF3_DEC=1e4*mod(abs(datos_simulink(17)),1);
                K3_INT=fix(datos_simulink(18));
                K3_DEC=1e4*mod(abs(datos_simulink(18)),1);
                ALFA3_INT=fix(datos_simulink(19));
                ALFA3_DEC=1e4*mod(abs(datos_simulink(19)),1);
                B3_INT=fix(datos_simulink(20));
                B3_DEC=1e4*mod(abs(datos_simulink(20)),1);
                PS3_INT=fix(datos_simulink(21));
                PS3_DEC=1e4*mod(abs(datos_simulink(21)),1);
                TMS3_INT=fix(datos_simulink(22));
                TMS3_DEC=1e4*mod(abs(datos_simulink(22)),1);
                TINS3_INT=fix(datos_simulink(23));
                TINS3_DEC=1e4*mod(abs(datos_simulink(23)),1);
                ESC3_INT=fix(datos_simulink(24));
                ESC3_DEC=1e4*mod(abs(datos_simulink(24)),1);
                
                CONF4_INT=fix(datos_simulink(25));
                CONF4_DEC=1e4*mod(abs(datos_simulink(25)),1);
                K4_INT=fix(datos_simulink(26));
                K4_DEC=1e4*mod(abs(datos_simulink(26)),1);
                ALFA4_INT=fix(datos_simulink(27));
                ALFA4_DEC=1e4*mod(abs(datos_simulink(27)),1);
                B4_INT=fix(datos_simulink(28));
                B4_DEC=1e4*mod(abs(datos_simulink(28)),1);
                PS4_INT=fix(datos_simulink(29));
                PS4_DEC=1e4*mod(abs(datos_simulink(29)),1);
                TMS4_INT=fix(datos_simulink(30));
                TMS4_DEC=1e4*mod(abs(datos_simulink(30)),1);
                TINS4_INT=fix(datos_simulink(31));
                TINS4_DEC=1e4*mod(abs(datos_simulink(31)),1);
                ESC4_INT=fix(datos_simulink(32));
                ESC4_DEC=1e4*mod(abs(datos_simulink(32)),1);
                
                CONF5_INT=fix(datos_simulink(33));
                CONF5_DEC=1e4*mod(abs(datos_simulink(33)),1);
                K5_INT=fix(datos_simulink(34));
                K5_DEC=1e4*mod(abs(datos_simulink(34)),1);
                ALFA5_INT=fix(datos_simulink(35));
                ALFA5_DEC=1e4*mod(abs(datos_simulink(35)),1);
                B5_INT=fix(datos_simulink(36));
                B5_DEC=1e4*mod(abs(datos_simulink(36)),1);
                PS5_INT=fix(datos_simulink(37));
                PS5_DEC=1e4*mod(abs(datos_simulink(37)),1);
                TMS5_INT=fix(datos_simulink(38));
                TMS5_DEC=1e4*mod(abs(datos_simulink(38)),1);
                TINS5_INT=fix(datos_simulink(39));
                TINS5_DEC=1e4*mod(abs(datos_simulink(39)),1);
                ESC5_INT=fix(datos_simulink(40));
                ESC5_DEC=1e4*mod(abs(datos_simulink(40)),1);
                
                if server_1.buffer_out==170
                    
                    FINAL='00000';
                    
                    dato170=uint16([CONF1_INT,CONF1_DEC,K1_INT,K1_DEC,ALFA1_INT,ALFA1_DEC,B1_INT,B1_DEC,PS1_INT,PS1_DEC,TMS1_INT,TMS1_DEC,TINS1_INT,TINS1_DEC,ESC1_INT,ESC1_DEC,CONF2_INT,CONF2_DEC,K2_INT,K2_DEC,ALFA2_INT,ALFA2_DEC,B2_INT,B2_DEC,PS2_INT,PS2_DEC,TMS2_INT,TMS2_DEC,TINS2_INT,TINS2_DEC,ESC2_INT,ESC2_DEC,CONF3_INT,CONF3_DEC,K3_INT,K3_DEC,ALFA3_INT,ALFA3_DEC,B3_INT,B3_DEC,PS3_INT,PS3_DEC,TMS3_INT,TMS3_DEC,TINS3_INT,TINS3_DEC,ESC3_INT,ESC3_DEC,CONF4_INT,CONF4_DEC,K4_INT,K4_DEC,ALFA4_INT,ALFA4_DEC,B4_INT,B4_DEC,PS4_INT,PS4_DEC,TMS4_INT,TMS4_DEC,TINS4_INT,TINS4_DEC,ESC4_INT,ESC4_DEC,CONF5_INT,CONF5_DEC,K5_INT,K5_DEC,ALFA5_INT,ALFA5_DEC,B5_INT,B5_DEC,PS5_INT,PS5_DEC,TMS5_INT,TMS5_DEC,TINS5_INT,TINS5_DEC,ESC5_INT,ESC5_DEC,FINAL]);
                    server_1.dato_escritura=dato170;
                    
                    % Operación de escritura de datos hacía el cliente
                    escritura_datos_n(server_1,server_1.dato_escritura)
                    
                    % Grabación en BD
                    grabar_datos_salida_170(server_1,'BD_datos_salida170.txt')
                    
                end
                
                if server_1.buffer_out==190
                    
                    FINAL='000000000000000';
                    
                    dato190=uint16([CONF1_INT,CONF1_DEC,K1_INT,K1_DEC,ALFA1_INT,ALFA1_DEC,B1_INT,B1_DEC,PS1_INT,PS1_DEC,TMS1_INT,TMS1_DEC,TINS1_INT,TINS1_DEC,ESC1_INT,ESC1_DEC,CONF2_INT,CONF2_DEC,K2_INT,K2_DEC,ALFA2_INT,ALFA2_DEC,B2_INT,B2_DEC,PS2_INT,PS2_DEC,TMS2_INT,TMS2_DEC,TINS2_INT,TINS2_DEC,ESC2_INT,ESC2_DEC,CONF3_INT,CONF3_DEC,K3_INT,K3_DEC,ALFA3_INT,ALFA3_DEC,B3_INT,B3_DEC,PS3_INT,PS3_DEC,TMS3_INT,TMS3_DEC,TINS3_INT,TINS3_DEC,ESC3_INT,ESC3_DEC,CONF4_INT,CONF4_DEC,K4_INT,K4_DEC,ALFA4_INT,ALFA4_DEC,B4_INT,B4_DEC,PS4_INT,PS4_DEC,TMS4_INT,TMS4_DEC,TINS4_INT,TINS4_DEC,ESC4_INT,ESC4_DEC,CONF5_INT,CONF5_DEC,K5_INT,K5_DEC,ALFA5_INT,ALFA5_DEC,B5_INT,B5_DEC,PS5_INT,PS5_DEC,TMS5_INT,TMS5_DEC,TINS5_INT,TINS5_DEC,ESC5_INT,ESC5_DEC,FINAL]);
                    server_1.dato_escritura=dato190;
                    
                    % Operación de escritura de datos hacía el cliente
                    escritura_datos_n(server_1,server_1.dato_escritura)
                    
                    % Grabación en BD
                    grabar_datos_salida_190(server_1,'BD_datos_salida190.txt')
                    
                end
                
                if server_1.buffer_out==256
                    
                    FINAL='000000000000000000000000000000000000000000000000'; %48 
                    
                    dato256=uint16([CONF1_INT,CONF1_DEC,K1_INT,K1_DEC,ALFA1_INT,ALFA1_DEC,B1_INT,B1_DEC,PS1_INT,PS1_DEC,TMS1_INT,TMS1_DEC,TINS1_INT,TINS1_DEC,ESC1_INT,ESC1_DEC,CONF2_INT,CONF2_DEC,K2_INT,K2_DEC,ALFA2_INT,ALFA2_DEC,B2_INT,B2_DEC,PS2_INT,PS2_DEC,TMS2_INT,TMS2_DEC,TINS2_INT,TINS2_DEC,ESC2_INT,ESC2_DEC,CONF3_INT,CONF3_DEC,K3_INT,K3_DEC,ALFA3_INT,ALFA3_DEC,B3_INT,B3_DEC,PS3_INT,PS3_DEC,TMS3_INT,TMS3_DEC,TINS3_INT,TINS3_DEC,ESC3_INT,ESC3_DEC,CONF4_INT,CONF4_DEC,K4_INT,K4_DEC,ALFA4_INT,ALFA4_DEC,B4_INT,B4_DEC,PS4_INT,PS4_DEC,TMS4_INT,TMS4_DEC,TINS4_INT,TINS4_DEC,ESC4_INT,ESC4_DEC,CONF5_INT,CONF5_DEC,K5_INT,K5_DEC,ALFA5_INT,ALFA5_DEC,B5_INT,B5_DEC,PS5_INT,PS5_DEC,TMS5_INT,TMS5_DEC,TINS5_INT,TINS5_DEC,ESC5_INT,ESC5_DEC,FINAL]);
                    server_1.dato_escritura=dato256;
                    
                    % Operación de escritura de datos hacía el cliente
                    escritura_datos_n(server_1,server_1.dato_escritura)
                    
                    % Grabación en BD
                    grabar_datos_salida_256(server_1,'BD_datos_salida256.txt')
                    
                end     
                
                if server_1.buffer_out==512
                    
                    FINAL='00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
                    
                    dato512=uint16([CONF1_INT,CONF1_DEC,K1_INT,K1_DEC,ALFA1_INT,ALFA1_DEC,B1_INT,B1_DEC,PS1_INT,PS1_DEC,TMS1_INT,TMS1_DEC,TINS1_INT,TINS1_DEC,ESC1_INT,ESC1_DEC,CONF2_INT,CONF2_DEC,K2_INT,K2_DEC,ALFA2_INT,ALFA2_DEC,B2_INT,B2_DEC,PS2_INT,PS2_DEC,TMS2_INT,TMS2_DEC,TINS2_INT,TINS2_DEC,ESC2_INT,ESC2_DEC,CONF3_INT,CONF3_DEC,K3_INT,K3_DEC,ALFA3_INT,ALFA3_DEC,B3_INT,B3_DEC,PS3_INT,PS3_DEC,TMS3_INT,TMS3_DEC,TINS3_INT,TINS3_DEC,ESC3_INT,ESC3_DEC,CONF4_INT,CONF4_DEC,K4_INT,K4_DEC,ALFA4_INT,ALFA4_DEC,B4_INT,B4_DEC,PS4_INT,PS4_DEC,TMS4_INT,TMS4_DEC,TINS4_INT,TINS4_DEC,ESC4_INT,ESC4_DEC,CONF5_INT,CONF5_DEC,K5_INT,K5_DEC,ALFA5_INT,ALFA5_DEC,B5_INT,B5_DEC,PS5_INT,PS5_DEC,TMS5_INT,TMS5_DEC,TINS5_INT,TINS5_DEC,ESC5_INT,ESC5_DEC,FINAL]);
                    server_1.dato_escritura=dato512;
                    
                    % Operación de escritura de datos hacía el cliente
                    escritura_datos_n(server_1,server_1.dato_escritura)
                    
                    % Grabación en BD
                    grabar_datos_salida_512(server_1,'BD_datos_salida512.txt')
                    
                end
                
                if server_1.buffer_out==1024
                    
                    FINAL='000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
                    
                    dato1024=uint16([CONF1_INT,CONF1_DEC,K1_INT,K1_DEC,ALFA1_INT,ALFA1_DEC,B1_INT,B1_DEC,PS1_INT,PS1_DEC,TMS1_INT,TMS1_DEC,TINS1_INT,TINS1_DEC,ESC1_INT,ESC1_DEC,CONF2_INT,CONF2_DEC,K2_INT,K2_DEC,ALFA2_INT,ALFA2_DEC,B2_INT,B2_DEC,PS2_INT,PS2_DEC,TMS2_INT,TMS2_DEC,TINS2_INT,TINS2_DEC,ESC2_INT,ESC2_DEC,CONF3_INT,CONF3_DEC,K3_INT,K3_DEC,ALFA3_INT,ALFA3_DEC,B3_INT,B3_DEC,PS3_INT,PS3_DEC,TMS3_INT,TMS3_DEC,TINS3_INT,TINS3_DEC,ESC3_INT,ESC3_DEC,CONF4_INT,CONF4_DEC,K4_INT,K4_DEC,ALFA4_INT,ALFA4_DEC,B4_INT,B4_DEC,PS4_INT,PS4_DEC,TMS4_INT,TMS4_DEC,TINS4_INT,TINS4_DEC,ESC4_INT,ESC4_DEC,CONF5_INT,CONF5_DEC,K5_INT,K5_DEC,ALFA5_INT,ALFA5_DEC,B5_INT,B5_DEC,PS5_INT,PS5_DEC,TMS5_INT,TMS5_DEC,TINS5_INT,TINS5_DEC,ESC5_INT,ESC5_DEC,FINAL]);
                    server_1.dato_escritura=dato1024;
                    
                    % Operación de escritura de datos hacía el cliente
                    escritura_datos_n(server_1,server_1.dato_escritura)
                    
                    % Grabación en BD
                    grabar_datos_salida_1024(server_1,'BD_datos_salida1024.txt')
                    
                end
                
                if server_1.buffer_out==2048
                    
                    FINAL='00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
                    
                    dato2048=uint16([CONF1_INT,CONF1_DEC,K1_INT,K1_DEC,ALFA1_INT,ALFA1_DEC,B1_INT,B1_DEC,PS1_INT,PS1_DEC,TMS1_INT,TMS1_DEC,TINS1_INT,TINS1_DEC,ESC1_INT,ESC1_DEC,CONF2_INT,CONF2_DEC,K2_INT,K2_DEC,ALFA2_INT,ALFA2_DEC,B2_INT,B2_DEC,PS2_INT,PS2_DEC,TMS2_INT,TMS2_DEC,TINS2_INT,TINS2_DEC,ESC2_INT,ESC2_DEC,CONF3_INT,CONF3_DEC,K3_INT,K3_DEC,ALFA3_INT,ALFA3_DEC,B3_INT,B3_DEC,PS3_INT,PS3_DEC,TMS3_INT,TMS3_DEC,TINS3_INT,TINS3_DEC,ESC3_INT,ESC3_DEC,CONF4_INT,CONF4_DEC,K4_INT,K4_DEC,ALFA4_INT,ALFA4_DEC,B4_INT,B4_DEC,PS4_INT,PS4_DEC,TMS4_INT,TMS4_DEC,TINS4_INT,TINS4_DEC,ESC4_INT,ESC4_DEC,CONF5_INT,CONF5_DEC,K5_INT,K5_DEC,ALFA5_INT,ALFA5_DEC,B5_INT,B5_DEC,PS5_INT,PS5_DEC,TMS5_INT,TMS5_DEC,TINS5_INT,TINS5_DEC,ESC5_INT,ESC5_DEC,FINAL]);
                    server_1.dato_escritura=dato2048;
                    
                    % Operación de escritura de datos hacía el cliente
                    escritura_datos_n(server_1,server_1.dato_escritura)
                    
                    % Grabación en BD
                    grabar_datos_salida_2048(server_1,'BD_datos_salida2048.txt')
                    
                end  
                
                if server_1.buffer_out==4096
                    
                    FINAL='000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
                    
                    dato4096=uint16([CONF1_INT,CONF1_DEC,K1_INT,K1_DEC,ALFA1_INT,ALFA1_DEC,B1_INT,B1_DEC,PS1_INT,PS1_DEC,TMS1_INT,TMS1_DEC,TINS1_INT,TINS1_DEC,ESC1_INT,ESC1_DEC,CONF2_INT,CONF2_DEC,K2_INT,K2_DEC,ALFA2_INT,ALFA2_DEC,B2_INT,B2_DEC,PS2_INT,PS2_DEC,TMS2_INT,TMS2_DEC,TINS2_INT,TINS2_DEC,ESC2_INT,ESC2_DEC,CONF3_INT,CONF3_DEC,K3_INT,K3_DEC,ALFA3_INT,ALFA3_DEC,B3_INT,B3_DEC,PS3_INT,PS3_DEC,TMS3_INT,TMS3_DEC,TINS3_INT,TINS3_DEC,ESC3_INT,ESC3_DEC,CONF4_INT,CONF4_DEC,K4_INT,K4_DEC,ALFA4_INT,ALFA4_DEC,B4_INT,B4_DEC,PS4_INT,PS4_DEC,TMS4_INT,TMS4_DEC,TINS4_INT,TINS4_DEC,ESC4_INT,ESC4_DEC,CONF5_INT,CONF5_DEC,K5_INT,K5_DEC,ALFA5_INT,ALFA5_DEC,B5_INT,B5_DEC,PS5_INT,PS5_DEC,TMS5_INT,TMS5_DEC,TINS5_INT,TINS5_DEC,ESC5_INT,ESC5_DEC,FINAL]);
                    server_1.dato_escritura=dato4096;
                    
                    % Operación de escritura de datos hacía el cliente
                    escritura_datos_n(server_1,server_1.dato_escritura)
                    
                    % Grabación en BD
                    grabar_datos_salida_4096(server_1,'BD_datos_salida4096.txt')
                    
                end            
                
            end
        end
    end
end
