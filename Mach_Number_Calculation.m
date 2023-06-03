% Andrew C. Greig
% ENGR 1140 3/23/2023

format shortG; clear; close all; clc

gamma = 1.4; % heat capacity ratio for air
R = 1716.46; % universal gas constant

% web('https://www.pdas.com/milstd210.html');
% pause(2.5)

waitfor(msgbox(['This program calculates the Mach number of an aircraft at an altitude given a known air speed. This program uses ' ...
    'https://www.pdas.com/milstd210.html for temperature data.']));

userInput = inputdlg({'Input an altitude to the nearest thousandth foot (ex. 1000 ft. = 1):', 'Input an airspeed:', ['Select a desired unit for airspeed ' ...
    '(knots = 1; feet per second = 2):']});

altitude = str2num(userInput{1});
airspeed = str2num(userInput{2});
units = str2num(userInput{3});

if altitude < 0 || altitude > 100 % check to ensure altitude falls within 0 --> 100kft range
    msgbox('INVALID INPUT (1)')
    pause(1)
    clc;
    return
else
end

temperature_data = readtable("https://www.pdas.com/milstd210.html",... % imports temperature data
    FileType="html",ReadVariableNames=true,ThousandsSeparator=",");
T = table2array(temperature_data(altitude + 1,6)); % selects temperature value from table

a = sqrt(gamma*R*T); % Mach 1 airspeed
aString = num2str(a);

if units == 1
    convertedAirspeed = airspeed * 1.68781;
elseif units == 2
    convertedAirspeed = airspeed; %#ok<*ST2NM> 
else % close program if user inputs unit non-given
    msgbox('INVALID INPUT (2)')
    pause(1)
    clc;
    return
end

disp(' ')
msgbox("The speed of sound for the given temperature is " + aString + " feet per second, and the aircraft is travelling at mach " + convertedAirspeed/a + ".")