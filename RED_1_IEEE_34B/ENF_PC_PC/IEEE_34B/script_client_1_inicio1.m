
%% Crear objeto

client_1 = tcpip_cliente_pc1;

%% Cargar valores de propiedades de acceso

client_1.ip='192.168.0.15'; % Dirección IPv4 del host remoto
client_1.puerto=30000;      % Puerto del host remoto (Int: 1 - 65535)
client_1.rol='client';      % Rol del host ('server' o 'client')
client_1.tiempo=1;          % iempo de espera para completar operaciones
client_1.buffer_in=512;      % Buffer entrada en Bytes  
client_1.buffer_out=6;    % Buffer salida en Bytes               

%% Llamar métodos

% Crear objeto de comunicación
client_1.obj_tcpip=hacer_com(client_1);

% Abrir comunicación
abrir_comunicacion(client_1)
