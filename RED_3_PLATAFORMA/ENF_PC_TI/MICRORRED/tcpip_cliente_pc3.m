classdef tcpip_cliente_pc3
    properties
        %Propiedades que cambian solo con fclose(obj)
        ip
        puerto
        rol
        buffer_in
        buffer_out
        obj_tcpip
        %Propiedad que se puede cambiar en cualquier momento
        tiempo
        %Propiedades de lectura que se actualizan
        dato_lectura
        dato_escritura
        estado_comunicacion
        estado_transferencia
        no_val_recibidos
        no_val_enviados
        %Lectura Base de Datos
        BD_leida
        ultimo_dato_lectura
        ultimo_dato_escritura
    end
    methods
        function t= hacer_com(obj)
            t = tcpip(obj.ip, obj.puerto, 'NetworkRole', obj.rol);
            t.Timeout=obj.tiempo;
            t.InputBufferSize=obj.buffer_in;
            t.OutputBufferSize=obj.buffer_out;
        end
        
        function abrir_comunicacion(obj)
            fopen(obj.obj_tcpip);
        end
        
        function terminar_comunicacion(obj)
            fclose(obj.obj_tcpip);
        end
        
        % Operación de lectura server_1 - S: 2B - C:nB
        function l=lectura_datos_2(obj)
            l=fread(obj.obj_tcpip,1,'uint16');
        end
        
        % Operación de lectura server_1 - S: 1B - C:nB
        function l=lectura_datos_1(obj)
            l=fread(obj.obj_tcpip);
        end
        
        % Operación de escritura server_1 - S: 2B - C:nB
        function escritura_datos_n(obj,d)
            fwrite(obj.obj_tcpip,d,'uint16');
        end
        
        % Operación de escritura server_1 - S: 2B - C:nB
        function escritura_datos_1(obj,d)
            fwrite(obj.obj_tcpip,d,'uint8');
        end
        
        function [st_com, st_trans, no_val_recibidos, no_val_enviados]=actualizacion_informacion(obj)
            st_com=obj.obj_tcpip.Status;
            st_trans=obj.obj_tcpip.TransferStatus;
            no_val_recibidos=obj.obj_tcpip.ValuesReceived;
            no_val_enviados= obj.obj_tcpip.ValuesSent;
        end
        
        % Función para grabar los datos de llegada desde el servidor
        
        function grabar_datos_llegada_1(obj,nombre_bd)
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_lectura);
            fclose(base_datos);
        end
        
        function grabar_datos_llegada_2(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_lectura)==1
                obj.dato_lectura=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_lectura);
            fclose(base_datos);
        end
        
        % Funciones para grabar los datos de salida al servidor
        
        function grabar_datos_salida_1(obj,nombre_bd)
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(1));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_3(obj,nombre_bd)
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d %d %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(1),obj.dato_escritura(2),obj.dato_escritura(3));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_4(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_escritura)==1
                obj.dato_escritura(1)=999;
                obj.dato_escritura(2)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(1),obj.dato_escritura(2));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_8(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_escritura)==1
                obj.dato_escritura(1)=999;
                obj.dato_escritura(3)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(1),obj.dato_escritura(3));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_16(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_escritura)==1
                obj.dato_escritura(3)=999;
                obj.dato_escritura(7)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(3),obj.dato_escritura(7));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_32(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_escritura)==1
                obj.dato_escritura(7)=999;
                obj.dato_escritura(15)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(7),obj.dato_escritura(15));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_64(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_escritura)==1
                obj.dato_escritura(15)=999;
                obj.dato_escritura(31)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(15),obj.dato_escritura(31));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_128(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_escritura)==1
                obj.dato_escritura(15)=999;
                obj.dato_escritura(31)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(15),obj.dato_escritura(31));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_256(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_escritura)==1
                obj.dato_escritura(15)=999;
                obj.dato_escritura(31)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(15),obj.dato_escritura(31));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_512(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_escritura)==1
                obj.dato_escritura(15)=999;
                obj.dato_escritura(31)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(15),obj.dato_escritura(31));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_1024(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_escritura)==1
                obj.dato_escritura(15)=999;
                obj.dato_escritura(31)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %d %d\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(15),obj.dato_escritura(31));
            fclose(base_datos);
        end
        
        %Función para calcular el tiempo del ciclo de comunicación
        function [puerto,e]=duracion(obj,nombre_bd_salida,nombre_bd_entrada)
            base_datos1 = fopen(nombre_bd_salida,'r');
            A = textscan(base_datos1,'%f %f %f %f %f %f %s %d %d %d');
            fclose(base_datos1);
            
            ti=[A{1,1}(length(A{1,1})) A{1,2}(length(A{1,2})) A{1,3}(length(A{1,3})) A{1,4}(length(A{1,4})) A{1,5}(length(A{1,5})) A{1,6}(length(A{1,6}))];
            
            base_datos2 = fopen(nombre_bd_entrada,'r');
            B = textscan(base_datos1,'%f %f %f %f %f %f %s %d');
            fclose(base_datos2);
            tf=[B{1,1}(length(B{1,1})) B{1,2}(length(B{1,2})) B{1,3}(length(B{1,3})) B{1,4}(length(B{1,4})) B{1,5}(length(B{1,5})) B{1,6}(length(B{1,6}))];
            
            e = etime(tf,ti);
            puerto=obj.puerto;
        end
        
    end
end
