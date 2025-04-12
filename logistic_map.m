%  logistic_map.m  (script for use with GNU Octave)
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
% This GNU Ocave script calculates a image of the bifurcation diagram
% for the logistic map 
% Xn+1 = a. Xn.(1 - Xn)
% iterations are done for increasing values of 'a'
% the logistic map is represented as a matrix
% the map is displayed using the imshow(à function

% *** parameters ****
% total number of iterations
loops = 4000
% Logistic map wil be nrows x ncols array
ncols = 5333
nrows = 3000
% start and end value of parameter a
astart = 3.5
aend = 4.0

% the numpy array to contain the logistic map is fllled with zeros
% this is the picture to be viewed later, dimensions of logistic
% are nrows x ncols
logistic = zeros(nrows, ncols);

% values for parameter a are defined, a is here a vector of
% increasing values between astart en aend to be
% used for each column of logistic
a = linspace(astart, aend, ncols);

% the initial values for x are defined, x is here a vector holding values to be
% used for each column of logistic
x = repmat(0.5, 1, ncols);

% vector containing all the column indices of logistic map
columns = [1:ncols];

disp("starting "), disp(loops), disp("iterations")

for index = 1:loops
    % perform logistic function for all x values at once
    % calculate new values for x for all the different a parameters
    % in each loop iteration, both x and a are vectors
    x = a .* x .* (1.0 - x);
    % calculate row indices for all values of x it uses a vectorised
    % conversion to integer via .astype(int), 1 is subtracted because
    % index anways starts at zero
    rows = round(x * (nrows - 1)) + 1;
    % elements of array logistic are incremented by 1
    % at rows determined by linear array rows
    % and over all columns as directed by columns = np.arange(ncols)
    %logistic[rows, columns] += 1
    indices = sub2ind( size(logistic), rows, columns );
    ++logistic( indices );
endfor

logistic_average = mean(mean(logistic))
logistic_maximum = max(max(logistic))
% vmaximum is a clipping value above which pixel greyscale will be 100% white
vmaximum = 7.0 * logistic_average

imshow( flip(logistic), [0, vmaximum])
title ("Bifurcation diagram for the logistic map, using GNU Octave", "fontsize", 16);




