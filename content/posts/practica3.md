+++
title = "Práctica 3: Introducción a Haskell y Paradigma Funcional"
date = 2026-05-01
draft = false
tags = ["Haskell", "Funcional", "UABC"]
+++

**Nombre:** Diego Nahum Nuñez García
**Materia:** Paradigmas de la Programación (PP)
**Profesor:** M.I. José Carlos Gallegos Mariscal
**Fecha:** Mayo 2026

---

## 1. Introducción

Haskell es un lenguaje de programación **puramente funcional** de propósito general con semántica no estricta y tipado estático fuerte. A diferencia de lenguajes imperativos como C o Python, en Haskell los programas se construyen mediante funciones matemáticas, sin variables mutables ni efectos secundarios (salvo los controlados mediante el sistema de tipos con el IO Monad).

---

## 2. Primera Sesión: Instalación del Entorno

### 2.1 Herramientas instaladas con GHCup

Para trabajar con Haskell se utiliza **GHCup**, una herramienta que gestiona la instalación y actualización de todos los componentes del ecosistema Haskell.

| Herramienta | Descripción |
|-------------|-------------|
| GHCup | Instalador y gestor del entorno Haskell. Equivalente a un meta-instalador. |
| GHC | Glasgow Haskell Compiler. Compilador principal del lenguaje. |
| GHCi | Intérprete interactivo (REPL). Permite ejecutar código sin compilar. |
| HLS | Haskell Language Server. Provee autocompletado y errores en tiempo real en VS Code. |
| Stack | Manejador de paquetes y proyectos. Similar a `pip` en Python o `apt` en Ubuntu. |
| Cabal | Build tool que usa Stack para descargar dependencias y GHC para compilar. |

### 2.2 Proceso de instalación

La instalación se realiza desde **PowerShell sin modo administrador**, ejecutando el comando oficial de GHCup obtenido desde [haskell.org/ghcup](https://www.haskell.org/ghcup):

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [...] bootstrap-haskell.ps1 -Interactive -DisableCurl
```

Durante la instalación, el asistente pregunta si se desea instalar HLS y Stack, a lo que se responde afirmativamente. El proceso descarga e instala **GHC 9.6.7 (~310 MB)** junto con los demás componentes.

### 2.3 Verificación de la instalación

Una vez finalizada la instalación, se verifica que las herramientas están disponibles:

```powershell
ghc --version
stack --version
cabal --version
```

En caso de que el sistema no reconozca los comandos, se agrega la ruta de GHCup manualmente al PATH:

```powershell
$env:PATH += ";C:\ghcup\bin"
```

### 2.4 Primer programa en Haskell

Como primera prueba del entorno, se crea el archivo `Main.hs` con el clásico Hello World:

```haskell
main :: IO ()
main = putStrLn "Hello, Haskell!"
```

Se compila y ejecuta con:

```bash
ghc main.hs -o hello
./hello
```

El compilador genera el ejecutable `hello.exe` y al ejecutarlo se obtiene el mensaje esperado en pantalla.

### 2.5 Intérprete interactivo GHCi

GHCi permite ejecutar expresiones Haskell directamente sin necesidad de compilar:
ghci
Prelude> 2 + 2
4
Prelude> "Hola" ++ " Mundo"
"Hola Mundo"
Prelude> :quit

---

## 3. Segunda Sesión: Aplicación TODO en Haskell

### 3.1 Creación del proyecto con Stack

Para la segunda sesión se implementa una aplicación de lista de tareas (TODO App) utilizando Stack como gestor de proyectos:

```bash
stack new todo-app simple
cd todo-app
```

Stack genera automáticamente la siguiente estructura:
todo-app/
src/
Main.hs        ← Código fuente principal
todo-app.cabal   ← Configuración del proyecto
stack.yaml       ← Versión de GHC y dependencias
README.md

### 3.2 Conceptos del paradigma funcional aplicados

| Concepto | Descripción | Ejemplo en el código |
|----------|-------------|----------------------|
| **Tipos de datos** | Alias de tipos para mayor claridad | `type Task = String` / `type TodoList = [Task]` |
| **Funciones puras** | No mutan la lista original, retornan una nueva | `showTasks`, `addTask`, `removeTask` |
| **Pattern matching** | Despacha opciones del menú de forma declarativa | `menu` usa `case...of` |
| **IO Monad** | Encapsula efectos secundarios de forma controlada | Todas las funciones de I/O retornan `IO ()` |
| **Recursión** | El menú se llama a sí mismo en lugar de usar `while` | `menu tasks` llama a `menu newTasks` |
| **List comprehension** | Elimina tareas por índice sin mutar la lista | `[t \| (i, t) <- zip [1..] tasks, i /= n]` |

### 3.3 Código completo — src/Main.hs

```haskell
module Main where

import System.IO
import Data.List (intercalate)

type Task = String
type TodoList = [Task]

showTasks :: TodoList -> IO ()
showTasks [] = putStrLn "No hay tareas pendientes."
showTasks tasks = do
  putStrLn "Lista de tareas:"
  mapM_ (\(i, t) -> putStrLn $ show i ++ ". " ++ t) (zip [1..] tasks)

addTask :: TodoList -> IO TodoList
addTask tasks = do
  putStr "Nueva tarea: "
  hFlush stdout
  task <- getLine
  return (tasks ++ [task])

removeTask :: TodoList -> IO TodoList
removeTask tasks = do
  showTasks tasks
  putStr "Número de tarea a eliminar: "
  hFlush stdout
  n <- readLn
  return [t | (i, t) <- zip [1..] tasks, i /= n]

menu :: TodoList -> IO ()
menu tasks = do
  putStrLn "\n=== TODO APP en Haskell ==="
  putStrLn "1. Ver tareas"
  putStrLn "2. Agregar tarea"
  putStrLn "3. Eliminar tarea"
  putStrLn "4. Salir"
  putStr "Opción: "
  hFlush stdout
  opt <- getLine
  case opt of
    "1" -> showTasks tasks >> menu tasks
    "2" -> addTask tasks >>= menu
    "3" -> removeTask tasks >>= menu
    "4" -> putStrLn "¡Hasta luego!"
    _   -> putStrLn "Opción inválida" >> menu tasks

main :: IO ()
main = do
  hSetBuffering stdout NoBuffering
  menu []
```

### 3.4 Compilación y ejecución

```bash
stack build
stack exec todo-app
```

Stack descarga las dependencias, compila el módulo Main y genera el ejecutable. La primera compilación puede tardar varios minutos.

### 3.5 Funcionamiento de la aplicación

| Opción | Función | Descripción |
|--------|---------|-------------|
| 1 | `showTasks` | Muestra la lista numerada de tareas pendientes |
| 2 | `addTask` | Solicita una nueva tarea y la agrega al final |
| 3 | `removeTask` | Muestra la lista y elimina la tarea por número |
| 4 | `main/menu` | Termina la ejecución del programa |

---

## 4. Conclusiones

A través de esta práctica se logró instalar exitosamente el entorno de desarrollo para Haskell utilizando GHCup, y se comprendió el rol de cada herramienta dentro del ecosistema del lenguaje.

La implementación de la TODO App permitió observar en práctica las características del paradigma funcional:

- **Ausencia de variables mutables:** los datos nunca se modifican, siempre se crean nuevas versiones.
- **Recursión en lugar de ciclos:** el menú se llama a sí mismo indefinidamente.
- **Funciones que transforman datos:** cada función recibe una lista y regresa una nueva.
- **IO Monad:** permite manejar efectos secundarios (leer/escribir en consola) de forma controlada y predecible.

Haskell representa una forma radicalmente diferente de pensar la programación en comparación con lenguajes imperativos. Aunque la curva de aprendizaje es pronunciada, el lenguaje obliga a escribir código más predecible, modular y libre de efectos inesperados.

---

## 5. Referencias

- Haskell.org. (2024). *Downloads*. https://www.haskell.org/downloads/
- GHCup. (2024). *The Haskell toolchain installer*. https://www.haskell.org/ghcup/
- Haskell.org. (2024). *Get Started*. https://www.haskell.org/get-started/
- Haskell Wiki. (2024). *Haskell Tutorial for C Programmers*. https://wiki.haskell.org/Haskell_Tutorial_for_C_Programmers

