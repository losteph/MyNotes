# Lab6

In questa esercitazione siamo passati dalla semplice visualizzazione cinematica (RViz) alla simulazione dinamica in ambiente 3D con fisica reale, usando **Gazebo Harmonic** (la versione è quella raccomandata per ros jazzy).

A differenza di RVidz in cui abbiamo usato i file URDF, il nuovo standard per descrivere mondi complessi e robot i Gazebo è l'SDF.

Gazebo ha ormai un proprio sistema di topic e servizi completamente indipendenti e disaccoppiati dai topic di ros.

Poichè poi ros e gz parlano due lingue diverse abbiamo aggiunto un pacchetto che funge da traduttore bidirezionale tra i topic di ROS2 e quelli di Gazebo (*ros_gz_bridge*).

---

### Comandi Nativi Gazebo

Prima di unirli insieme, vediamo i nuovi comandi. 
- avviare un mondo simulato (SDF): `gz sim src/gz_tutorials_lab/sdf_ws/01-base_world.sdf`
- spawn di un URDF in runtime all'interdo di Gazebo: `gz service -s /world/card_world/create --reqtype gz.msg.EntityFactory --reptype gz.msgs.Boolean --timeout 1000 --req 'sdf_filename: "/src/urdf_lab/urdf_ws/07-physics.urdf", name: "urdf_model", pose: {position: {x: 2.0, y: 3.0, z: 0.5}}'`
- ispezionare i topic interni a Gazebo: `gz topic -e -t "/lidar/points"` o anche `gz topic -t "/cmd_vel" -m gz.msgs.Twist -p "linear: {x: 0.5}, angular: {z: 0.05}"`

---

## Integraione ROS2 + Gazebo

```
ros2 run ros_gz_bridge parameter_bridge /<gz_topic>@<ros_msg>@<gz_msg> --ros-args --remap /<gz_topic>:=/<ros_topic>
```

esempio per LiDAR e IMU: `ros2 run ros_gz_bridge parameter_bridge /imu@sensor_msgs/msg/Imu@gz.msgs.IMU /lidar@sensor_msgs/msg/LaserScan@gz.msgs.LaserScan --ros-args --remap /imu:=/ros_mapped_imu --remap /lidar:=/ros_mapped_lidar`

---

Per avviare la simulazione completa conviene usare il launch file per unificare ed integrare conemporaneamente Gazebo, RViz, TF invece di avere comandi sparsi.

`ros2 launch gz_tutorials_lab gazebo_02_statepub_launch.py`
