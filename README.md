# Julia

Proyectos en **Julia**, ejecutados con el binario `julia` (compilador JIT basado en LLVM).

Usa `Project.toml` como manifiesto de paquete, **Pkg** como gestor de paquetes y **Test** (biblioteca estándar) como framework de pruebas unitarias.

---

## 📂 Módulos / Modules

| Módulo | Descripción |
|--------|-------------|
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `calculator`, `numbers` |

---

### ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
julia helloworld.jl

# Hello, User!
cd core/foundations/hellouser
julia hellouser.jl

# Calculator Tests
cd core/foundations/unit_test/calculator
julia --project=. test/CalculatorTest.jl

# Numbers Tests
cd core/foundations/numbers
julia --project=. test/run_tests.jl
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
|-------------|-------------|
| [Julia](https://julialang.org/) | [juliaup](https://github.com/JuliaLang/juliaup) (recomendado) / [descargar](https://julialang.org/downloads/) |

```bash
# Instalar juliaup (gestor de versiones de Julia)
curl -fsSL https://install.julialang.org | sh

# Verificar instalación
julia --version
```

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Script simple (archivo `.jl`)

**ES:** Un único archivo fuente `.jl`, sin dependencias externas, ejecutado directamente con `julia`. No necesita función `main()`; el código de nivel superior se ejecuta de arriba a abajo. Ideal para `helloworld` y `hellouser`.

**EN:** A single `.jl` source file, no external dependencies, executed directly with `julia`. No `main()` function needed; top-level code runs top-to-bottom. Ideal for `helloworld` and `hellouser`.

```bash
julia <archivo>.jl
```

### 2. Paquete Pkg + tests (Test)

**ES:** Para proyectos que requieren pruebas unitarias y pueden crecer, se usa la estructura estándar de paquete: `Project.toml` como manifiesto y **Test** como framework. Los tests van en `test/` y se ejecutan con `julia --project=. test/<entrada>.jl`.

**EN:** For projects that require unit tests and can grow, the standard package structure is used: `Project.toml` as the manifest and **Test** as the framework. Tests go in `test/` and run with `julia --project=. test/<entry>.jl`.

```bash
julia --project=. test/<entrada>.jl
```

---

## 🧠 Características del lenguaje / Language Features

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | LLVM JIT — compila en el primer uso; los scripts corren sin paso de compilación |
| **Paradigma** | Multi-paradigma: dinámico con despacho múltiple |
| **Iteración** | Bucles `for`/`while` nativos; recursión disponible sin garantía de TCO |
| **TCO** | No garantizada — la recursión con acumulador se usa solo como puente didáctico |
| **Tests** | `Test` incluido en la stdlib — `@testset` y `@test` |
| **Paquetes** | `Project.toml` + `Pkg` — `src/<Módulo>.jl` define el módulo |
| **Scripts** | `.jl` — el código de nivel superior se ejecuta directamente |

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
