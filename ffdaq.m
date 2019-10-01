%__________________________________________________________________________
%              Data acquisition script for FusedForm Minilab
%                    v1.0 Developed by Juan C. Blanco 
%                  Updated by Gerardo A. Mazzei Capote
%                            September 2019
%__________________________________________________________________________
classdef ffdaq
    methods (Static)
        function [s,flag]=ini(comPort)
            %Initializes ports
            if ~isempty(instrfind)
                fclose(instrfind);
                delete(instrfind);
            end
            close all
            clc
            disp('Serial Port Closed')
            flag=1;
            s=serial(comPort);
            set(s,'DataBits',8);
            set(s,'StopBits',1);
            set(s,'BaudRate',9600);
            set(s,'Parity','none');
            fopen(s);
            a='b';
            while (a~='a')
                a=fread(s,1,'uchar');
            end
            if (a=='a')
                disp('serial read');
            end
            fprintf(s,'%c','a');
            mbox=msgbox('Serial Communication Setup.'); uiwait(mbox);
            fscanf(s,'%u');
        end
        function [force, length, temp1, temp2, actual_time]=readData(out,thermistor_lookup, calCo)
            if nargin<3 %If no input, use defaults, calibrated w 1.1 kg
                calCo.g=0.054545454545455;
                calCo.offset=0;
            end
            tic
            fprintf(out.s,'R');
            % read force values from force sensor
            readings(1)=fscanf(out.s,'%f');
            readings(2)=fscanf(out.s,'%f');
            readings(3)=fscanf(out.s,'%f');
            readings(4)=fscanf(out.s,'%f');
            %determines what offset and gain values to use
            offset=calCo.offset;
            gain=calCo.g;
            mass=(readings(1)-offset)./gain;
            length=readings(2)*0.028884;
            temp1=interp1(thermistor_lookup(:,1),thermistor_lookup(:,2),readings(3));
            temp2=interp1(thermistor_lookup(:,1),thermistor_lookup(:,2),readings(4));
            %map analog input
            force=mass;
            actual_time=toc;
        end
    end
end