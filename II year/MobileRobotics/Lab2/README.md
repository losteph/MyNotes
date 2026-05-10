# Lab 2

In questa esercitazione abbiamo imparato a creare nodi ROS2 in Python ed a farli comunicare tra loro usando paradigmi: 

* Publisher / Subscriber (Topic)
* Service / Client

---

Una volta eseguiti i passi della scorsa esercitazione (`./run.sh` in modo tale da avere ros), dobbiamo spostarci nella directory `cd /root/ros_workspace` ed una volta dentro effettuare il `colcon build` e `source install/setup.bash` per caricare i nodi (questa operazione va fatta anche in ogni altro terminale avviato poi tramite `./exec.sh`).

---

### Talking Friends (Publisher / Subscriber)

- Un nodo (talker) pubblica i messaggi su un topic
- Un nodo (listener) li riceve

Dal terminale 1 avviamo `ros2 run talking_friends talker`, nel terminale 2 invece `ros2 run talking_friends listener`.

Potremmo avviare anche tutto contemporaneamente tramite il _launch file_ con il comando `ros2 launch talking_friends friends.launch.py`.

Possiamo modificare il messaggio inviato dal talker poi o da codice o da terminale tramite il comando `ros2 run talking_friends talker --ros-args -p frase:="Nuovo messaggio"`.

---

Altri comandi utili per questa esercitazione:

```
ros2 topic list
ros2 topic echo /topic
ros2 topic info /topic
```

---

### Calculator Friends (Service / Client)

- Il client invia una richiesta
- Il server la elabora e risponde

Dopo aver eseguito comunque le operazioni preliminari precedenti, possiamo avviare invece dei talking_friend questi ultimi in maniera molto simile, tramite: `ros2 run calculator_friends service` dal terminale 1 e `ros2 run calculator_friends client 2 3` dal terminale 2.

L'output atteso sarà una cosa del genere: `Result of add_two_ints: for 2 + 3 = 5`.

---

Altri comandi:

```
ros2 service list
ros2 service type /add_two_ints
ros2 service call /add_two_ints example_interfaces/srv/AddTwoInts: "{a: 5, b: 7}"
```

se il client non funziona controlliamo che il service sia attivo tramite il primo comando citato in questa sezione.

---

#### Cenni Teorici

Un robot usa i topic per i dati continui (come i sensori) ed i service per delle richieste specifiche.

```
TOPIC:
talker → → → topic → → → listener

SERVICE:
client → richiesta → service → risposta → client
```

Ogni nodo fa una sola cosa e può essere riutilizzato. I nodi possono girare sulla stessa macchina o su macchine diverse. 

