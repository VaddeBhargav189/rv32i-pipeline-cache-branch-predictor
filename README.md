# RV32I Pipeline Cache Branch Predictor

## Overview

This project implements a 32-bit RV32I processor in Verilog. The design started as a single-cycle processor and was progressively extended into a 5-stage pipelined architecture with hazard handling, caches, and branch prediction.

The processor has been verified using custom assembly programs, machine code test cases, and simulation waveforms.

## Features

* RV32I Base Integer Instruction Set
* Single-Cycle Processor
* 5-Stage Pipelined Processor
* Hazard Detection Unit
* Data Forwarding Unit
* Direct-Mapped Instruction Cache
* Direct-Mapped Data Cache
* BTB-Based Branch Prediction
* Verilog Testbenches and Functional Verification

## Pipeline Architecture

```text
IF → ID → EX → MEM → WB
```

### IF – Instruction Fetch

* Instruction cache access
* Branch prediction using BTB

### ID – Instruction Decode

* Instruction decoding
* Register file access

### EX – Execute

* ALU operations
* Branch evaluation
* Target address generation

### MEM – Memory Access

* Data cache access
* Load and store operations

### WB – Write Back

* Register write-back

## Implemented Modules

### Hazard Detection Unit

Detects load-use hazards and inserts stalls when required.

### Forwarding Unit

Resolves data hazards by forwarding results from later pipeline stages.

### Instruction Cache

Direct-mapped cache integrated into the instruction fetch stage.

### Data Cache

Direct-mapped cache integrated into the memory stage.

### Branch Target Buffer (BTB)

Predicts branch targets to reduce control hazards and improve pipeline efficiency.

## Verification

| Test                    | Status |
| ----------------------- | ------ |
| Arithmetic Operations   | ✅      |
| Logical Operations      | ✅      |
| Load/Store Instructions | ✅      |
| Branch Instructions     | ✅      |
| Hazard Detection        | ✅      |
| Forwarding              | ✅      |
| Instruction Cache       | ✅      |
| Data Cache              | ✅      |
| Branch Prediction       | ✅      |

## Repository Structure

```text
Architecture/
Simulation_Results/
Design/
Testbenches/


## Simulation Highlights

* Hazard Detection
* Data Forwarding
* Instruction Cache Miss/Hit
* Data Cache Miss/Hit
* BTB Learning and Prediction
* Branch Misprediction Recovery

## Tools

* Verilog HDL
* Xilinx Vivado
* RV32I ISA

```
```
