import rclpy
from rclpy.node import Node
from poliba_interfaces.msg import RobotStatus

class RobotStatusLogger(Node):
    def __init__(self):
        super().__init__('robot_status_logger')
        self.subscription = self.create_subscription(
            RobotStatus,
            '/robot_status',
            self.status_callback,
            10
        )

    def status_callback(self, msg: RobotStatus):
        battery = msg.battery_level
        temperature = msg.temperature
        position = msg.position
        orientation = msg.orientation
        cmd = msg.command

        battery_str = f"{battery:.1f}%"
        if battery < 30.0:
            battery_str = f"\033[91m{battery_str} ⚠ LOW BATTERY\033[0m"  # red + warning

        self.get_logger().info(
            f"[RobotStatus]\n"
            f"  Battery:     {battery_str}\n"
            f"  Temperature: {temperature:.1f}°C\n"
            f"  Position:    ({position.x:.2f}, {position.y:.2f})\n"
            f"  Orientation: {orientation:.2f} rad\n"
            f"  Command:     v={cmd.linear_velocity:.2f}, w={cmd.angular_velocity:.2f}"
        )

def main(args=None):
    rclpy.init(args=args)
    node = RobotStatusLogger()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()