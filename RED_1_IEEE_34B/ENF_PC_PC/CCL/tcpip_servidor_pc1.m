classdef tcpip_servidor_pc1
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
        
        % Operación de lectura server_1 - S: 2B - C:2B
        function l=lectura_datos_2(obj)
            l=fread(obj.obj_tcpip,1,'uint16');
        end
        
        % Operación de lectura server_1 - S: 2B - C:4B
        function l=lectura_datos_4(obj)
            l=fread(obj.obj_tcpip,2,'uint16');
        end
        
        % Operación de lectura server_1 - S: 2B - C:6B
        function l=lectura_datos_6(obj)
            l=fread(obj.obj_tcpip,3,'uint16');
        end
        
        % Operación de lectura server_1 - S: 2B - C:8B
        function l=lectura_datos_8(obj)
            l=fread(obj.obj_tcpip,4,'uint16');
        end
        
        % Operación de lectura server_1 - S: 2B - C:16B
        function l=lectura_datos_16(obj)
            l=fread(obj.obj_tcpip,8,'uint16');
        end
        
        % Operación de lectura server_1 - S: 2B - C:32B
        function l=lectura_datos_32(obj)
            l=fread(obj.obj_tcpip,16,'uint16');
        end
        
        % Operación de lectura server_1 - S: 2B - C:64B
        function l=lectura_datos_64(obj)
            l=fread(obj.obj_tcpip,32,'uint16');
        end
        
        % Operación de lectura server_1 - S: 2B - C:128B
        function l=lectura_datos_128(obj)
            l=fread(obj.obj_tcpip,64,'uint16');
        end
        
        % Operación de lectura server_1 - S: 2B - C:256B
        function l=lectura_datos_256(obj)
            l=fread(obj.obj_tcpip,128,'uint16');
        end
        
        % Operación de lectura server_1 - S: 2B - C:512B
        function l=lectura_datos_512(obj)
            l=fread(obj.obj_tcpip,256,'uint16');
        end
        
        % Operación de lectura server_1 - S: 2B - C:1024B
        function l=lectura_datos_1024(obj)
            l=fread(obj.obj_tcpip,512,'uint16');
        end
        
        % Operación de escritura server_1 - S: 2B - C:nB
        function escritura_datos_2(obj,d)
            fwrite(obj.obj_tcpip,d,'uint16');
        end
        
        % Operación de escritura server_1 - S: 2B - C:nB
        function escritura_datos_n(obj,d)
            fwrite(obj.obj_tcpip,d,'uint16');
        end
        
        % Actualización datos de la comunicación
        function [st_com, st_trans]=actualizacion_informacion(obj)
            st_com=obj.obj_tcpip.Status;
            st_trans=obj.obj_tcpip.TransferStatus;
        end
        
        % Organización de los datos de lectura - S: 2B - C:2B
        function dato1=arreglo_datos_s2_c2(obj)
            dato1=obj.dato_lectura;
        end
        
        % Organización de los datos de lectura - S: 2B - C:4B
        function [dato1, dato2]=arreglo_datos_s2_c4(obj)
            dato1=obj.dato_lectura(1);
            dato2=obj.dato_lectura(2);
        end
        
        % Organización de los datos de lectura - S: 2B - C:6B
        function [dato1, dato2, dato3]=arreglo_datos_s2_c6(obj)
            dato1=obj.dato_lectura(1);
            dato2=obj.dato_lectura(2);
            dato3=obj.dato_lectura(3);
        end
        
        % Organización de los datos de lectura - S: 2B - C:8B
        function [dato1, dato2]=arreglo_datos_s2_c8(obj)
            dato1=obj.dato_lectura(1)+(obj.dato_lectura(2))/1e4;
            dato2=obj.dato_lectura(3)+(obj.dato_lectura(4))/1e4;
        end
        
        % Organización de los datos de lectura - S: 2B - C:16B
        function [d1, d2, d3, d4]=arreglo_datos_s2_c16(obj)
            d1=convertCharsToStrings(char(obj.dato_lectura(1:2)));
            d2=obj.dato_lectura(3)+(obj.dato_lectura(4))/1e4;
            d3=convertCharsToStrings(char(obj.dato_lectura(5:6)));
            d4=obj.dato_lectura(7)+(obj.dato_lectura(8))/1e4;
        end
        
        % Organización de los datos de lectura - S: 2B - C:32B
        function [d1, d2, d3, d4]=arreglo_datos_s2_c32(obj)
            d1=convertCharsToStrings(char(obj.dato_lectura(1:6)));
            d2=obj.dato_lectura(7)+(obj.dato_lectura(8))/1e4;
            d3=convertCharsToStrings(char(obj.dato_lectura(9:14)));
            d4=obj.dato_lectura(15)+(obj.dato_lectura(16))/1e4;
        end
        
        % Organización de los datos de lectura - S: 2B - C:64B
        function [d1, d2, d3, d4, d5, d6]=arreglo_datos_s2_c64(obj)
            d1=convertCharsToStrings(char(obj.dato_lectura(1:8)));
            d2=convertCharsToStrings(char(obj.dato_lectura(9:14)));
            d3=obj.dato_lectura(15)+(obj.dato_lectura(16))/1e4;
            d4=convertCharsToStrings(char(obj.dato_lectura(17:24)));
            d5=convertCharsToStrings(char(obj.dato_lectura(25:30)));
            d6=obj.dato_lectura(31)+(obj.dato_lectura(32))/1e4;
        end
        
        % Organización de los datos de lectura - S: 2B - C:128B
        function [d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12]=arreglo_datos_s2_c128(obj)
            d1=convertCharsToStrings(char(obj.dato_lectura(1:8)));
            d2=convertCharsToStrings(char(obj.dato_lectura(9:14)));
            d3=obj.dato_lectura(15)+(obj.dato_lectura(16))/1e4;
            d4=convertCharsToStrings(char(obj.dato_lectura(17:24)));
            d5=convertCharsToStrings(char(obj.dato_lectura(25:30)));
            d6=obj.dato_lectura(31)+(obj.dato_lectura(32))/1e4;
            d7=convertCharsToStrings(char(obj.dato_lectura(33:35)));
            d8=convertCharsToStrings(char(obj.dato_lectura(36:43)));
            d9=convertCharsToStrings(char(obj.dato_lectura(44:52)));
            d10=obj.dato_lectura(53);
            d11=convertCharsToStrings(char(obj.dato_lectura(54:63)));
            d12=obj.dato_lectura(64);
        end
        
        % Organización de los datos de lectura - S: 2B - C:256B
        function [d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16]=arreglo_datos_s2_c256(obj)
            d1=convertCharsToStrings(char(obj.dato_lectura(1:8)));
            d2=convertCharsToStrings(char(obj.dato_lectura(9:14)));
            d3=obj.dato_lectura(15)+(obj.dato_lectura(16))/1e4;
            d4=convertCharsToStrings(char(obj.dato_lectura(17:24)));
            d5=convertCharsToStrings(char(obj.dato_lectura(25:30)));
            d6=obj.dato_lectura(31)+(obj.dato_lectura(32))/1e4;
            d7=convertCharsToStrings(char(obj.dato_lectura(33:35)));
            d8=convertCharsToStrings(char(obj.dato_lectura(36:43)));
            d9=convertCharsToStrings(char(obj.dato_lectura(44:52)));
            d10=obj.dato_lectura(53);
            d11=convertCharsToStrings(char(obj.dato_lectura(54:63)));
            d12=obj.dato_lectura(64);
            d13=convertCharsToStrings(char(obj.dato_lectura(65:81)));
            d14=convertCharsToStrings(char(obj.dato_lectura(82:104)));
            d15=convertCharsToStrings(char(obj.dato_lectura(105:116)));
            d16=convertCharsToStrings(char(obj.dato_lectura(117:128)));
        end
        
        % Organización de los datos de lectura - S: 2B - C:512B
        function [d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23,d24]=arreglo_datos_s2_c512(obj)
            d1=convertCharsToStrings(char(obj.dato_lectura(1:8)));
            d2=convertCharsToStrings(char(obj.dato_lectura(9:14)));
            d3=obj.dato_lectura(15)+(obj.dato_lectura(16))/1e4;
            d4=convertCharsToStrings(char(obj.dato_lectura(17:24)));
            d5=convertCharsToStrings(char(obj.dato_lectura(25:30)));
            d6=obj.dato_lectura(31)+(obj.dato_lectura(32))/1e4;
            d7=convertCharsToStrings(char(obj.dato_lectura(33:35)));
            d8=convertCharsToStrings(char(obj.dato_lectura(36:43)));
            d9=convertCharsToStrings(char(obj.dato_lectura(44:52)));
            d10=obj.dato_lectura(53);
            d11=convertCharsToStrings(char(obj.dato_lectura(54:63)));
            d12=obj.dato_lectura(64);
            d13=convertCharsToStrings(char(obj.dato_lectura(65:81)));
            d14=convertCharsToStrings(char(obj.dato_lectura(82:104)));
            d15=convertCharsToStrings(char(obj.dato_lectura(105:116)));
            d16=convertCharsToStrings(char(obj.dato_lectura(117:128)));
            d17=convertCharsToStrings(char(obj.dato_lectura(129:171)));
            d18=obj.dato_lectura(172);
            d19=convertCharsToStrings(char(obj.dato_lectura(173:197)));
            d20=convertCharsToStrings(char(obj.dato_lectura(198:201)));
            d21=convertCharsToStrings(char(obj.dato_lectura(202:236)));
            d22=convertCharsToStrings(char(obj.dato_lectura(237:240)));
            d23=convertCharsToStrings(char(obj.dato_lectura(241:255)));
            d24=obj.dato_lectura(256);
        end
        
        % Organización de los datos de lectura - S: 2B - C:1024B
        function [d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23,d24,d25,d26,d27,d28,d29,d30,d31,d32,d33,d34,d35,d36,d37,d38,d39,d40,d41,d42,d43,d44,d45,d46,d47,d48,d49,d50,d51,d52,d53,d54,d55,d56,d57,d58]=arreglo_datos_s2_c1024(obj)
            d1=convertCharsToStrings(char(obj.dato_lectura(1:8)));
            d2=convertCharsToStrings(char(obj.dato_lectura(9:14)));
            d3=obj.dato_lectura(15)+(obj.dato_lectura(16))/1e4;
            d4=convertCharsToStrings(char(obj.dato_lectura(17:24)));
            d5=convertCharsToStrings(char(obj.dato_lectura(25:30)));
            d6=obj.dato_lectura(31)+(obj.dato_lectura(32))/1e4;
            d7=convertCharsToStrings(char(obj.dato_lectura(33:35)));
            d8=convertCharsToStrings(char(obj.dato_lectura(36:43)));
            d9=convertCharsToStrings(char(obj.dato_lectura(44:52)));
            d10=obj.dato_lectura(53);
            d11=convertCharsToStrings(char(obj.dato_lectura(54:63)));
            d12=obj.dato_lectura(64);
            d13=convertCharsToStrings(char(obj.dato_lectura(65:81)));
            d14=convertCharsToStrings(char(obj.dato_lectura(82:104)));
            d15=convertCharsToStrings(char(obj.dato_lectura(105:116)));
            d16=convertCharsToStrings(char(obj.dato_lectura(117:128)));
            d17=convertCharsToStrings(char(obj.dato_lectura(129:171)));
            d18=obj.dato_lectura(172);
            d19=convertCharsToStrings(char(obj.dato_lectura(173:197)));
            d20=convertCharsToStrings(char(obj.dato_lectura(198:201)));
            d21=convertCharsToStrings(char(obj.dato_lectura(202:236)));
            d22=convertCharsToStrings(char(obj.dato_lectura(237:240)));
            d23=convertCharsToStrings(char(obj.dato_lectura(241:255)));
            d24=obj.dato_lectura(256);
            d25=convertCharsToStrings(char(obj.dato_lectura(257:290)));
            d26=convertCharsToStrings(char(obj.dato_lectura(291:294)));
            d27=convertCharsToStrings(char(obj.dato_lectura(295:305)));
            d28=obj.dato_lectura(306);
            d29=convertCharsToStrings(char(obj.dato_lectura(307:319)));
            d30=obj.dato_lectura(320);
            d31=convertCharsToStrings(char(obj.dato_lectura(321)));
            d32=obj.dato_lectura(322);
            d33=convertCharsToStrings(char(obj.dato_lectura(323:344)));
            d34=obj.dato_lectura(345);
            d35=convertCharsToStrings(char(obj.dato_lectura(346:363)));
            d36=obj.dato_lectura(364);
            d37=convertCharsToStrings(char(obj.dato_lectura(365:368)));
            d38=convertCharsToStrings(char(obj.dato_lectura(369:379)));
            d39=obj.dato_lectura(380);
            d40=convertCharsToStrings(char(obj.dato_lectura(381:393)));
            d41=obj.dato_lectura(394);
            d42=convertCharsToStrings(char(obj.dato_lectura(395)));
            d43=obj.dato_lectura(396);
            d44=convertCharsToStrings(char(obj.dato_lectura(397:418)));
            d45=obj.dato_lectura(419);
            d46=convertCharsToStrings(char(obj.dato_lectura(420:437)));
            d47=obj.dato_lectura(438);
            d48=convertCharsToStrings(char(obj.dato_lectura(439:442)));
            d49=convertCharsToStrings(char(obj.dato_lectura(443:453)));
            d50=obj.dato_lectura(454);
            d51=convertCharsToStrings(char(obj.dato_lectura(455:467)));
            d52=obj.dato_lectura(468);
            d53=convertCharsToStrings(char(obj.dato_lectura(469)));
            d54=obj.dato_lectura(470);
            d55=convertCharsToStrings(char(obj.dato_lectura(471:492)));
            d56=obj.dato_lectura(493);
            d57=convertCharsToStrings(char(obj.dato_lectura(494:511)));
            d58=obj.dato_lectura(512);
        end
                
        % Funciones para grabar los datos de llegada al servidor
        
        function grabar_datos_llegada_2(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_lectura)==1
                obj.dato_lectura=999;               
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%s %s %d\n',datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS'),obj.rol,obj.dato_lectura);
            fclose(base_datos);
        end
        
        function grabar_datos_llegada_4(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_lectura)==1
                obj.dato_lectura(1)=999;
                obj.dato_lectura(2)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%s %s %d %d\n',datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS'),obj.rol,obj.dato_lectura(1),obj.dato_lectura(2));
            fclose(base_datos);
        end
        
        function grabar_datos_llegada_6(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_lectura)==1
                obj.dato_lectura(1)=999;
                obj.dato_lectura(2)=999;
                obj.dato_lectura(3)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%s %s %d %d %d\n',datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS'),obj.rol,obj.dato_lectura(1),obj.dato_lectura(2), obj.dato_lectura(3));
            fclose(base_datos);
        end
           
        function grabar_datos_llegada_8(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_lectura)==1
                obj.dato_lectura(1)=999;
                obj.dato_lectura(2)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%s %s %d %d\n',datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS'),obj.rol,obj.dato_lectura(1),obj.dato_lectura(2));
            fclose(base_datos);
        end
        
        function grabar_datos_llegada_16(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_lectura)==1
                obj.dato_lectura(2)=999;
                obj.dato_lectura(4)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%s %s %s %s\n',datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS'),obj.rol,obj.dato_lectura(2),obj.dato_lectura(4));
            fclose(base_datos);
        end
        
        function grabar_datos_llegada_32(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_lectura)==1
                obj.dato_lectura(2)=999;
                obj.dato_lectura(4)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%s %s %s %s\n',datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS'),obj.rol,obj.dato_lectura(2),obj.dato_lectura(4));
            fclose(base_datos);
        end
        
        function grabar_datos_llegada_64(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_lectura)==1
                obj.dato_lectura(3)=999;
                obj.dato_lectura(6)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%s %s %s %s\n',datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS'),obj.rol,obj.dato_lectura(3),obj.dato_lectura(6));
            fclose(base_datos);
        end
        
        function grabar_datos_llegada_128(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_lectura)==1
                obj.dato_lectura(3)=999;
                obj.dato_lectura(6)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%s %s %s %s\n',datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS'),obj.rol,obj.dato_lectura(3),obj.dato_lectura(6));
            fclose(base_datos);
        end
        
        function grabar_datos_llegada_256(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_lectura)==1
                obj.dato_lectura(3)=999;
                obj.dato_lectura(6)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%s %s %s %s\n',datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS'),obj.rol,obj.dato_lectura(3),obj.dato_lectura(6));
            fclose(base_datos);
        end
        
        function grabar_datos_llegada_512(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_lectura)==1
                obj.dato_lectura(3)=999;
                obj.dato_lectura(6)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%s %s %s %s\n',datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS'),obj.rol,obj.dato_lectura(3),obj.dato_lectura(6));
            fclose(base_datos);
        end
        
        function grabar_datos_llegada_1024(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_lectura)==1
                obj.dato_lectura(3)=999;
                obj.dato_lectura(6)=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%s %s %s %s\n',datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS'),obj.rol,obj.dato_lectura(3),obj.dato_lectura(6));
            fclose(base_datos);
        end
        
        % Función para grabar los datos de salida desde el servidor
        
        function grabar_datos_salida_2(obj,nombre_bd)
            % Ciclo para preguntar por escritura y lectura vacía
            if isempty(obj.dato_escritura)==1
                obj.dato_lectura=999;
            end
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%s %s %d \n',datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS'),obj.rol,obj.dato_escritura);
            fclose(base_datos);
        end
         
        function grabar_datos_salida_170(obj,nombre_bd)
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(1),obj.dato_escritura(2),obj.dato_escritura(3),obj.dato_escritura(4),obj.dato_escritura(5),obj.dato_escritura(6),obj.dato_escritura(7),obj.dato_escritura(8),obj.dato_escritura(9),obj.dato_escritura(10),obj.dato_escritura(11),obj.dato_escritura(12),obj.dato_escritura(13),obj.dato_escritura(14),obj.dato_escritura(15),obj.dato_escritura(16),obj.dato_escritura(17),obj.dato_escritura(18),obj.dato_escritura(19),obj.dato_escritura(20),obj.dato_escritura(21),obj.dato_escritura(22),obj.dato_escritura(23),obj.dato_escritura(24),obj.dato_escritura(25),obj.dato_escritura(26),obj.dato_escritura(27),obj.dato_escritura(28),obj.dato_escritura(29),obj.dato_escritura(30),obj.dato_escritura(31),obj.dato_escritura(32),obj.dato_escritura(33),obj.dato_escritura(34),obj.dato_escritura(35),obj.dato_escritura(36),obj.dato_escritura(37),obj.dato_escritura(38),obj.dato_escritura(39),obj.dato_escritura(40),obj.dato_escritura(41),obj.dato_escritura(42),obj.dato_escritura(43),obj.dato_escritura(44),obj.dato_escritura(45),obj.dato_escritura(46),obj.dato_escritura(47),obj.dato_escritura(48),obj.dato_escritura(49),obj.dato_escritura(50),obj.dato_escritura(51),obj.dato_escritura(52),obj.dato_escritura(53),obj.dato_escritura(54),obj.dato_escritura(55),obj.dato_escritura(56),obj.dato_escritura(57),obj.dato_escritura(58),obj.dato_escritura(59),obj.dato_escritura(60),obj.dato_escritura(61),obj.dato_escritura(62),obj.dato_escritura(63),obj.dato_escritura(64),obj.dato_escritura(65),obj.dato_escritura(66),obj.dato_escritura(67),obj.dato_escritura(68),obj.dato_escritura(69),obj.dato_escritura(70),obj.dato_escritura(71),obj.dato_escritura(72),obj.dato_escritura(73),obj.dato_escritura(74),obj.dato_escritura(75),obj.dato_escritura(76),obj.dato_escritura(77),obj.dato_escritura(78),obj.dato_escritura(79),obj.dato_escritura(80),char(obj.dato_escritura(81:85)));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_190(obj,nombre_bd)
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(1),obj.dato_escritura(2),obj.dato_escritura(3),obj.dato_escritura(4),obj.dato_escritura(5),obj.dato_escritura(6),obj.dato_escritura(7),obj.dato_escritura(8),obj.dato_escritura(9),obj.dato_escritura(10),obj.dato_escritura(11),obj.dato_escritura(12),obj.dato_escritura(13),obj.dato_escritura(14),obj.dato_escritura(15),obj.dato_escritura(16),obj.dato_escritura(17),obj.dato_escritura(18),obj.dato_escritura(19),obj.dato_escritura(20),obj.dato_escritura(21),obj.dato_escritura(22),obj.dato_escritura(23),obj.dato_escritura(24),obj.dato_escritura(25),obj.dato_escritura(26),obj.dato_escritura(27),obj.dato_escritura(28),obj.dato_escritura(29),obj.dato_escritura(30),obj.dato_escritura(31),obj.dato_escritura(32),obj.dato_escritura(33),obj.dato_escritura(34),obj.dato_escritura(35),obj.dato_escritura(36),obj.dato_escritura(37),obj.dato_escritura(38),obj.dato_escritura(39),obj.dato_escritura(40),obj.dato_escritura(41),obj.dato_escritura(42),obj.dato_escritura(43),obj.dato_escritura(44),obj.dato_escritura(45),obj.dato_escritura(46),obj.dato_escritura(47),obj.dato_escritura(48),obj.dato_escritura(49),obj.dato_escritura(50),obj.dato_escritura(51),obj.dato_escritura(52),obj.dato_escritura(53),obj.dato_escritura(54),obj.dato_escritura(55),obj.dato_escritura(56),obj.dato_escritura(57),obj.dato_escritura(58),obj.dato_escritura(59),obj.dato_escritura(60),obj.dato_escritura(61),obj.dato_escritura(62),obj.dato_escritura(63),obj.dato_escritura(64),obj.dato_escritura(65),obj.dato_escritura(66),obj.dato_escritura(67),obj.dato_escritura(68),obj.dato_escritura(69),obj.dato_escritura(70),obj.dato_escritura(71),obj.dato_escritura(72),obj.dato_escritura(73),obj.dato_escritura(74),obj.dato_escritura(75),obj.dato_escritura(76),obj.dato_escritura(77),obj.dato_escritura(78),obj.dato_escritura(79),obj.dato_escritura(80),char(obj.dato_escritura(81:95)));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_256(obj,nombre_bd)
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(1),obj.dato_escritura(2),obj.dato_escritura(3),obj.dato_escritura(4),obj.dato_escritura(5),obj.dato_escritura(6),obj.dato_escritura(7),obj.dato_escritura(8),obj.dato_escritura(9),obj.dato_escritura(10),obj.dato_escritura(11),obj.dato_escritura(12),obj.dato_escritura(13),obj.dato_escritura(14),obj.dato_escritura(15),obj.dato_escritura(16),obj.dato_escritura(17),obj.dato_escritura(18),obj.dato_escritura(19),obj.dato_escritura(20),obj.dato_escritura(21),obj.dato_escritura(22),obj.dato_escritura(23),obj.dato_escritura(24),obj.dato_escritura(25),obj.dato_escritura(26),obj.dato_escritura(27),obj.dato_escritura(28),obj.dato_escritura(29),obj.dato_escritura(30),obj.dato_escritura(31),obj.dato_escritura(32),obj.dato_escritura(33),obj.dato_escritura(34),obj.dato_escritura(35),obj.dato_escritura(36),obj.dato_escritura(37),obj.dato_escritura(38),obj.dato_escritura(39),obj.dato_escritura(40),obj.dato_escritura(41),obj.dato_escritura(42),obj.dato_escritura(43),obj.dato_escritura(44),obj.dato_escritura(45),obj.dato_escritura(46),obj.dato_escritura(47),obj.dato_escritura(48),obj.dato_escritura(49),obj.dato_escritura(50),obj.dato_escritura(51),obj.dato_escritura(52),obj.dato_escritura(53),obj.dato_escritura(54),obj.dato_escritura(55),obj.dato_escritura(56),obj.dato_escritura(57),obj.dato_escritura(58),obj.dato_escritura(59),obj.dato_escritura(60),obj.dato_escritura(61),obj.dato_escritura(62),obj.dato_escritura(63),obj.dato_escritura(64),obj.dato_escritura(65),obj.dato_escritura(66),obj.dato_escritura(67),obj.dato_escritura(68),obj.dato_escritura(69),obj.dato_escritura(70),obj.dato_escritura(71),obj.dato_escritura(72),obj.dato_escritura(73),obj.dato_escritura(74),obj.dato_escritura(75),obj.dato_escritura(76),obj.dato_escritura(77),obj.dato_escritura(78),obj.dato_escritura(79),obj.dato_escritura(80),char(obj.dato_escritura(81:128)));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_512(obj,nombre_bd)
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(1),obj.dato_escritura(2),obj.dato_escritura(3),obj.dato_escritura(4),obj.dato_escritura(5),obj.dato_escritura(6),obj.dato_escritura(7),obj.dato_escritura(8),obj.dato_escritura(9),obj.dato_escritura(10),obj.dato_escritura(11),obj.dato_escritura(12),obj.dato_escritura(13),obj.dato_escritura(14),obj.dato_escritura(15),obj.dato_escritura(16),obj.dato_escritura(17),obj.dato_escritura(18),obj.dato_escritura(19),obj.dato_escritura(20),obj.dato_escritura(21),obj.dato_escritura(22),obj.dato_escritura(23),obj.dato_escritura(24),obj.dato_escritura(25),obj.dato_escritura(26),obj.dato_escritura(27),obj.dato_escritura(28),obj.dato_escritura(29),obj.dato_escritura(30),obj.dato_escritura(31),obj.dato_escritura(32),obj.dato_escritura(33),obj.dato_escritura(34),obj.dato_escritura(35),obj.dato_escritura(36),obj.dato_escritura(37),obj.dato_escritura(38),obj.dato_escritura(39),obj.dato_escritura(40),obj.dato_escritura(41),obj.dato_escritura(42),obj.dato_escritura(43),obj.dato_escritura(44),obj.dato_escritura(45),obj.dato_escritura(46),obj.dato_escritura(47),obj.dato_escritura(48),obj.dato_escritura(49),obj.dato_escritura(50),obj.dato_escritura(51),obj.dato_escritura(52),obj.dato_escritura(53),obj.dato_escritura(54),obj.dato_escritura(55),obj.dato_escritura(56),obj.dato_escritura(57),obj.dato_escritura(58),obj.dato_escritura(59),obj.dato_escritura(60),obj.dato_escritura(61),obj.dato_escritura(62),obj.dato_escritura(63),obj.dato_escritura(64),obj.dato_escritura(65),obj.dato_escritura(66),obj.dato_escritura(67),obj.dato_escritura(68),obj.dato_escritura(69),obj.dato_escritura(70),obj.dato_escritura(71),obj.dato_escritura(72),obj.dato_escritura(73),obj.dato_escritura(74),obj.dato_escritura(75),obj.dato_escritura(76),obj.dato_escritura(77),obj.dato_escritura(78),obj.dato_escritura(79),obj.dato_escritura(80),char(obj.dato_escritura(81:256)));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_1024(obj,nombre_bd)
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(1),obj.dato_escritura(2),obj.dato_escritura(3),obj.dato_escritura(4),obj.dato_escritura(5),obj.dato_escritura(6),obj.dato_escritura(7),obj.dato_escritura(8),obj.dato_escritura(9),obj.dato_escritura(10),obj.dato_escritura(11),obj.dato_escritura(12),obj.dato_escritura(13),obj.dato_escritura(14),obj.dato_escritura(15),obj.dato_escritura(16),obj.dato_escritura(17),obj.dato_escritura(18),obj.dato_escritura(19),obj.dato_escritura(20),obj.dato_escritura(21),obj.dato_escritura(22),obj.dato_escritura(23),obj.dato_escritura(24),obj.dato_escritura(25),obj.dato_escritura(26),obj.dato_escritura(27),obj.dato_escritura(28),obj.dato_escritura(29),obj.dato_escritura(30),obj.dato_escritura(31),obj.dato_escritura(32),obj.dato_escritura(33),obj.dato_escritura(34),obj.dato_escritura(35),obj.dato_escritura(36),obj.dato_escritura(37),obj.dato_escritura(38),obj.dato_escritura(39),obj.dato_escritura(40),obj.dato_escritura(41),obj.dato_escritura(42),obj.dato_escritura(43),obj.dato_escritura(44),obj.dato_escritura(45),obj.dato_escritura(46),obj.dato_escritura(47),obj.dato_escritura(48),obj.dato_escritura(49),obj.dato_escritura(50),obj.dato_escritura(51),obj.dato_escritura(52),obj.dato_escritura(53),obj.dato_escritura(54),obj.dato_escritura(55),obj.dato_escritura(56),obj.dato_escritura(57),obj.dato_escritura(58),obj.dato_escritura(59),obj.dato_escritura(60),obj.dato_escritura(61),obj.dato_escritura(62),obj.dato_escritura(63),obj.dato_escritura(64),obj.dato_escritura(65),obj.dato_escritura(66),obj.dato_escritura(67),obj.dato_escritura(68),obj.dato_escritura(69),obj.dato_escritura(70),obj.dato_escritura(71),obj.dato_escritura(72),obj.dato_escritura(73),obj.dato_escritura(74),obj.dato_escritura(75),obj.dato_escritura(76),obj.dato_escritura(77),obj.dato_escritura(78),obj.dato_escritura(79),obj.dato_escritura(80),char(obj.dato_escritura(81:512)));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_2048(obj,nombre_bd)
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(1),obj.dato_escritura(2),obj.dato_escritura(3),obj.dato_escritura(4),obj.dato_escritura(5),obj.dato_escritura(6),obj.dato_escritura(7),obj.dato_escritura(8),obj.dato_escritura(9),obj.dato_escritura(10),obj.dato_escritura(11),obj.dato_escritura(12),obj.dato_escritura(13),obj.dato_escritura(14),obj.dato_escritura(15),obj.dato_escritura(16),obj.dato_escritura(17),obj.dato_escritura(18),obj.dato_escritura(19),obj.dato_escritura(20),obj.dato_escritura(21),obj.dato_escritura(22),obj.dato_escritura(23),obj.dato_escritura(24),obj.dato_escritura(25),obj.dato_escritura(26),obj.dato_escritura(27),obj.dato_escritura(28),obj.dato_escritura(29),obj.dato_escritura(30),obj.dato_escritura(31),obj.dato_escritura(32),obj.dato_escritura(33),obj.dato_escritura(34),obj.dato_escritura(35),obj.dato_escritura(36),obj.dato_escritura(37),obj.dato_escritura(38),obj.dato_escritura(39),obj.dato_escritura(40),obj.dato_escritura(41),obj.dato_escritura(42),obj.dato_escritura(43),obj.dato_escritura(44),obj.dato_escritura(45),obj.dato_escritura(46),obj.dato_escritura(47),obj.dato_escritura(48),obj.dato_escritura(49),obj.dato_escritura(50),obj.dato_escritura(51),obj.dato_escritura(52),obj.dato_escritura(53),obj.dato_escritura(54),obj.dato_escritura(55),obj.dato_escritura(56),obj.dato_escritura(57),obj.dato_escritura(58),obj.dato_escritura(59),obj.dato_escritura(60),obj.dato_escritura(61),obj.dato_escritura(62),obj.dato_escritura(63),obj.dato_escritura(64),obj.dato_escritura(65),obj.dato_escritura(66),obj.dato_escritura(67),obj.dato_escritura(68),obj.dato_escritura(69),obj.dato_escritura(70),obj.dato_escritura(71),obj.dato_escritura(72),obj.dato_escritura(73),obj.dato_escritura(74),obj.dato_escritura(75),obj.dato_escritura(76),obj.dato_escritura(77),obj.dato_escritura(78),obj.dato_escritura(79),obj.dato_escritura(80),char(obj.dato_escritura(81:1024)));
            fclose(base_datos);
        end
        
        function grabar_datos_salida_4096(obj,nombre_bd)
            % Grabamos datos de lectura y escritura:
            base_datos=fopen(nombre_bd,'a');
            fprintf(base_datos,'%f %f %f %f %f %f %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %s\n',datevec(datetime('now','Format','yyyy:MM:dd:HH:mm:ss:SSS')),obj.rol,obj.dato_escritura(1),obj.dato_escritura(2),obj.dato_escritura(3),obj.dato_escritura(4),obj.dato_escritura(5),obj.dato_escritura(6),obj.dato_escritura(7),obj.dato_escritura(8),obj.dato_escritura(9),obj.dato_escritura(10),obj.dato_escritura(11),obj.dato_escritura(12),obj.dato_escritura(13),obj.dato_escritura(14),obj.dato_escritura(15),obj.dato_escritura(16),obj.dato_escritura(17),obj.dato_escritura(18),obj.dato_escritura(19),obj.dato_escritura(20),obj.dato_escritura(21),obj.dato_escritura(22),obj.dato_escritura(23),obj.dato_escritura(24),obj.dato_escritura(25),obj.dato_escritura(26),obj.dato_escritura(27),obj.dato_escritura(28),obj.dato_escritura(29),obj.dato_escritura(30),obj.dato_escritura(31),obj.dato_escritura(32),obj.dato_escritura(33),obj.dato_escritura(34),obj.dato_escritura(35),obj.dato_escritura(36),obj.dato_escritura(37),obj.dato_escritura(38),obj.dato_escritura(39),obj.dato_escritura(40),obj.dato_escritura(41),obj.dato_escritura(42),obj.dato_escritura(43),obj.dato_escritura(44),obj.dato_escritura(45),obj.dato_escritura(46),obj.dato_escritura(47),obj.dato_escritura(48),obj.dato_escritura(49),obj.dato_escritura(50),obj.dato_escritura(51),obj.dato_escritura(52),obj.dato_escritura(53),obj.dato_escritura(54),obj.dato_escritura(55),obj.dato_escritura(56),obj.dato_escritura(57),obj.dato_escritura(58),obj.dato_escritura(59),obj.dato_escritura(60),obj.dato_escritura(61),obj.dato_escritura(62),obj.dato_escritura(63),obj.dato_escritura(64),obj.dato_escritura(65),obj.dato_escritura(66),obj.dato_escritura(67),obj.dato_escritura(68),obj.dato_escritura(69),obj.dato_escritura(70),obj.dato_escritura(71),obj.dato_escritura(72),obj.dato_escritura(73),obj.dato_escritura(74),obj.dato_escritura(75),obj.dato_escritura(76),obj.dato_escritura(77),obj.dato_escritura(78),obj.dato_escritura(79),obj.dato_escritura(80),char(obj.dato_escritura(81:2048)));
            fclose(base_datos);
        end
    end
end
