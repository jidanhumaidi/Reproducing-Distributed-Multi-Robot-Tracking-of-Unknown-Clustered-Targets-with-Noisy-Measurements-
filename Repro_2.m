% Repro_Animation.m
% Animation for Distributed Multi-robot Tracking (Simplified Version)

clear; clc; close all;

% Parameters
N_targets = 40;          % number of targets
N_robots = 5;            % number of robots
cluster_std = 0.2;       % cluster spread
N_iter = 50;             % number of iterations
step_size = 0.1;         % robot movement speed

% Create video writers
v_uniform = VideoWriter('anim_uniform.mp4','MPEG-4');
v_uniform.FrameRate = 5;
open(v_uniform);

v_clustered = VideoWriter('anim_clustered.mp4','MPEG-4');
v_clustered.FrameRate = 5;
open(v_clustered);

%% ========== Case 1: Uniform Targets ==========
targets_uniform = rand(N_targets,2)*10; % uniform distribution
robots = rand(N_robots,2)*10;           % initial robot positions

fig1 = figure('Position',[100 100 600 500]);
for t = 1:N_iter
    % Compute centroid
    centroid = mean(targets_uniform);
    
    % Update robot positions toward centroid
    for r = 1:N_robots
        dir = centroid - robots(r,:);
        robots(r,:) = robots(r,:) + step_size * dir / norm(dir);
    end
    
    % Plot
    clf;
    plot(targets_uniform(:,1), targets_uniform(:,2),'bo','MarkerFaceColor','b'); hold on;
    plot(robots(:,1), robots(:,2),'rs','MarkerFaceColor','r');
    plot(centroid(1), centroid(2),'kp','MarkerSize',12,'MarkerFaceColor','y');
    title(sprintf('Uniform Targets Tracking - Iter %d',t));
    legend('Targets','Robots','Centroid');
    axis([0 10 0 10]); grid on;
    frame = getframe(fig1);
    writeVideo(v_uniform, frame);
end
close(v_uniform);

%% ========== Case 2: Clustered Targets ==========
centers = [3 3; 7 7];
targets_clustered = [];
% Replace this part:
% for i = 1:2
%     targets_clustered = [targets_clustered; ...
%         mvnrnd(centers(i,:), cluster_std^2*eye(2), N_targets/2)];
% end

% With this:
for i = 1:2
    cluster = centers(i,:) + cluster_std*randn(N_targets/2,2);
    targets_clustered = [targets_clustered; cluster];
end

robots = rand(N_robots,2)*10;

fig2 = figure('Position',[750 100 600 500]);
for t = 1:N_iter
    % Compute centroid
    centroid = mean(targets_clustered);
    
    % Update robot positions toward centroid
    for r = 1:N_robots
        dir = centroid - robots(r,:);
        robots(r,:) = robots(r,:) + step_size * dir / norm(dir);
    end
    
    % Plot
    clf;
    plot(targets_clustered(:,1), targets_clustered(:,2),'go','MarkerFaceColor','g'); hold on;
    plot(robots(:,1), robots(:,2),'rs','MarkerFaceColor','r');
    plot(centroid(1), centroid(2),'kp','MarkerSize',12,'MarkerFaceColor','y');
    title(sprintf('Clustered Targets Tracking - Iter %d',t));
    legend('Targets','Robots','Centroid');
    axis([0 10 0 10]); grid on;
    frame = getframe(fig2);
    writeVideo(v_clustered, frame);
end
close(v_clustered);

disp('✅ Animations saved: anim_uniform.mp4 and anim_clustered.mp4');
