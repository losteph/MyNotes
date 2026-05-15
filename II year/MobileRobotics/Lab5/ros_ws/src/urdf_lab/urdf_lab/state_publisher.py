from math import sin, cos, pi
import rclpy
from rclpy.node import Node
from rclpy.qos import QoSProfile
from geometry_msgs.msg import Quaternion
from sensor_msgs.msg import JointState
from tf2_ros import TransformBroadcaster, TransformStamped

class StatePublisher(Node):

    def __init__(self):
        super().__init__('state_publisher')

        qos_profile = QoSProfile(depth=10)
        self.joint_pub = self.create_publisher(JointState, 'joint_states', qos_profile)
        self.broadcaster = TransformBroadcaster(self, qos=qos_profile)

        self.get_logger().info(f"{self.get_name()} started")

        # Constants
        self.degree = pi / 180.0

        # Robot state variables
        self.tilt = 0.0
        self.tinc = self.degree
        self.swivel = 0.0
        self.angle = 0.0
        self.height = 0.0
        self.hinc = 0.005

        # Messages
        self.odom_trans = TransformStamped()
        self.odom_trans.header.frame_id = 'odom'
        self.odom_trans.child_frame_id = 'axis'

        self.joint_state = JointState()
        self.joint_state.name = ['swivel', 'tilt', 'periscope']

        # Timer at 30 Hz
        timer_period = 1.0 / 30.0  # seconds
        self.timer = self.create_timer(timer_period, self.timer_callback)

    def timer_callback(self):
        now = self.get_clock().now()
        self.joint_state.header.stamp = now.to_msg()
        self.joint_state.position = [self.swivel, self.tilt, self.height]

        # Update transform header
        self.odom_trans.header.stamp = now.to_msg()
        self.odom_trans.transform.translation.x = cos(self.angle) * 2
        self.odom_trans.transform.translation.y = sin(self.angle) * 2
        self.odom_trans.transform.translation.z = 0.7
        self.odom_trans.transform.rotation = euler_to_quaternion(0, 0, self.angle + pi/2)

        # Publish
        self.joint_pub.publish(self.joint_state)
        self.broadcaster.sendTransform(self.odom_trans)

        # Update state variables
        self.tilt += self.tinc
        if self.tilt < -0.5 or self.tilt > 0.0:
            self.tinc *= -1

        self.height += self.hinc
        if self.height > 0.2 or self.height < 0.0:
            self.hinc *= -1

        self.swivel += self.degree
        self.angle += self.degree / 4

def euler_to_quaternion(roll, pitch, yaw):
    qx = sin(roll/2) * cos(pitch/2) * cos(yaw/2) - cos(roll/2) * sin(pitch/2) * sin(yaw/2)
    qy = cos(roll/2) * sin(pitch/2) * cos(yaw/2) + sin(roll/2) * cos(pitch/2) * sin(yaw/2)
    qz = cos(roll/2) * cos(pitch/2) * sin(yaw/2) - sin(roll/2) * sin(pitch/2) * cos(yaw/2)
    qw = cos(roll/2) * cos(pitch/2) * cos(yaw/2) + sin(roll/2) * sin(pitch/2) * sin(yaw/2)
    return Quaternion(x=qx, y=qy, z=qz, w=qw)

def main(args=None):
    rclpy.init(args=args)
    node = StatePublisher()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.destroy_node()
        rclpy.shutdown()

if __name__ == '__main__':
    main()
