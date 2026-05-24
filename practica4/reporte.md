# Práctica IV — El Paradigma Lógico

**Nombre:** Diego Nahum Nuñez Garcia 
**Materia:** Paradigmas de la Programación  
**Profesor:** M.I. José Carlos Gallegos Mariscal  
**Fecha:** 23/05/2026  

## Introducción

El paradigma lógico es un estilo de programación basado en lógica formal. En lugar de decirle a la computadora cómo hacer algo paso a paso, se declaran hechos y reglas, y el sistema deduce las respuestas. El lenguaje principal de este paradigma es Prolog.

## Sesión 1 — Introducción a Prolog

Se instaló SWI-Prolog y se crearon las primeras bases de conocimiento.

- **kb1.pl**: Define hechos sobre chicas y quién puede cocinar. Consulta de prueba: `girl(priya).` → `true`
- **kb2.pl**: Define reglas sobre música y felicidad. Consulta: `happy(ana).` → `true`
- **kb3.pl**: Define relaciones de preferencia basadas en habilidades. Consulta: `likes(priya,jasmin).` → `true`

## Sesión 2 — Relaciones, operadores y listas

Se crearon bases de conocimiento más complejas con relaciones familiares, operadores aritméticos y manejo de listas.

- **family.pl**: Árbol familiar con relaciones madre, padre, hermano y hermana.
- **family_ext.pl**: Extiende family.pl con abuelos, tíos y esposa.
- **family_rec.pl**: Agrega la relación recursiva de predecesor.
- **operadores.pl**: Demuestra operaciones aritméticas básicas.
- **loop.pl**: Implementa bucles mediante recursión.
- **option.pl**: Implementa toma de decisiones tipo if-else.
- **conj_disj.pl**: Demuestra conjunciones y disyunciones lógicas.
- **list_basics.pl**: Operaciones básicas con listas: membresía, longitud, concatenación.
- **list_repos.pl**: Permutaciones, inversión y ordenamiento de listas.
- **list_misc.pl**: Operaciones adicionales: división, máximo y suma de listas.

## Sesión 3 — Torres de Hanoi y El mono y el plátano

### Torres de Hanoi

El problema consiste en mover N discos de una torre a otra usando una torre auxiliar, sin poner un disco grande sobre uno pequeño. Se resolvió con recursión en Prolog.

Consulta utilizada:hanoi(3,izquierda,derecha,centro).

Resultado: 7 movimientos correctos para 3 discos.

### El mono y el plátano

El mono está en la puerta, la caja está en la ventana, y el plátano está en el centro. El mono debe conseguir el plátano subiendo a la caja. Se modelaron los estados y movimientos posibles.

Consulta utilizada:
can_get(state(door,on_floor,window,false)).

Resultado: `true` — el mono puede conseguir el plátano.

## Conclusiones

El paradigma lógico permite resolver problemas complejos declarando hechos y reglas sin especificar el procedimiento exacto. Prolog es muy útil para problemas de búsqueda, relaciones y lógica formal como se demostró con las Torres de Hanoi y el problema del mono y el plátano.
