+++
title = "Práctica 0: Uso de repositorios"
date = 2026-02-20
draft = false
+++

**Nombre:** Diego Nahum Nuñez García  
**Materia:** Paradigmas de la Programación  
**Profesor:** M.I. José Carlos Gallegos Mariscal  

## Markdown

**Markdown** es un lenguaje de marcado ligero que te permite aplicar formato a un texto utilizando caracteres especiales de forma muy sencilla. Fue creado para que el texto sea **fácil de escribir** y, sobre todo, **fácil de leer** incluso cuando no está procesado.

## Git

### ¿Qué es Git?

**Git** es un **Sistema de Control de Versiones Distribuido**. Es una herramienta que funciona como una "máquina del tiempo" para tus archivos. Permite registrar cada cambio que haces en tu código, de modo que puedes volver atrás si algo sale mal.

### Las 3 áreas de Git

1. **Working Directory:** Es la carpeta normal donde estás editando los archivos.
2. **Staging Area:** Es como un "carrito de compras". Aquí pones los archivos listos para el siguiente commit.
3. **Repository:** Es donde Git guarda permanentemente los commits.

### Comandos básicos

- `git init` — Inicia un repositorio nuevo.
- `git status` — Muestra el estado actual de los archivos.
- `git add .` — Prepara todos los cambios.
- `git commit -m "mensaje"` — Guarda los cambios con una descripción.
- `git push` — Sube los commits a GitHub.

## Hugo

**Hugo** es un Generador de Sitios Estáticos escrito en Go. Toma archivos Markdown y los convierte en un sitio web completo con HTML, CSS y JavaScript.

### El combo perfecto: Hugo + Git + GitHub

1. Creas tu sitio con Hugo en tu computadora.
2. Usas Git para versionar tus archivos.
3. Subes el código a GitHub.
4. GitHub Pages publica tu sitio automáticamente con GitHub Actions.

## Conclusiones

Aprendí que Markdown es un lenguaje de marcado ligero que permite dar formato a textos de manera rápida y legible. Git me permite versionar mi código y colaborar con otros. Hugo convierte mis reportes en Markdown a un sitio web estático publicado automáticamente en GitHub Pages.