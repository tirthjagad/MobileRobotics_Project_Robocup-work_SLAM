# MobileRobotics_Project_Robocup-work_SLAM

Extract the following compressed files in your catkin_ws location. 
1)src
2)build
3)devel

To launch the scenario use :
roslaunch youbot_gazebo_robot youbot.launch

To record bag file use:
rosbag record -o any_name_for_file /odom /base_scan

To run controller goto src folder and then use:
python youbot_controller.py

In Matlab put recorded bag file name:

run the code.



