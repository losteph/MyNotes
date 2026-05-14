from setuptools import find_packages, setup
import os
from glob import glob

package_name = 'tf2_py_tutorial'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
        (os.path.join('share', package_name, 'launch'), glob('launch/*')),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='root',
    maintainer_email='root@todo.todo',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={
        'console_scripts': [
            'static_turtle_tf2_broadcaster = tf2_py_tutorial.static_turtle_tf2_broadcaster:main',
            'turtle_tf2_broadcaster = tf2_py_tutorial.turtle_tf2_broadcaster:main',
            'turtle_tf2_listener = tf2_py_tutorial.turtle_tf2_listener:main',
        ],
    },
)
