% ========================================================
% Distributed Multi-Robot Tracking (Simplified Reproduction)
% Based on Park et al., "Distributed Multi-Robot Tracking..."
% ========================================================

clear; clc; close all;

%% Parameters
N_targets = 30;     % number of targets
N_robots  = 6;      % number of robots
area_size = 10;     % environment is [0, area_size] x [0, area_size]
iterations = 50;    % simulation steps
noise_sigma = 0.3;  % measurement noise

%% Generate targets
% --- CASE 1: Uniform targets
targets_uniform = area_size*rand(N_targets,2);

% --- CASE 2: Clustered targets (Gaussian clusters, manual)
centers = [3 7; 8 8]; % cluster centers
cluster_std = 0.5;
targets_clustered = [];
for i = 1:size(centers,1)
    cluster = centers(i,:) + cluster_std*randn(N_targets/2,2);
    targets_clustered = [targets_clustered; cluster];
end

%% Initialize robots (random)
robots = area_size*rand(N_robots,2);

%% Store RMSE for evaluation
rmse_uniform = zeros(iterations,1);
rmse_clustered = zeros(iterations,1);

%% Simulation loop
for t = 1:iterations
    % --- Uniform case
    noisy_meas = targets_uniform + noise_sigma*randn(N_targets,2);
    centroid_targets = mean(noisy_meas); % Instant estimator
    % Move robots toward centroid
    robots_uniform = robots + 0.1*(centroid_targets - robots);
    rmse_uniform(t) = sqrt(mean(sum((robots_uniform - centroid_targets).^2,2)));

    % --- Clustered case
    noisy_meas = targets_clustered + noise_sigma*randn(N_targets,2);
    centroid_targets = mean(noisy_meas); % Instant estimator
    robots_clustered = robots + 0.1*(centroid_targets - robots);
    rmse_clustered(t) = sqrt(mean(sum((robots_clustered - centroid_targets).^2,2)));

    % --- Update robots
    robots = robots_clustered; % overwrite for simplicity
end

%% Plot RMSE comparison
figure;
plot(1:iterations, rmse_uniform, 'b-', 'LineWidth', 2); hold on;
plot(1:iterations, rmse_clustered, 'r-', 'LineWidth', 2);
xlabel('Iteration'); ylabel('RMSE');
legend('Uniform targets','Clustered targets');
title('Tracking Error (Simplified Simulation)');
grid on;
