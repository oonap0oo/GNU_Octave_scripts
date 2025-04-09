%  lorenz_system.m  (script for use with GNU Octave)
%
%  Copyright 2025 Nap0
%
%  This program is free software; you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published by
%  the Free Software Foundation; either version 2 of the License, or
%  (at your option) any later version.
%
%  This program is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
%
%  You should have received a copy of the GNU General Public License
%  along with this program; if not, write to the Free Software
%  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
%  MA 02110-1301, USA.
%
%  This code calculates a solution for the Lorenz System with the
%  system parameters sigma = 10, beta = 8.0 / 3.0, rho = 28.0
% using the Octave ode45() function

circuit = "\n \
Lorenz System of ODEs: \n \
 \n \
 dx                      dy                          dz \n \
---- = σ(y - x)         ---- = x(ρ - z) - y         ---- = xy - βz \n \
 dt                      dt                          dt \n \
 "
% parameters
disp("parameters:")
sigma = 10
beta = 8.0 / 3.0
rho = 28.0

% define a function that takes n*1 array t and nx3 array xyz
% array xyz contains the values of x,y and z
% the function returns the derivatives of x, y and z with respect to time
% as an array
fun_lorenz_system = @(time,xyz) [-sigma * xyz(1) + sigma * xyz(2);
                                 rho * xyz(1) - xyz(2) - xyz(1) * xyz(3);
                                 -beta * xyz(3) + xyz(1) * xyz(2)];

% 1x2 array which defines the time interval
time_interval = [0 100];

% the initial conditions for x;y and z
initial_conditions = [1.0 1.0 0.0];

% ode45 calculates the respoce of the system
[time,xyz_values] = ode45(fun_lorenz_system, time_interval, initial_conditions);

% print some of the numbers
disp("         x         y         z")
disp([xyz_values(1:20,1) xyz_values(1:20,2) xyz_values(1:20,3)])

% create a 3D line plot of x, y and z
graph = plot3(xyz_values(:,1), xyz_values(:,2), xyz_values(:,3));
set(graph, "LineWidth", 1);
title ("Lorenz System, calculations and plot using GNU Octave", "fontsize", 16);
xlabel("x")
ylabel("y")
zlabel("z")
grid()
