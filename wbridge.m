%  wbridge.m  (script for use with GNU Octave)
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
% Calculate output voltage of a Wheatstone Bridge as function of one
% variable resisor Rx using Kirchoff circuit laws and 
% left division operator with a matrix and vector 

circuit = "\n \
    Wheatstone Bridge                                               \n \
         i1    i2                                                   \n \
    o---->--o--<----------o                                         \n \
    |       |             |          Vin = 1V                       \n \
    |       | ^i3         | ^i2                                     \n \
    |       | -         - |          R1 = 1000 Ohm                  \n \
    |       R1            R2         R2 = 1000 Ohm                  \n \
  + o       | +         + |          R3 = 1000 Ohm                  \n \
  Vin       |     Vout    |                                         \n \
  - o    Va o--o -   + o--o Vb                                      \n \
    |       |             |          Vout = ?                       \n \
    |       | -         - |                                         \n \
    |       R3            Rx                                        \n \
    |       | +         + | ^i2                                     \n \
    o-------o-------------o                                         \n \
"
kirchoff = "\n \
Kirchoff circuit laws:              \n \
                                    \n \
⎧ i1 + i2 + i3 = 0                  \n \
⎨ Vin + i3.R1 + i3.R3 = 0           \n \
⎩ -i3.R1 + i2.R2 + i2.Rx - i3.R3 = 0\n \
                                    \n \
which means:                        \n \
                                    \n \
⎧ i1 + i2 + i3 = 0                  \n \
⎨ -(R1 + R3).i3 = Vin               \n \
⎩ (R2 + Rx).i2 - (R1 + R3).i3 = 0   \n \
                                    \n \
A*x = b                             \n \
                                    \n \
    | 1      1          1    |      \n \
A = | 0      0      -(R2+R3) |      \n \
    | 0   (R2+Rx)   -(R2+R3) |      \n \
                                    \n \
    |  0  |                         \n \
b = | Vin |                         \n \
    |  0  |                         \n \
                                    \n \
also                                \n \
                                    \n \
Vout = i3.R3 - i2.Rx                \n \
"
% ***  Wheatstone Bridge ***
% define circuit values
Vin = 1
R1 = 1e3
R2 = 1e3
R3 = 1e3
% vector of different values in Rx, done this way to give the same values as simulator LTSPICE
Rx = [logspace(2, 3, 11)(1:end-1),logspace(2, 3, 11)(1:end-1)*10,10e3]; 
% solve the Kirchoff equations system for a range of values of Rx
Vout = [];
disp("      Rx(Ohm)      Vout(V)")
for r = Rx % loop through the resistance values in Rx
    % define the system of equations as Z.I = V
    Z = [1, 1, 1; 0, 0, -(R2+R3); 0, (R2+r), -(R2+R3)]; % all the resistances in matrix Z
    V = [0; Vin; 0]; % on the right side of the equal sign, all the voltages in vector V (only 1 here)
    I = Z \ V; % solve for the currents, generate vector I
    vout_new = dot(I, [0, -r, R3]); % calculate Vout from the currents in vector I using dot pruduct
    printf(" %1.6e Ohm\t %2.6e V \n", r, vout_new) % output to screen
    Vout = [ Vout, vout_new]; % add the value to matrix Vout
endfor
% plot values
semilogx(Rx, Vout) % logaritmic x scale gives nicer plot 
title("Wheatstone Bridge output vs Rx")
xlabel("Rx (Ohm)")
ylabel("Vout (V)")
grid()



