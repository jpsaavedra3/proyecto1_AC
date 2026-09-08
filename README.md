# Proyecto 1 — Calculadora de 4 bits

ICC3302 Arquitectura de Computadores · Grupo 15

## Requisitos

[OSS CAD Suite](https://github.com/YosysHQ/oss-cad-suite-build). Antes de cualquier comando hay que cargar su ambiente:

```bash
source <ruta>/oss-cad-suite/environment
```

## Simular

```bash
mkdir -p build

iverilog -g2012 -Wall -s demo_tb -o build/demo src/*.v sim/demo_tb.v
vvp build/demo
```

Los valores de las operaciones se editan en el bloque marcado `VALORES` dentro de `sim/demo_tb.v`.

Otros testbenches disponibles:

```bash
iverilog -g2012 -Wall -s alu4_tb -o build/t1 src/*.v sim/alu4_tb.v && vvp build/t1
iverilog -g2012 -Wall -s calculator_tb -o build/t2 src/*.v sim/calculator_tb.v && vvp build/t2
iverilog -g2012 -Wall -s debouncer_tb -o build/t3 src/*.v sim/debouncer_tb.v && vvp build/t3
iverilog -g2012 -Wall -s calculator_top_tb -o build/t4 src/*.v sim/calculator_top_tb.v && vvp build/t4
```

| Testbench | Qué prueba |
|---|---|
| `alu4_tb` | Las 6 operaciones, 1536 casos |
| `calculator_tb` | Flujo completo con botones |
| `debouncer_tb` | Filtro de rebotes |
| `calculator_top_tb` | Sistema completo (~2 min) |

## Ver las formas de onda

```bash
gtkwave build/demo.vcd
```

## Cargar en la FPGA

```bash
yosys -p "read_verilog src/*.v; synth_ice40 -top calculator_top \
          -dffe_min_ce_use 4 -json build/top.json; stat"

nextpnr-ice40 --hx1k --package vq100 --json build/top.json \
              --pcf constraints/go_board.pcf --asc build/top.asc

icepack build/top.asc build/top.bin
iceprog build/top.bin
```

En WSL, antes de `iceprog` hay que pasar el USB a Linux desde PowerShell:

```powershell
usbipd bind --busid <busid>          # una sola vez, como administrador
usbipd attach --wsl --busid <busid>  # cada vez que se conecta la placa
```