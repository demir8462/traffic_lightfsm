# 🚦 Traffic Light FSM

This project implements a **4-state Traffic Light Controller** using **SystemVerilog** and simulates its behavior using **Questa/ModelSim**.

---

## 📌 Overview

The system controls traffic lights for two directions:

* **Street A (LA)**
* **Street B (LB)**

At any given time, only one street has a green light while the other remains red. The controller uses a **Finite State Machine (FSM)** with timed transitions.

---

## 🔁 FSM States

| State | LA (Street A) | LB (Street B) | Description                   |
| ----- | ------------- | ------------- | ----------------------------- |
| S0    | 🟢 Green      | 🔴 Red        | Traffic flows on Street A     |
| S1    | 🟡 Yellow     | 🔴 Red        | Transition phase for Street A |
| S2    | 🔴 Red        | 🟢 Green      | Traffic flows on Street B     |
| S3    | 🔴 Red        | 🟡 Yellow     | Transition phase for Street B |

### State Sequence

```
S0 → S1 → S2 → S3 → S0
```

---

## ⏱️ Timing

* Yellow states (**S1** and **S3**) last **5 clock cycles**
* Controlled using an internal **counter (timer)**

---

## 📥 Inputs

* `clk` → System clock
* `reset` → Asynchronous reset
* `TAORB` → Traffic indicator

  * `1`: Traffic on Street A
  * `0`: Traffic on Street B

---

## 📤 Outputs

* `LA[2:0]` → Traffic light for Street A (RGB encoding)
* `LB[2:0]` → Traffic light for Street B (RGB encoding)

### Encoding

| Value | Meaning |
| ----- | ------- |
| `001` | Green   |
| `010` | Yellow  |
| `100` | Red     |

---

## 🧠 Design Details

* FSM implemented using **SystemVerilog**
* Clean separation of:

  * State register
  * Next-state logic
  * Output logic
* Internal counter increments only in **yellow states**
* Fully synthesizable design

---

## 🧪 Simulation

Simulated using **Questa/ModelSim**

### Example Waveform

> 📌 Add your waveform screenshot here as `waveform.png`

```
project_folder/
 ├── traffic_light_fsm.sv
 ├── tb_traffic_light_fsm.sv
 ├── waveform.png   ← (add this)
```

---

## 📁 Files

* `traffic_light_fsm.sv` → FSM design
* `tb_traffic_light_fsm.sv` → Testbench

---

## 🚀 Run Simulation

```
vlib work
vlog traffic_light_fsm.sv
vlog tb_traffic_light_fsm.sv
vsim tb_traffic_light_fsm
add wave *
run 500ns
```

---

## ⚙️ Tools Used

* Intel Quartus Prime Lite
* Questa / ModelSim
* SystemVerilog

---

## 📚 Course

Prepared for **ELE432 - Digital Design / FPGA**

---

## 👨‍💻 Author

**Ali Demir**
