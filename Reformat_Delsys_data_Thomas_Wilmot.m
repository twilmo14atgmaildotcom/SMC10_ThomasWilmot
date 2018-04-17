%% Delsys data reformatting by Thomas Michael Wilmot
% Last updated: 17/04/18
% for more information contact: twilmo14@student.aau.dk

clear all;
close all;
clc;

%% Go to data folder

% Change directory
cd('C:\Users\Thomas\Documents\GitHub\SMC10_ThomasWilmot\SMC10_ThomasWilmot\Delsysdata210318\TomSimpleMotionDelsys_210318')

%% Import data

% Create list of files in current folder
Dir_cf=dir('*.xls'); %enter target file format between brackets

% Import Data
for i=1:length(Dir_cf)
    fileName=Dir_cf(i).name;
    %    extractBetween(fileName,'TomMotionSimple_210318_','_Rep')=readtable(fileName);
    tabNames{i}=cell2mat(extractBetween(fileName,'TomMotionSimple_210318_','_Rep'));
    assignin('base', tabNames{i}, readtable(fileName)); 
end
clear('i','tabNames','fileName','Dir_cf');
clc;