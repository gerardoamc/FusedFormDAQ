function calCo=calibrateForce(s)
out.s=s;
calCo.offset=0;
calCo.g=1;

% read the raw sensor output with two different massess

% sensor data without load
mbox=msgbox('Leave the sensor without load','Calibration');
uiwait(mbox);
[force_0]=readForce(out,calCo)

% sensor data with 1100gr load
mbox=msgbox('Leave the sensor wit 1100gr load','Calibration');
uiwait(mbox);
[force_1]=readForce(out,calCo)
%[forces, length, temp1, temp2]=readData(force,calCo, thermistor_lookup);
% calculate sensor offset
offset=force_0;

% calculate gain
gain=(force_1-force_0)/1100;

calco.offset={offset};
calCo.g=[gain];

mbox=msgbox('sensor calibration complete'); uiwait(mbox);
end












