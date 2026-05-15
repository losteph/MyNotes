# Lab 5

In questa esercitazione abbiamo introdotto la modellazionw di un robot in ROS2 usando URDF (Unified Robot Description Format).

Sono stati sviluppati diversi modelli incrementali per comprendere:
- struttura link/joint
- posizionamento (origin)
- materiali
- visualizzazione in RViz

---

#### File
- `myfirst` robot base con un solo link
- `multipleshape` aggiunta di più link e joint
- `origins` uso di trasformazioni (xyz e rpy)
- `materials` introduzione dei colori
- `visual` robot completo con ruote e gripper
- `flexible` aggiunta joint reali (_continous_: rotazione infinta ruote, _revolute_: rotazione limitata gripper, _prismatic_: movimento lineare)
- `physics` aggiunta di collisioni, massa ed inerzia (servirà per una simulazione realistica in Gazebo)
- `macroed` versione intelligente del robot
- `r2d2` robot completo (stile Star Wars)

---

Come ormai sappiamo, dopo aver fatto il `./build.sh` ed il `./run.sh` (assicurandosi che ros funzioni tramite `source opt/ros/jazzy/setup.bash`) poi possiamo spostarci a fare il `colcon build` dentro `/root/ros_workspace` (ed effettuare `source install/setup.bash`).

Poi i nuovi comandi per lanciare il robot saranno:
- `ros2 launch urdf_lab display.launch.py [model]`
- oppure `ros2 run root_state_publisher state_publisher <file.urdf>` per testare un singolo URDF.

---

Per la visualizzazione apriamo `rviz2` agiungendo *RobotModel* (topic `/robot_description`) e *TF* ed impostando il Fixed Frame **base_link** oppure **odom**.

---

Debug:
```
ros2 node list
ros2 topic list
ros2 topic echo /robot_description
ros2 topic echo /joint_states
```
