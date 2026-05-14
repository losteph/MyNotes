# Lab 4

In questa esercitazione è stato introdotto il concetto di trasformazioni di riferimento (TF2).

L'obiettivo è capire come rappresentare la posizione di un robot rispetto ad altri sistemi di riferimento ed utilizzare queste informazioni per controllare il movomento.

Non basta, quindi, sapere la posizione di un robot ma dobbiamo sapere le posizioni:
- robot rispetto al mondo
- sensore rispetto al robot
- altro robot rispetto al primo

---

Architettura del sistema (flusso dei dati)
```
turtlesim (turtle1) -> pose -> broadcaster -> TF (Transform System: serve per dire dove si trova qualcosa rispetto a qualcos'altro)
static_broadcaster -> TF  (statico: world -> ogetto fisso)
listener -> legge il TF e controlla la turtle2
```

---

Solite procedure di avvio tramite `./run.sh` e facendo il `colcon build` dentro il workspace di ros (come per le esercitazioni precedenti).

Per avviare la simulazione dobbiamo avviare turtlesim:

`ros2 runturtlesim turtlesim_node` da comandare poi con le frecce tramite `ros2 run turtlesim turtle_teleop_key` su un altro terminale.

Oppure (**ottimale**) facendo direttamente `ros2 launch tf2_py_tutorial turtle_tf2_demo_launch.py`.

(Se serve possiamo fare uno spawn manuale tramite `ros2 service call /spawn turtlesim/srv/Spawn "{x: 4.0, y: 2.0, theta: 0.0, name: 'turtle2'}"`).

---

Debug dei topic:
```
ros2 topic list
ros2 topic echo /turtle1/pose
ros2 topic echo /turtle2/cmd_vel
```

Debug TF
```
(vedere trasformazioni)
ros2 run tf2_ros tf2_echo world turtle1
(vedere struttura completa)
ros2 run tf2_tools view_frames
```

---

Visualizzazione grafica tramite `rqt_graph` o `rviz2`.

