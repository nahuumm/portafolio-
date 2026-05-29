+++
title = "Práctica 2: Programación Orientada a Objetos"
date = 2026-04-03
draft = false
+++

**Nombre:** Diego Nahum Nuñez García  
**Materia:** Paradigmas de la Programación  
**Profesor:** M.I. José Carlos Gallegos Mariscal  

Repositorio: https://github.com/nahuumm/estacionamiento_poo

## 1. Introducción

Esta práctica implementa un sistema de gestión de estacionamiento aplicando los pilares de la Programación Orientada a Objetos (POO) en Python, integrando la lógica en una interfaz web con Flask bajo un patrón MVC.

## 2. Conceptos de POO

### Clase y Objeto
- **Clase:** Plantilla que define atributos y comportamientos. Ejemplo: `Vehicle` define que todo vehículo tiene placas y tipo.
- **Objeto:** Instancia específica. Ejemplo: un vehículo con placas `ABC-123`.

### Encapsulamiento
Oculta el estado interno de un objeto. `ParkingLot` mantiene `_spots` como privado; para ocupar un lugar se usa `enter()`, que valida disponibilidad antes de modificar.

### Abstracción
`RatePolicy` define qué debe hacer una política de cobro sin especificar cómo.

### Herencia
`Car` y `Motorcycle` heredan de la clase base `Vehicle`.

### Polimorfismo
El método `calculate()` puede ejecutar `HourlyRatePolicy` o `FlatRatePolicy` de forma transparente.

## 3. Implementación MVC con Flask

- **Model:** Clases del dominio (`Vehicle`, `Ticket`, `ParkingLot`).
- **View:** Plantillas HTML con Jinja2.
- **Controller:** Rutas en `app.py`.

Rutas principales:
- `GET /` — Dashboard con ocupación y tickets activos.
- `POST /entry` — Registra entrada de vehículo.
- `POST /exit` — Procesa salida y calcula cobro.

## 4. Conclusiones

La POO ofrece ventajas significativas frente a la programación estructurada:

- **Mantenibilidad:** Cambiar reglas de cobro solo requiere modificar `RatePolicy`.
- **Escalabilidad:** La herencia facilita agregar nuevos tipos de vehículos.
- **Robustez:** El encapsulamiento protege datos críticos de modificaciones inválidas.