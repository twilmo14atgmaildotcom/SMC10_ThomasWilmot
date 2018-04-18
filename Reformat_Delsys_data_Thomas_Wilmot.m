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

% Import data as tables
for i=1:length(Dir_cf)
    fileName=Dir_cf(i).name;
    tabNames{i}=cell2mat(extractBetween(fileName,'TomMotionSimple_210318_','_Rep')); %Create variable names from recorded data 
    assignin('base', tabNames{i}, readtable(fileName)); %Create tables from recorded data
    s1=tabNames{i};
    s2='.Properties.VariableNames';
    c1{i}=strcat(s1,s2);
    s3='=erase(' ;
    s4=',' ;
    c2{i}=strcat(c1{i},s3,c1{i},s4,');');
end
clear('i','tabNames','fileName','Dir_cf','s2','s1','c1','s3','s4'); %Remove unwanted variables from workspace
clc;

%% Remove errors such as unwanted '_' from variable names in tables

c2'
% select and copy ouput into new temporary script > use find all (crtl+f) /replace
% all functions to remove '{','}',' ',... punctuation etc > insert any error 
% characters that appear in the variable names before the bracket in ',);' 
%The resulting code should look similar to the following lines
RadialDeviation_1kg.Properties.VariableNames=erase(RadialDeviation_1kg.Properties.VariableNames,'_');
RadialDeviation_2kg.Properties.VariableNames=erase(RadialDeviation_2kg.Properties.VariableNames,'_');
RadialDeviation.Properties.VariableNames=erase(RadialDeviation.Properties.VariableNames,'_');
UlnarDeviation.Properties.VariableNames=erase(UlnarDeviation.Properties.VariableNames,'_');
WristExtension_1kg.Properties.VariableNames=erase(WristExtension_1kg.Properties.VariableNames,'_');
WristExtension_2kg.Properties.VariableNames=erase(WristExtension_2kg.Properties.VariableNames,'_');
WristExtension.Properties.VariableNames=erase(WristExtension.Properties.VariableNames,'_');
WristFlexion_1kg.Properties.VariableNames=erase(WristFlexion_1kg.Properties.VariableNames,'_');
WristFlexion_2kg.Properties.VariableNames=erase(WristFlexion_2kg.Properties.VariableNames,'_');
WristFlexion.Properties.VariableNames=erase(WristFlexion.Properties.VariableNames,'_');

clear('c2','ans');
clc;

%% Convert table data into structured arrays

% Create index of workspace
zworksp_idx= evalin('base','whos'); 

% Use 'table2struct' function on all tables to convert them to structured
% arrays

for idx_var=1:length(zworksp_idx)
    name_var=(zworksp_idx(idx_var).name);
    curr_var=eval(name_var);
    curr_var2=table2struct(curr_var);
    assignin('base',(zworksp_idx(idx_var).name),curr_var2);
end

clear('curr_var', 'name_var', 'idx_var', 'curr_var2');% Remove unwanted variables from workspace
clc;

%% Synchronise data channels from IMU with EMG

% Get indices for Time, EMG, Mag, Acc and Gyro channels
for idx_var=1:length(zworksp_idx)
    name_var=(zworksp_idx(idx_var).name);
    curr_var=eval(name_var);
    columnName=fieldnames(curr_var(idx_var));
    idx_Time=find(contains(columnName,'Xs')==1);
    idx_EMG=find(contains(columnName,'EMG')==1);
    idx_Acc=find(contains(columnName,'ACC')==1);
    idx_Mag=find(contains(columnName,'Mag')==1);
    idx_Gyro=find(contains(columnName,'Gyro')==1);
end



    