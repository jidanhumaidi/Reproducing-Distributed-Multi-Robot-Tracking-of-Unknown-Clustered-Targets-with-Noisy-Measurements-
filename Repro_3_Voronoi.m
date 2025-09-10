% ========================================================
% Distributed Multi-Robot Tracking (Voronoi + HD Autosave)
% ========================================================
clear; clc; close all;

%% Parameters
N_targets   = 40;
N_robots    = 6;
area_size   = 10;
iterations  = 30;
cluster_std = 0.5;

%% Generate clustered targets
centers = [3 7; 8 8];
targets = [];
for i = 1:size(centers,1)
    cluster = centers(i,:) + cluster_std*randn(N_targets/2,2);
    targets = [targets; cluster];
end

%% Initialize robots randomly
robots = area_size*rand(N_robots,2);

%% Setup figure (Full HD)
fig = figure('Position',[100 100 1920 1080],'Color','w');
v = VideoWriter('voronoi_tracking_hd.mp4','MPEG-4');
v.FrameRate = 10; % smoother
open(v);

%% Simulation loop
for t = 1:iterations
    clf;
    
    % Draw targets
    plot(targets(:,1), targets(:,2),'bo','MarkerFaceColor','b'); hold on;
    
    % Voronoi partition
    [vx, vy] = voronoi(robots(:,1), robots(:,2));
    plot(vx, vy, 'k--','LineWidth',1.2); % Voronoi edges
    
    % Update robots
    for r = 1:N_robots
        dists = pdist2(targets, robots(r,:));
        nearby = targets(dists < 2,:);
        
        if ~isempty(nearby)
            centroid = mean(nearby,1);
            dir = centroid - robots(r,:);
            if norm(dir) > 0
                robots(r,:) = robots(r,:) + 0.15*dir/norm(dir);
            end
        end
        
        plot(robots(r,1), robots(r,2),'rs','MarkerFaceColor','r','MarkerSize',14);
    end
    
    % Title & axis
    title(sprintf('Voronoi-based Multi-Robot Tracking - Iter %d',t),'FontSize',20);
    axis([0 area_size 0 area_size]); 
    axis square;
    grid on;
    set(gca,'FontSize',16);
    
    % Save frame in HD
    frame = getframe(fig);
    writeVideo(v, frame);
end

%% Close video
close(v);
disp('✅ Saved HD animation as voronoi_tracking_hd.mp4');
