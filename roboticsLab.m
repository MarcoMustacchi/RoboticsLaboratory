close all
clear all
clc

%% Include subfolders for Simulink subsystems (otherwise for simulation trough MATLAB same folder..)
% when you you close MATLAB, path is restored
cd simulink_models\
addpath(genpath(pwd))
cd ..

%% Include subfolders for MATLAB functions
% when you you close MATLAB, path is restored
cd matlab_functions\
addpath(genpath(pwd))
cd ..

%% Load data
load_params_unicycle
% run('..\Lab0\lab0_controllerPIDdesign.m')
% load('..\Lab0\data\LAB_inertiaParameterEstimated.mat')

%% Trajectory generation
trajectory_generation

%% save mat-files
% filenameMAT = strcat('PID_antiWindup_','withStepAmplitude',string(stepAmplitude),'.mat');
% save(filenameMAT,'theta','ia');

%% run Simulink simulations
sim('./simulink_models/Lab1', 'StopTime', '10')

%% plot XY
plot_XY(ans)
hold on
plot(ans.odom.signals.values(:,1), ans.odom.signals.values(:,2), '*-','LineWidth', 1);

%% save figures
filenameFIGURE = append('./figure/DynBounds_', tracking_traj, '_', tracking_controller, '.pdf');
exportgraphics(figure(5),filenameFIGURE,'ContentType','vector')

%% final animation
% Creating Data to Animate
% Time array
t = linspace(0, 6, 100);
% Particle coordinates
x = 4*sin(t);
y = 0.5*x.^2;
z = x.*cos(t);
plot_trajectory_animation(x,y,z,t)

%% test
R = [cos(45), -sin(45), 0;
    sin(45), cos(45), 0;
    0, 0, 1];

% eul2rotm
poseplot(R,[0 0 0],MeshFileName="multirotor.stl",ScaleFactor=0.05);
hold on
poseplot(eye(3),[5 5 5],MeshFileName="multirotor.stl",ScaleFactor=0.05);

%% another test
% 3d coordinates of a curve
x = 0:.05:2*pi;
y = sin(x);
z = cos(x);
col = rand(1,numel(x)); % color vector: a set of values that are mapped in the colorbar
plot4D(x,y,z,col);
