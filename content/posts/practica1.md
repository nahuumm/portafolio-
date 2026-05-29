+++
date = '2026-02-20T21:23:54-08:00'
draft = false
title = 'Practica1: Elementos básicos de los lenguajes de programación'
+++

**Materia:** 40032 - Paradigmas de la Programación  
**Docente:** M.I. José Carlos Gallegos Mariscal  
**Alumno:** Diego Nahum Nuñez Garcia  
**Matrícula:** 379595  
**Grupo:** 941

---

# Reporte de Práctica 01: Cola de impresión en lenguaje C

## 1. Introducción
Durante esta práctica se construyó un simulador de cola de impresión utilizando el lenguaje C. El propósito central fue poner en práctica una estructura FIFO (First-In, First-Out) para administrar trabajos de impresión. El desarrollo partió de un arreglo estático de capacidad fija y fue migrando hacia una lista enlazada con memoria dinámica gestionada mediante `malloc` y `free`. Como resultado final se logró una simulación visual en consola que incorpora control de tiempos, un sistema de prioridades y un módulo de estadísticas.

## 2. Diseño

### Definición de PrintJob_t
La estructura `PrintJob_t` almacena los datos esenciales de cada trabajo de impresión:
* **id:** Número único autoincremental que identifica cada trabajo.
* **usuario y documento:** Cadenas de caracteres que indican el origen y el nombre del archivo a imprimir.
* **paginas_total, paginas_restantes y copias:** Valores numéricos que controlan el avance y la simulación de la impresión.
* **prioridad:** Enumerador (`Prioridad_t`) con los valores `NORMAL` (0) o `URGENTE` (1).
* **estado:** Enumerador (`Estado_t`) que puede tomar los valores `EN_COLA`, `IMPRIMIENDO`, `COMPLETADO` o `CANCELADO`.
* **ms_por_pagina:** Valor entero que determina el retardo entre páginas durante la simulación.

### Modelos de la Cola
* **Cola Dinámica (`QueueDynamic_t`):** Se basa en nodos (`Node_t`) enlazados entre sí. Cuenta con punteros `head` (frente) y `tail` (final), un campo `size` para rastrear el tamaño actual, y variables estadísticas integradas (`total_completados` y `total_paginas_impresas`).

## 3. Implementación
* **qd_enqueue:** Se adaptó para manejar prioridades. Cuando el trabajo entrante es `URGENTE`, la función recorre la lista e inserta el nodo inmediatamente después del último trabajo urgente existente, adelantándose a los trabajos normales. En todo momento se verifica que `malloc` no retorne `NULL`.
* **qd_peek:** Permite consultar el trabajo en el frente de la cola sin extraerlo ni modificar la estructura.
* **qd_dequeue:** Extrae el nodo del frente (`head`), transfiere su contenido, actualiza el puntero `head` al siguiente nodo y libera la memoria con `free`.
* **Decisiones relevantes:** Se descartó el uso de `scanf` por sus vulnerabilidades conocidas. En su lugar se implementó la función `valid_num`, que emplea `fgets` para leer la entrada como cadena y valida carácter por carácter con `isdigit` que el valor ingresado sea exclusivamente numérico.

## 4. Demostración de Conceptos

### 4.1. Alcance y duración
El código refleja diferentes tipos de alcance y duración de variables:
1. **Global / Static:** `static int generador_id = 1;` tiene alcance limitado al archivo actual gracias al modificador `static`, pero su duración es estática, por lo que conserva y actualiza su valor durante toda la ejecución sin reiniciarse.
2. **Local (Automática):** La variable `int opcion` dentro de `main` tiene alcance y vida restringidos a esa función.
3. **Memoria Dinámica:** El puntero `Node_t* nuevo` en `qd_enqueue` es local, pero el bloque de memoria reservado por `malloc` reside en el *heap* y persiste hasta que `qd_dequeue` lo libera explícitamente con `free`.

### 4.2. Contratos de funciones
C permite establecer contratos explícitos entre funciones:
* `int qd_enqueue(QueueDynamic_t* q, PrintJob_t job)` recibe un puntero mutable porque su contrato implica modificar los enlaces de la cola.
* `int qd_peek(const QueueDynamic_t* q, PrintJob_t* out)` recibe un puntero constante (`const`), lo que garantiza a nivel de compilador que la función únicamente consultará la estructura sin alterarla.

## 5. Respuestas a Preguntas Guía

1. **¿Dónde guardaste el contador de id y por qué?** Se declaró como variable global de archivo con `static int generador_id = 1;`. Esta decisión permite que el valor persista entre llamadas sucesivas, asegurando que cada trabajo reciba un identificador único e incremental sin exponer la variable al resto del proyecto.

2. **En tu versión dinámica: ¿qué función es responsable de liberar memoria? ¿cómo lo verificas?** La liberación de cada nodo ocurre dentro de `qd_dequeue` al extraer un trabajo. Adicionalmente, `qd_destroy` recorre la cola llamando a `dequeue` repetidamente hasta vaciarla por completo, evitando fugas al cerrar el programa. La verificación consiste en confirmar que cada `malloc` en `enqueue` tiene un camino lógico garantizado hacia el `free` en `dequeue`.

3. **¿Qué invariantes mantiene tu cola?** El campo `size` siempre refleja el número exacto de nodos activos. Cuando la cola está vacía, tanto `head` como `tail` son `NULL` y `size` es cero. Respecto a prioridades, ningún trabajo `URGENTE` puede quedar posicionado detrás de un trabajo `NORMAL`.

4. **¿Por qué peek no debe modificar la cola?** Su propósito es exclusivamente de consulta: conocer quién encabeza la cola sin alterar su estado. Modificar la estructura sin una extracción formal corrompería los punteros `head` y `tail` y el flujo lógico del programa.

5. **Si el programa falla al agregar trabajos, ¿cómo distingues entre "cola llena" y "entrada inválida"?** Ambos casos se detectan en etapas diferentes. Las entradas inválidas son rechazadas de inmediato por `valid_num`, que no permite continuar hasta recibir un dato correcto. La falla al reservar memoria se detecta cuando `qd_enqueue` retorna `0` porque `malloc` devolvió `NULL`.

## 6. Mejoras Implementadas
Se incorporaron con éxito tres de las mejoras propuestas:
* **Prioridad:** Se definió el enum `Prioridad_t`. Al encolar un trabajo `URGENTE`, la lista se recorre para insertar el nodo delante de todos los trabajos normales, respetando el orden FIFO entre los propios urgentes.
* **Robustez de entrada:** Se eliminó `scanf` por completo. La función `valid_num` lee la entrada con `fgets`, elimina el salto de línea y verifica con `isdigit` que no haya caracteres no numéricos antes de realizar la conversión.
* **Estadísticas:** La estructura `QueueDynamic_t` fue extendida para acumular `total_completados` y `total_paginas_impresas`. Al concluir la simulación completa de la cola (Opción 4), se despliega un reporte estadístico del lote procesado.

## 7. Análisis Comparativo

La transición de memoria estática a memoria dinámica representó un cambio de paradigma significativo en el desarrollo de esta práctica. No se trató únicamente de un ajuste sintáctico, sino de una transformación profunda en la eficiencia algorítmica y la flexibilidad del simulador.

**Memoria Estática (Arreglos Fijos)**  
El modelo inicial con arreglo de tamaño fijo (`MAX_JOBS`) resultó simple y seguro: al reservarse la memoria en tiempo de compilación, se eliminan por completo los riesgos de fugas. Sin embargo, presenta limitaciones críticas:
1. **Extracción ineficiente:** Mantener el frente en el índice `0` obliga a desplazar todos los elementos restantes tras cada `dequeue`, lo que implica una complejidad de $O(n)$ que se degrada conforme crece la cola.
2. **Rigidez espacial:** La capacidad está fijada por una constante. Con poca carga se desperdicia memoria; con alta demanda se rechazan trabajos aunque el sistema tenga recursos disponibles.

**Memoria Dinámica (Lista Enlazada)**  
La migración a nodos dinámicos administrados con punteros `head` y `tail` resolvió las limitantes anteriores, aunque introdujo nuevas responsabilidades:
1. **Eficiencia algorítmica:** El `dequeue` pasó de $O(n)$ a $O(1)$: en lugar de mover datos, simplemente se reasigna `head = head->next`. La inserción de trabajos `URGENTE` también es eficiente, pues solo requiere actualizar dos punteros.
2. **Escalabilidad:** El límite de la cola dejó de ser una constante programada y pasó a estar determinado únicamente por la memoria disponible del sistema. Cada nodo se solicita con `malloc` en el momento exacto en que se necesita.
3. **Gestión de riesgos:** La principal responsabilidad añadida es el manejo manual del ciclo de vida de la memoria. Para mitigar fugas, el diseño garantiza que cada `malloc` en `qd_enqueue` tiene su correspondiente `free` en `qd_dequeue`, y la rutina `qd_destroy` asegura la limpieza total del *heap* al finalizar.

**Conclusión**  
Las ventajas en rendimiento y escalabilidad de la memoria dinámica justifican ampliamente el costo de gestionar manualmente la memoria. Este paradigma demostró ser el más adecuado para modelar una cola de impresión real, exigiendo a cambio mayor disciplina en el manejo de punteros y la arquitectura del software.

## 8. Referencias
* Documentación de la Práctica 01: Cola de impresión en lenguaje C, 40032 - Paradigmas de la Programación
