clc;clear;close all;

%parsing of bag file
bag = rosbag('youbotfile1_2020-07-19-15-54-41.bag');
ranges = select(bag,'Topic','/base_scan');
odom = select(bag,'Topic','/odom');
odometry = (readMessages(odom,'DataFormat','struct'))';
odometry_transpose = (readMessages(odom,'DataFormat','struct'));
range=(readMessages(ranges,'DataFormat','struct'))';

maxRange = 5; % meters
resolution = 60; % cells per meter

slamObj = lidarSLAM(resolution,maxRange);
slamObj.LoopClosureThreshold =100;
slamObj.LoopClosureSearchRadius = 1;
slamObj.LoopClosureMaxAttempts = 5;
slamObj.MovementThreshold = [0.2 0.3];
firstLoopClosure=false;

angles = linspace(1.5700,-1.5700,150); %Max range and Min range value divided in 150 laser scan interval 
poses{1}=[odometry{1, 1}.Pose.Pose.Position.X odometry{1, 1}.Pose.Pose.Position.Y -odometry{1, 1}.Pose.Pose.Orientation.W];
figure(1)
index=0;
firstTimeLCDetected = false;
for r=2:length(range)
    index=index+1;
    scans{index}=(lidarScan(flip(double(range{1,r}.Ranges)),double(angles)));
    
    current_pose=[odometry{1, r}.Pose.Pose.Position.X odometry{1, r}.Pose.Pose.Position.Y -odometry{1, r}.Pose.Pose.Orientation.W]  ;
    last_pose=[odometry{1, r-1}.Pose.Pose.Position.X odometry{1, r-1}.Pose.Pose.Position.Y -odometry{1, r-1}.Pose.Pose.Orientation.W]  ;
    poses{index}=current_pose-last_pose;
     
    [isScanAccepted, loopClosureInfo, optimizationInfo] = addScan(slamObj,scans{index},poses{index});
  
    if ~isScanAccepted
        continue;
    end
    if optimizationInfo.IsPerformed && ~firstTimeLCDetected
        show(slamObj, 'Poses', 'off');
        hold on;
        show(slamObj.PoseGraph); 
        hold off;
        firstTimeLCDetected = true;
        drawnow
    end
    
end
for t=1:10:length(odometry) %Dead Reckoning path loop based on odemetry Poses
     deadreckoning_poses=[odometry{1, t}.Pose.Pose.Position.X odometry{1, t}.Pose.Pose.Position.Y -odometry{1, t}.Pose.Pose.Orientation.W];
     subplot(2,2,2);
hold on 
plot(deadreckoning_poses(1),deadreckoning_poses(2),'.')
title('Dead Reckoning path');

end

subplot(2,2,1);
hold on
show(slamObj)
title({'Final Built Map of the Environment', 'Trajectory of the Robot'})

[scans, optimizedPoses]  = scansAndPoses(slamObj); %Occupancy Grid Map Generation
map = buildMap(scans, optimizedPoses, resolution, maxRange);

subplot(2,2,3);
hold on 
show(map)
title('Occupancy Grid Map Built Using Lidar SLAM');



  