# launchfile for the talking_friends package
# This file is part of the talking_friends package
# nodes are publisher_member_function and subscriber_member_function

from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        Node(
            package='talking_friends',
            executable='talker',
            name='talker_poliba',
            output='screen',
            parameters=[{'frase': 'Hello, poliba!'}]
        ),
        Node(
            package='talking_friends',
            executable='listener',
            name='listener_poliba',
            output='screen'
        )
    ])