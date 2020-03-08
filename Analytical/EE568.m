%% EE568 - Special Topics on Electrical Machines
% Project 1 
% Analytical Calculations
% Raþit GÖKMEN / e2339760

clear
clc

%% Definition of Variables
mu0 = 4*pi*10e-7;
angle = linspace(0,180,1801);
full_angle = linspace(0,360,3601);
deltaangle = 0.1;
MinLengthOfAirgap = 0.5e-3;
MaxLengthOfAirgap = 2.5e-3;
NumberOfTurns = 250;
RadiusOfRotor_max = 12e-3;
RadiusOfRotor_min = 10e-3;
alfa = asind(7.5/12);
DepthOfCore = 20e-3;
Current = 3;
Leq = zeros(1,1801);
Req = zeros(1,1801);
Teq = zeros(1,1801);
R1 = zeros(1,1801);
R2 = zeros(1,1801);
%% Calculation of Reluctance
% for part1 Req = R1//R2 for angle is between 0 - 77.36 degrees (the angle 77.36 represents that the corner of saliency of rotor is inline with corner of core.
R1_part1 = (2*MinLengthOfAirgap)/(mu0*2*pi*RadiusOfRotor_max*DepthOfCore); % 
R2_part1 = (2*MaxLengthOfAirgap)/(mu0*2*pi*RadiusOfRotor_min*DepthOfCore); % 

% for part2 Req = R2 for angle is between 77.36 - 102,64 degrees (the angle represents again the intersects of corners of rotor and core until this point  reluctance is due to the circle part of rotor
R2_part2 = (2*MaxLengthOfAirgap)/(mu0*2*pi*RadiusOfRotor_min*DepthOfCore); % 
% for part3 Req = R1//R2 for angle is between 102,64 to 180 degrees  , t

R1_part3 = R1_part1 ; % 
R2_part3 = R2_part1 ; % 

% Req between 0-77.36 degrees 
for i=0:1:1800
    if i==0 | i==1800
            Req(i+1) = R1_part1*(360)/(2*alfa); 
            Leq(i+1) = (NumberOfTurns*NumberOfTurns)/Req(i+1);
    elseif i > 0 & i < 774
            R1(i+1) = R1_part1*(360/(2*alfa-i/10));
            R2(i+1) = R2_part1*(360)/(i/10);
            Req(i+1) = R1(i+1)*R2(i+1)/(R1(i+1)+R2(i+1));
            Leq(i+1) = (NumberOfTurns*NumberOfTurns)/Req(i+1);
    elseif i>=774 & i<= 1026
             Req(i+1) = R2_part2*(360)/(2*alfa); 
             Leq(i+1) = (NumberOfTurns*NumberOfTurns)/Req(i+1);
    elseif i> 1026 & i< 1800
             R1(i+1) = R1_part3*(360)/(i/10-102.64);
             R2(i+1) = R2_part3*(360)/(180-i/10);
             Req(i+1) = R1(i+1)*R2(i+1)/(R1(i+1)+R2(i+1));
             Leq(i+1) = (NumberOfTurns*NumberOfTurns)/Req(i+1);
    end
end

%% copy the 0-180 degree reluctance to 180-360 degree
Req(1) = Req(2);
Req(numel(angle)) = Req(numel(angle)-1);
for(i=(numel(angle)+1):(2*numel(angle)-1))

    Req(i) = Req(i-numel(angle));
end

%% copy the 0-180 degree inductance to 180-360 degree
Leq(1) = Leq(2);
Leq(numel(angle)) = Leq(numel(angle)-1);
for(i=(numel(angle)+1):(2*numel(angle)-1))
    Leq(i) = Leq(i-numel(angle));
end
%% Calculation Of Torque

for i=0:1:3599
    Teq(i+1)= 0.5*Current^2*(Leq(i+2)-Leq(i+1))/(deltaangle*pi/180);
end
   Teq(3601)= Teq(3600);


%% Plotting the waveforms
plot(full_angle,Leq,'LineWidth',2);
grid on;
xlabel('Position (degree)','FontSize',12,'FontWeight','bold');
ylabel('Inductance (H)','FontSize',12,'FontWeight','bold');
title('Inductance of the System');
set(gca,'FontSize',12,'FontWeight','bold')
grid on
xlim([0 360])
xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])
figure;


plot(full_angle,Req,'LineWidth',2);
grid on;
xlabel('Position (degree)','FontSize',12,'FontWeight','bold');
ylabel('Reluctance (1/H)','FontSize',12,'FontWeight','bold');
title('Reluctance of the System');
set(gca,'FontSize',12,'FontWeight','bold')
grid on
xlim([0 360])
xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])
figure;

plot(full_angle,Teq,'LineWidth',2);
grid on;
xlabel('Position (degree)','FontSize',12,'FontWeight','bold');
ylabel('Torque (Nm)','FontSize',12,'FontWeight','bold');
title('Torque of the System');
set(gca,'FontSize',12,'FontWeight','bold')
grid on
xlim([0 360])
xticks([0 30 60 90 120 150 180 210 240 270 300 330 360])
