# Lab 3

In questa esercitazione abbiamo creato un sistema robotico in ROS2, introducendo:
* interfacce custom (msg e srv)
* nodi cooperativi
* logica di simulazione e controllo

---

## poliba_interfaces

Questo package contiene definizione di messaggi e servizi custom che verranno usati dagli altri nodi; ed è utile per separare i dati dalla logica.

---

## robot_simulation

Questo package contiene i nodi veri e propri:

- robot_sim.py (il *simulatore* che aggirona posizione ed orientazione, simula il controllo batteria e genera una temperatura casuale; ha Subscrivere /unicycle_cmd e Publisher /robot_status)
- velocity_pub.py (il *controllore* invia i comandi al robot, egge lo stato e se la batteria è sotto il 30% ferma il robot; si aggiunge un Service Serve /sum_product)
- battery_alert.py (*monitor* della batteria ed evidenzia in rosso quando è bassa)

Il ciclo:

1. il controller invia la velocità
2. il simulatore aggiorna lo stato
3. lo stato viene pubblicato
4. il controller reagisce (feedback)
5. il monitor stampa

---

## Build e Setup

Come per i lab precedenti bisogna runnare e fare il colcon build nel workspace di ros.

Poi nel terminale 1 avviamo il simulatore `ros2 run robot_simulation robot_sim`, nel 2 il controllore `ros2 run robot_simulation velocity_pub` ed il monitor nel 3 `ros2 run robot_simulation battery_alert`.

---

Comandi utili:

```
ros2 topic list
ros2 topic echo /robot_status
ros2 topic echo /unicycle_cmd

ros2 node list
ros2 service list

ros2 service call /sum_product poliba_interfaces/srv/SumProduct "{a: 3.0, b: 5.0}"
```

---

#### Schema Riassuntivo

```
            +------------------+
            |  velocity_pub    |
            +--------+---------+
                     |
                     v
              /unicycle_cmd
                     |
                     v
            +------------------+
            |   robot_sim      |
            +--------+---------+
                     |
                     v
              /robot_status
                     |
        +------------+------------+
        |                         |
        v                         v
battery_alert           velocity_pub
```

Sistema distribuito con più nodi che comunicano tramite topic e service utilizzando interfacce custom.
