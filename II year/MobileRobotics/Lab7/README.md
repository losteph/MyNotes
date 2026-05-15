# Lab7

Introduciamo Nav2 (Navigatio Stack) che permette al robot di localizzarsi, pianificare un percorso, evitare ostacoli e raggiungere un goal. Praticamente il cervello del robot autonomo.

abbiamo clonato delle repo _turtlebot3_ che forniscono il robot pronto con sensori già configurati e la simulazione Gazebo.

Navigation2 gestisce la pianificazione del percorso, il controllo del movimento e l'obstacle avoidance. Cartographer è utilizzato poi per SLAM (crea la mappa) e localizzazione.

le maooe sono composte da un file .pgm (che è un immagine) ed il file .yaml che è la configurazione

---

## Comandi usati

Dopo il solito colcon build del workspace si effettua il set del robot: `export TURTLEBOT3_MODEL=burger` e si avvia la simulazione `ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py` (questo apre Gazebo con il robot).

Avviamo la navigazione con mappa: `ros2 launch nav2_bringup navigation_launch.py use_sim_time:=True map:=/root/ros_ws/src/nome_mappa.yaml`. 

RViz (intefaccia principale): `ros2 launch nav2_bringup rviz_launch.py`.

Per impostare un obiettivo da RViz: cliccare su 2D Goal Pose e scegliere la destinazione (il robot si muoverà da solo).

---

Debug:
```
ros2 topic list
ros2 node list
ros2 topic echo /odom
ros2 topic echo /scan
ros2 run tf2_tools view_frames
echo $TURTLEBOT3_MODEL
```
