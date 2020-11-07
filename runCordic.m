clc;close all; clear all;
% Initialize arctan table
BitWidth		=	16; 
Precision       =	BitWidth - 1; 
ScalingNo 		=   2^(Precision - 1);
% pre-calculate Atan
k = 1.0; 
for i=1:Precision 
	AtanList(i) =   round(atan(k)*ScalingNo); 
    k=k/2; 
end; 
atanHex         =	dec2hex(AtanList) 

% An calculation 
An              =	1.0; 
for n = 0:Precision-1 
	An          =   An*(sqrt(1 + 2^(-2*n))); 
end; 
% x0 calculation, convertion
1/An
x0              =	dec2hex(round(ScalingNo*(1/An))) 

% angles calculation
Angle           = 	[0, pi/8, pi/6, pi/4, pi/2, -pi/8,...
                                       -pi/6, -pi/4, -pi/2];
IntAngle        =	dec2hex(round(Angle*ScalingNo)) 
% Cos and Sine calculated by MATLAB 
cos_results     =	dec2hex(round(ScalingNo*cos(Angle))) 
sin_results     =	dec2hex(round(ScalingNo*sin(Angle)))

% cos_results =     % sin_results =
%                   % 
%   9×4 char array  %   9×4 char array
%                   % 
%     '4000'        %     '0000'
%     '3B21'        %     '187E'
%     '376D'        %     '2000'
%     '2D41'        %     '2D41'
%     '0000'        %     '4000'
%     '3B21'        %     'E782'
%     '376D'        %     'E000'
%     '2D41'        %     'D2BF'
%     '0000'        %     'C000'
