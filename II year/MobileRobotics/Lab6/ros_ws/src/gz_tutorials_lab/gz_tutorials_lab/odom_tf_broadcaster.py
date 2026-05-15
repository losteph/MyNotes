import rclpy
from rclpy.node import Node

from nav_msgs.msg import Odometry
from geometry_msgs.msg import TransformStamped
from tf2_ros import TransformBroadcaster


class OdometryToTF(Node):
    def __init__(self):
        super().__init__('odometry_to_tf_broadcaster')

        self.tf_broadcaster = TransformBroadcaster(self)
        self.subscription = self.create_subscription(
            Odometry,
            '/model/vehicle_blue/odometry',
            self.odom_callback,
            10
        )
        self.subscription  # prevent unused variable warning

    def odom_callback(self, msg: Odometry):
        t = TransformStamped()
        t.header.stamp = msg.header.stamp
        t.header.frame_id = msg.header.frame_id  # di solito "odom"
        t.child_frame_id = "chassis"  # il frame figlio

        # Copia posizione
        t.transform.translation.x = msg.pose.pose.position.x
        t.transform.translation.y = msg.pose.pose.position.y
        t.transform.translation.z = msg.pose.pose.position.z

        # Copia orientazione
        t.transform.rotation = msg.pose.pose.orientation

        # Pubblica il TF
        self.tf_broadcaster.sendTransform(t)


def main(args=None):
    rclpy.init(args=args)
    node = OdometryToTF()
    rclpy.spin(node)
    node.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()
