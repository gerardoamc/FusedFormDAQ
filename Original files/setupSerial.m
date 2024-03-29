function[s,flag]=setupSerial(comPort)
% Arduino-Matlab communication is initialized. Ifsetup is complete, the
% value of setup is returned as 1. Else is returned as 0.

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
    
    
    
    
    