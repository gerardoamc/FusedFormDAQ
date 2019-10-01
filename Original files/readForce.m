function [force]=readForce(out,calCo)
fprintf(out.s,'R');
% read force values from force sensor
%readings=fscanf(out.s,'%u');
readings(1)=fscanf(out.s,'%f');
readings(2)=fscanf(out.s,'%f');
readings(3)=fscanf(out.s,'%f');
readings(4)=fscanf(out.s,'%f');

%determines what offset and gain values to use
offset=calCo.offset;
gain=calCo.g;
mass=(readings(1)-offset)./gain;

%map analog input 
force=mass;
end
