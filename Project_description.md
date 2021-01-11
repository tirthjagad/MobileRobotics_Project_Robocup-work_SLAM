#Introduction - Gazebo Robot@Work scenario and demonstration of SLAM Algorithm 
The main goal of this project is to demonstrate SLAM(Simultaneously Localization and Mapping) Algorithm with youbot for the scenario which is based on Robot@Work in Gazebo. In SLAM it is necessary to estimate pose of the robot and the map of the environment at the same time. 

SLAM is considered a fundamental problem for robots to become truly autonomous.SLAM is central to a range of indoor, outdoor, in-air and underwater applications for both manned and autonomous vehicles. 


#Milestone Completation
1. Installation and Runing of Gazebo in Linux
Installed Ubantu on laptop and dowanloaded Gazebo 9 with supported packages to run Gazebo.<br />

2. Youbot Launch file in Gazebo''<br />
Dowanloaded youbot_description package from github (https://github.com/youbot/youbot_description) and youbot_simulation(https://github.com/mas-group/youbot_simulation) package to build gazebo world and link youbot to that environment.

''Creation of custom scenario in Gazebo''<br />
Created a URDF file to build a scenario and in that arena size and wall specification are given as per rule book (https://github.com/robocup-at-work/rulebook ) .

''Startup script with ROSBAG''<br />
Command line instruction (rosbag record -o youbotfile1 /odom /base_scan) is used for collecting odometry and lase scan data.

''Controller for youbot''<br />
Python script with publish subscribe of laser scan ranges and velocity data to moved robot around environment and collected ranges and pose data for the SLAM implementation.

''Demonstration of SLAM''<br />
MATLAB pose graph-based SLAM algorithm is used for the SLAM demonstration as per practical 5.   

 ''Spawning and deleting of objects through python script and then Demonstration of SLAM''<br />
Gazebo ROS services spawn_model , set_model_state and delete_model are used for the spawning and deleting objects in environment.
 

=Problems encountered during work=
1) Firstly, I installed ubuntu as a subsystem of windows and in that, I installed ROS Melodic and other packages for the practicals. I installed  youbot_desciription and yooubot_simulation package in WSL but it was taking so much time to open gazebo and mostly gazebo was crashing then I installed Ubuntu OS separately and installed ROS Melodic, Gazebo, and youbot packages.
2) Python script for controlling of youbot needed try and error methods to set the speed and conditions for the movement of the robot in the environment.
3) To perform SLAM I tried gmapping  but not able to get the proper result so then I switch to MATLAB pose graph-based SLAM algorithm
4) In MATLAB for the SLAM algorithm Map resolution, Loop closure threshold, Loop closure range, Loop closure Max attempts, Movement threshold, are the parameters that needed try and error method and much time to set the proper value and to achieve proper graph result.

=Test Result=
Recording of topic /odom for pose data and /base_scan for ranges data in ROSBAG with python script for controlling youbot around environment.<br/>
https://youtu.be/c7pv2CPfr88

By the python script objects were spawned in the environment and then ROSBAG file generated to demonstrate SLAM.
https://youtu.be/tQC2mOZRKYM

By the python script, the Model state can be changed and it is possible to delete the objects. 
https://youtu.be/kQAceafS1hA

MATLAB SLAM 
[[image:https://raw.githubusercontent.com/tirthjagad/SLAM/master/finalfigure_SLAM.jpg|20px|frameless|caption]]

Spawn Objects MATLAB SLAM
[[image:https://raw.githubusercontent.com/tirthjagad/MobileRobotics_Project_Robocup-work_SLAM/master/spawnslam.jpg|20px|frameless|caption]]
=Project Files=
https://github.com/tirthjagad/MobileRobotics_Project_Robocup-work_SLAM

=Conclusion=
In this project SLAM algorithm with simple controller is performed  with spawning and deleting of objects but Side walls ,complicated objects are not taken into consideration in the environment. 

=References=
1) http://ais.informatik.uni-freiburg.de/teaching/ss12/robotics/slides/12-slam.pdf
2) https://de.mathworks.com/help/nav/ug/implement-simultaneous-localization-and-mapping-with-lidar-scans.html
3) https://de.mathworks.com/help/ros/ref/rosbag.html
