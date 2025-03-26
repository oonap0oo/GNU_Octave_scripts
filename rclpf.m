#  rclpf.m  (script for use with GNU Octave)
#  
#  Copyright 2025 Nap0
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  RC low pass filter for GNU Octave
clc;
disp("RC low pass filter")
s = ...
" \
o------ R ------o------o\n \
                |       \n \
Vin             C     Vo\n \
                |       \n \
o---------------o------o\n ";               
disp(s)
C = 15e-9
R = 10e3 + 680
# prepare the frequency values in a vector f
f = logspace(1,5,20);
# calculate impedance values for capacitor
Zc = 1 ./ (2 * pi * f * C * 1i);
# calculate transferfunction of low pass filter
H = Zc ./ (R + Zc);
# get the magnitude and phase of the complex values in H
# convert magnitude to dB and phase to degrees
abs_H = abs(H);
dB_abs_H = 20 * log10( abs_H );
arg_H = rad2deg( arg(H) );
# print results as text
format short g
disp("     freq(Hz)  magnitude(dB)   phase(°)")
disp( [f; dB_abs_H; arg_H]' )
# plot the magnitude and phase in two subplots using log scale for horizontal f scale
clf
subplot(2,1,1)
semilogx(f,dB_abs_H)
title("Transferfunction magnitude")
xlabel("frequency (Hz)")
ylabel("magnitude (dB)")
grid()
subplot(2,1,2)
semilogx(f,arg_H)
title("Transferfunction phase")
xlabel("frequency (Hz)")
ylabel("phase (°)")
grid()
