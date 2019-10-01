function [force, length, temp1, temp2 ]=readData(out,calCo, thermistor_lookup)
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


end
