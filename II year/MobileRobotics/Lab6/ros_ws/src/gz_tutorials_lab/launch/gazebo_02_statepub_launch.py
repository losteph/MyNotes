from launch import LaunchDescription
from launch_ros.actions import Node
from launch.actions import SetEnvironmentVariable, IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import PathJoinSubstitution
from launch_ros.substitutions import FindPackageShare
from ament_index_python.packages import get_package_share_directory
import os

def generate_launch_description():
    pkg_ros_gz_sim = FindPackageShare('ros_gz_sim')
    example_pkg_path = FindPackageShare('gz_tutorials_lab')
    gz_launch_path = PathJoinSubstitution([pkg_ros_gz_sim, 'launch', 'gz_sim.launch.py'])

    # Percorso assoluto allo SDF usato nel launch (stesso file)
    sdf_file_path = os.path.join(
        get_package_share_directory('gz_tutorials_lab'),
        'sdf_ws',
        '05-joint_pub.sdf'
    )

    file_sdf_model = os.path.join(
         get_package_share_directory('gz_tutorials_lab'),
         'sdf_ws',
         '06-simplemodel.sdf'
    )

    # Leggi lo SDF come stringa
    with open(sdf_file_path, 'r') as f:
        robot_description = f.read()

    with open(file_sdf_model, 'r') as f:
        simple_model_description = f.read()

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
                'gz_args': [PathJoinSubstitution([example_pkg_path, 'sdf_ws/05-joint_pub.sdf'])],
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
                '/joint_states@sensor_msgs/msg/JointState@gz.msgs.Model',
                '/model/vehicle_blue/odometry@nav_msgs/msg/Odometry@gz.msgs.Odometry',
            ],
            remappings=[
                ('/imu', '/ros_mapped_imu'),
                ('/lidar', '/ros_mapped_lidar'),
                ('/joint_states', '/joint_states')

            ],
            output='screen'
        ),

        # robot_state_publisher che legge la SDF dal file già usato
        Node(
            package='robot_state_publisher',
            executable='robot_state_publisher',
            output='screen',
            parameters=[{
                'use_sim_time': True,
                'robot_description': simple_model_description
            }]
        ),
        Node(
            package='gz_tutorials_lab',
            executable='odom_tf_broadcaster',
            output='screen',
            parameters=[{
                'use_sim_time': True
            }]
        )
    ])
