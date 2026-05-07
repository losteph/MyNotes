# Lab 1
In questa esercitazione abbiamo visto come creare un Dockerfile. 

Inoltre abbiamo visto come è possibile creare dei file per evitare di scrivere ogni volta 
da terminale i vari comandi come `docker build --rm -t ros:lab1 -f Dockerfile.lab1 .` che se inseriti
in un unio file poi possono essere runnati direttamente da li, ad esempio lanciando  `./build.sh` 
(ovviamente controllando che si è nella directory corretta).

Poi abbiamo usato  `./run.sh` per creare il container ed entrare all'interno. Per entrare inveece in un container già
attivo possiamo avviare da un altro terminale  `./exec.sh`.

Certe volte non si hanno i permessi per avviare i comandi seguenti, quindi sarà necessario fornirli tramite  `chmod +x *.sh`.

---

Per usare ros, una volta avviato il container è buona pratica (da fare in ogni terminale) runnare il comando  `source /opt/ros/humble/setup.bash` 
per assicurarsi un corretto funzionamento (certe volte potrebbe non trovare la directory in automatico e fornire errori, non trovando quindi i topic i nodi o altro).

---

Per avviare turtlesim si usa  `ros2 run turtlesim turtlesim_node`.

Per poi controllare la tartaruga creata nel simulatore bisogna eseguire da un altro terminale  `ros2 run turtlesim turtle_teleop_key`.

---

Altri comandi visti:

* `ros2 node list`
*  `ros2 node info /turtlesim`
* `ros2 topic list`
* `ros2 topic echo /turtle1/pose`
* `ros2 topic pub /turtle1/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.0}, angular: {z: 1.0}}"`
* `ros2 service list`

 Per spawnare una nuova tartaruga:
 * `ros2 service call /spawn turtlesim/srv/Spawn "{x: 2.0, y: 2.0, theta: 0.0, name: 'turtle2'}"`
 
 Per eliminare una tartaruga:
 * `ros2 service call /kill turtlesim/srv/Kill "{name: 'turtle1'}"`
