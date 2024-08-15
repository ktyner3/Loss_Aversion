%% Clear
clear;
clc;

%% Add path
addpath('C:\Users\Kevin_Tyner\Desktop\MATLAB\Code\Functions\');
addpath('C:\Users\Kevin_Tyner\Documents\MATLAB\matnwb-2.6.0.2\');

%% Set properties
fname = 'Z:\LossAversion\Patient folders\CLASE018\NWB-processing\NWB_Data\CLASE018_Session_3_filter.nwb';
behav_fname = 'Z:\LossAversion\Patient folders\CLASE018\Behavioral-data\clase_behavior_CLASE018_738812.7161.mat';
electrode_fname = 'Z:\LossAversion\Patient folders\CLASE018\Neuroimaging\RAVE_YAEL\electrodes.csv';

hemi = 'Left';
region = 'Amygdala';

lfreq = 0.5;

%% Create the object
obj = LOSS_AVERSION(fname,behav_fname);

%% Remove bad channels (artifacts)
removeArtifacts(obj,electrode_fname,hemi,region);

%% High pass the data at 0.5 Hz
dataFilter(obj,lfreq);

%% Bipolar referencing
bipolarReference(obj);

%% Get the channels of interest
selectChannels(obj);

%% Identify location of TTLs
identifyTTLs(obj);

%% Generate epochs
generateEpochs(obj);

%% SPRiNT
SPRiNT(obj,0.5,200);

%% Save data
saveData(obj);

%% Allocate data
%allocateData(obj); % finish here