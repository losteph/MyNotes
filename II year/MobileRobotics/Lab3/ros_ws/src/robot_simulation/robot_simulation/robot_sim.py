import rclpy
from rclpy.node import Node
import random
import math

from poliba_interfaces.msg import UnicycleCmd, RobotStatus
from geometry_msgs.msg import Point

class RobotSimulator(Node):
    def __init__(self):
        super().__init__('robot_simulator')

        # Subscriber: receive unicycle commands
        self.subscription = self.create_subscription(
            UnicycleCmd,
            '/unicycle_cmd',
            self.cmd_callback,
            10)

        # Publisher: robot status
        self.publisher = self.create_publisher(RobotStatus, '/robot_status', 10)

        # Timer at 10 Hz (1/10 seconds)
        self.timer = self.create_timer(0.1, self.update_status)

        # robot state
        self.last_cmd = UnicycleCmd()
        self.position = Point()
        self.orientation = 0.0  
        self.battery = 100.0  

    def cmd_callback(self, msg: UnicycleCmd):
        self.last_cmd = msg

    def update_status(self):
        dt = 0.1  # seconds

        # Extract command values
        v = self.last_cmd.linear_velocity
        w = self.last_cmd.angular_velocity

        # integrating orientation and position (dead reckoning)
        self.orientation += float(w) * dt
        dx = float(v) * math.cos(self.orientation) * dt
        dy = float(v) * math.sin(self.orientation) * dt
        self.position.x += dx
        self.position.y += dy

        # battery drain proportional to the speed
        self.battery = max(0.0, self.battery - 0.5*(abs(v) + abs(w)))

        # Simulated temperature fluctuation
        temperature = 40.0 + random.uniform(-2.0, 2.0)

        # Create and publish RobotStatus
        status_msg = RobotStatus()
        status_msg.battery_level = float(self.battery)
        status_msg.temperature = float(temperature)
        status_msg.command = self.last_cmd
        status_msg.position = self.position
        status_msg.orientation = float(self.orientation)

        self.publisher.publish(status_msg)

        self.get_logger().info(
            f"Status: pos=({self.position.x:.2f}, {self.position.y:.2f}), "
            f"θ={self.orientation:.2f}, battery={self.battery:.1f}%"
        )

def main(args=None):
    rclpy.init(args=args)
    node = RobotSimulator()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()