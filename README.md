# MobileRobotics_Project_Robocup-work_SLAM

Project explanation is given on https://github.com/tirthjagad/MobileRobotics_Project_Robocup-work_SLAM/blob/master/Project_description.md 

Extract the following compressed files in your catkin_ws location.<br/> 
1)src <br/>
2)build <br/>
3)devel <br/>

To launch the scenario use : <br/>
roslaunch youbot_gazebo_robot youbot.launch

To record bag file use: <br/>
rosbag record -o any_name_for_file /odom /base_scan

To run controller goto src folder and then use: <br/>
python youbot_controller.py

In Matlab put recorded bag file name and run the code.

To spawn the objects goto src and use:<br/>
python sdf_spawn.py

To change the Model pose goto src and use:<br/>
python model_state.py


To delete the objects goto src and use:<br/>
python delete_urdf.py



