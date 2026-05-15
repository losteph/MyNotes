from launch import LaunchDescription
from launch_ros.actions import Node
from launch.actions import SetEnvironmentVariable, IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import PathJoinSubstitution
from launch_ros.substitutions import FindPackageShare
from ament_index_python.packages import get_package_share_directory

def generate_launch_description():
    pkg_ros_gz_sim = FindPackageShare('ros_gz_sim')
    ros_gz_sim_pkg_path = get_package_share_directory('ros_gz_sim')
    example_pkg_path = FindPackageShare('gz_tutorials_lab')
    gz_launch_path = PathJoinSubstitution([pkg_ros_gz_sim, 'launch', 'gz_sim.launch.py'])

    return LaunchDescription([
        SetEnvironmentVariable(
            'GZ_SIM_RESOURCE_PATH',
            PathJoinSubstitution([example_pkg_path, 'models'])
        ),
        SetEnvironmentVariable(
            'GZ_SIM_PLUGIN_PATH',
            PathJoinSubstitution([example_pkg_path, 'plugins'])
        ),
        IncludeLaunchDescription(
            PythonLaunchDescriptionSource(gz_launch_path),
            launch_arguments={
                'gz_args': [PathJoinSubstitution([example_pkg_path, 'sdf_ws/04-sensors.sdf'])],
                'on_exit_shutdown': 'True'
            }.items(),
        ),

        # Bridge IMU and LiDAR with remapping
        Node(
            package='ros_gz_bridge',
            executable='parameter_bridge',
            arguments=[
                '/imu@sensor_msgs/msg/Imu@gz.msgs.IMU',
                '/lidar@sensor_msgs/msg/LaserScan@gz.msgs.LaserScan',

            ],
            remappings=[
                ('/imu', '/ros_mapped_imu'),
                ('/lidar', '/ros_mapped_lidar'),

            ],
            output='screen'
        ),
    ])
