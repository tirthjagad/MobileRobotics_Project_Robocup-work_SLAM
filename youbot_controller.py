#!/usr/bin/env python

import rospy
import rosbag
import time

from sensor_msgs.msg import LaserScan
from nav_msgs.msg import Odometry
from geometry_msgs.msg import Twist
from geometry_msgs.msg import Pose
from std_msgs.msg import Float64


class pubsub():
    
    def __init__(self):

        #subscribing into laserdata
        self.laser_scan = rospy.Subscriber('/base_scan',LaserScan,self.scan)
        
        #publishing the velocity
        self.mov= rospy.Publisher('/cmd_vel',Twist,queue_size=1)
        self.speed = Twist()
        

    #laserscanning and finding the wall
    def scan(self,laserdata):
        global ctrl
        self.w = False
        self.vx = self.vy = self.vw= 0.0
        scan_data = list(laserdata.ranges)
      

        if not ctrl: #straight motion
            self.speed.linear.x = 0.3
            self.speed.linear.y = 0.0
            self.speed.angular.z= 0.0
            self.mov.publish(self.speed)
            if min(scan_data[60:90]) < 0.4 :
                self.speed.linear.y = 0.0
                self.speed.linear.x = 0.0
                self.speed.angular.z = 0.0
                self.mov.publish(self.speed)
                self.w = True
            else:
                pass
        else:
            self.w = True

        if self.w:
            
            if (min(scan_data[80:90]) < 0.6) and (min(scan_data[149:150]) < 0.85) : #object in the front turn right
                self.vx = 0.0
                self.vy = 0.0
                self.vw = -0.35
                   
            elif min(scan_data[149:150])> 0.8 and min(scan_data[80:90])< 0.8: #robot very near to the reference wall
                self.vx = 0.0
                self.vy = 0.0
                self.vw = -0.4
                
            elif min(scan_data[147:148])< 0.5: #robot very near to the reference wall
                self.vx = 0.0
                self.vy = 0.0
                self.vw = -0.2
               
            else:                 #straight motion
                self.vx = 0.15
                self.vy = 0.0
                self.vw = 0.0
                   
            self.control()
        
        
    def control(self):
        global ctrl
        ctrl = True
        
        if self.w and ctrl:
            self.speed.linear.x = self.vx
            self.speed.linear.y = self.vy
            self.speed.angular.z = self.vw
            self.mov.publish(self.speed)



if __name__ == '__main__':
    ctrl = False
    rospy.init_node('youbot')
    pubsub()
    rospy.spin()
    
    
                
