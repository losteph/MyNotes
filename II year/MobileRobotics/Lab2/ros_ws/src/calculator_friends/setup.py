from setuptools import find_packages, setup

package_name = 'calculator_friends'

setup(
    name=package_name,
    version='0.0.0',
    packages=find_packages(exclude=['test']),
    data_files=[
        ('share/ament_index/resource_index/packages',
            ['resource/' + package_name]),
        ('share/' + package_name, ['package.xml']),
    ],
    install_requires=['setuptools'],
    zip_safe=True,
    maintainer='root',
    maintainer_email='root@todo.todo',
    description='TODO: Package description',
    license='TODO: License declaration',
    tests_require=['pytest'],
    entry_points={ ## REMEMBER TO ADD THESE
        'console_scripts': [
            'calculator = calculator_friends.service_server:main',
            'calculator_client = calculator_friends.service_client:main',
        ],
    },
)