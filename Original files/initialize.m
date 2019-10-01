run('close_Serial.m')
comPort='com42';
[force.s,fserialFlag]=setupSerial(comPort);
% calCo=calibrateForce(force.s);
calCo.g=0.0548;
calCo.offset=0;
%%
% 
% for i=1:1:20
%     
%    [forces]=readForce(force,calCo)
%     pause(0.01);
%     
% end


%% Open a new figure - add start/stop and close serial buttons
% initialize the figure that will be plot if it does not exist
%clear button
if(~exist('h','var')||~ishandle(h))
    h=figure(1);
    ax=axes('box','on');
end
if (~exist('button','var'))
    button=uicontrol('Style','pushbutton','String','Stop',...
        'pos',[0 0 50 25],'parent',h,...
        'Callback','stop_call_vector','UserData',1);
end
% clos_call function calls everytime it is pressed
if(~exist('button2','var'))
    button=uicontrol('Style','pushbutton','String','Close Serial Port',...
        'pos',[250 0 150 25],'parent',h,...
        'Callback','closeSerial','UserData',1);    
end
    
buf_len=2;
% Rolling plot of data
%  buf_len=100;
%  index=1:buf_len;
% force_data=zeros(buf_len,1);
% length_data=zeros(buf_len,1);
tic
% data Collection and plotting
% while the figure window is open
while (get(button,'UserData'))
index=1:buf_len;
% force_data=zeros(buf_len,1);
% length_data=zeros(buf_len,1);
    % Get the new value from acceleometer
    [forces, length]=readData(force,calCo)
    % Update the rolling plot. Append the new reading to the end of the 
    % rolling plot data. Drop the first value
    actual_time=toc
    force_data(buf_len,1:3)=[buf_len,actual_time, forces];
    length_data(buf_len,1:3)=[buf_len,actual_time,length];
    %plot for X magnitude
    subplot(2,1,1);
%     plot(index,force_data,'r');
    plot(force_data(:,2),force_data(:,3),'r');
%     axis([1 buf_len -100 3000]);
    axis([0 ceil(actual_time) -100 3000]);
    xlabel('time')
    ylabel('Magnitude of extrusion force(g)')
    subplot(2,1,2);
%     plot(index,length_data,'b');
    plot(length_data(:,2),length_data(:,3),'r');
    axis([0 ceil(actual_time) -100 150]);
    xlabel('time')
    ylabel('Magnitude of extruded length (mm)')
    drawnow;
    buf_len=buf_len+1;
end

%%
clear force_data length_data index forces length

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    