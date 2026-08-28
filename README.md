# Proyecto 1 — Calculadora de 4 bits en FPGA

ICC3302 Arquitectura de Computadores — Universidad de los Andes, 2026-2

Calculadora de 4 bits descrita en Verilog a nivel de compuertas, implementada
en una FPGA Lattice iCE40 HX1K utilizando la Nandland Go Board.

## Integrantes

- Felix Svensson
- Juan Pablo Saavedra
- Martin Heiremans

## Descripción

El proyecto implementa una calculadora de 4 bits con números con signo en
complemento a dos.

La calculadora permite seleccionar una operación, ingresar dos operandos,
ejecutar la operación y almacenar el resultado en un registro de 4 bits.

También es posible utilizar el resultado de la operación anterior como segundo
operando.

La lógica combinacional fue implementada utilizando compuertas lógicas y
módulos construidos a partir de ellas.

## Operaciones

| Código | Operación | Resultado |
|--------|-----------|-----------|
| `000` | Reset | `R = 0` |
| `001` | Suma | `R = A + B` |
| `010` | Resta | `R = A - B` |
| `011` | Resta inversa | `R = B - A` |
| `100` | Shift left | `R = A << B[1:0]` |
| `101` | Shift right | `R = A >> B[1:0]` |

Todos los cálculos utilizan 4 bits. En caso de overflow se conservan los
cuatro bits menos significativos.

## Controles de la Go Board

Los cuatro botones de la placa se utilizan de la siguiente manera:

| Botón | Función |
|-------|---------|
| `SW1` | Incrementar valor |
| `SW2` | Disminuir valor |
| `SW3` | Confirmar / ingresar valor |
| `SW4` | Utilizar resultado anterior como segundo operando |

Durante la selección de operación, los tres primeros LEDs muestran el código
binario de la operación:

- `D1` = `op[2]`
- `D2` = `op[1]`
- `D3` = `op[0]`

El cuarto LED no se utiliza.

## Displays de 7 segmentos

Los dos displays muestran los operandos y resultados:

- Display 1: signo del número.
- Display 2: magnitud en hexadecimal.

Por ejemplo, el valor `1101`, que corresponde a `-3` en complemento a dos,
se muestra como:

`[-] [3]`

## Flujo de uso

1. Seleccionar la operación utilizando `SW1` y `SW2`.
2. Confirmar la operación con `SW3`.
3. Ingresar el primer operando utilizando `SW1` y `SW2`.
4. Confirmar el primer operando con `SW3`.
5. Ingresar el segundo operando utilizando `SW1` y `SW2`.
6. Opcionalmente, presionar `SW4` para utilizar el resultado anterior como
   segundo operando.
7. Confirmar con `SW3` para ejecutar la operación.
8. El resultado aparece en los displays.
9. Presionar nuevamente `SW3` para volver a seleccionar una operación.

## Estructura del repositorio

- `src/` — módulos Verilog del diseño.
- `tb/` — testbenches.
- `constraints/` — asignación de pines de la Nandland Go Board.
- `docs/` — informe, mapas de Karnaugh y documentación del proyecto.
- `build/` — archivos generados durante síntesis y simulación, no versionados.

## Requisitos de software

Para simulación:

- Icarus Verilog
- GTKWave

Para síntesis y programación de la FPGA:

- Yosys
- nextpnr-ice40
- Project IceStorm

En Ubuntu pueden instalarse con:

```bash
sudo apt update
sudo apt install iverilog gtkwave yosys nextpnr-ice40 fpga-icestorm
