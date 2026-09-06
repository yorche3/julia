# 🚀 Foundations — Julia

Implementaciones de la [Fase 0 — Fundamentos](https://yorche3.github.io/programming_languages/ROADMAP/#fase-0--fundamentos--foundations--completada) en **Julia**: `helloworld`, `hellouser`, `unit_test/calculator` y `numbers`.

---

## 📖 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`helloworld/`](helloworld/) | [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | `julia` (script `.jl`) | — | ✅ |
| [`hellouser/`](hellouser/) | [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | `julia` (script `.jl`) | — | ✅ |
| [`unit_test/calculator/`](unit_test/calculator/) | [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | paquete `Pkg` + `Test` | 5 | ✅ |
| [`numbers/`](numbers/) | [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | paquete `Pkg` + `Test` | 22 | ✅ |

---

## 📁 Estructura / Structure

```text
foundations/
├── helloworld/                   # 01_Hello_World
│   ├── helloworld.jl             # println("Hello, World! from Julia!")
│   └── README.md
│
├── hellouser/                    # 02_Hello_User
│   ├── hellouser.jl              # print + readline() + interpolación $(name)
│   └── README.md
│
├── unit_test/
│   └── calculator/               # 03_Unit_Test_Calculator
│       ├── Project.toml
│       ├── src/
│       │   └── Calculator.jl     # 5 operaciones (módulo)
│       ├── test/
│       │   └── CalculatorTest.jl # 5 tests
│       └── README.md
│
└── numbers/                      # 04_Numbers
    ├── Project.toml
    ├── src/
    │   └── Numbers.jl            # 15 funciones (3 enfoques × 5 algoritmos)
    ├── test/
    │   ├── recursive_tests.jl    # 11 tests recursivos (_rec)
    │   ├── iterative_tests.jl    # 11 tests iterativos (_ite)
    │   └── run_tests.jl          # punto de entrada
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | LLVM JIT — el código se compila en el primer uso; los scripts corren sin paso de compilación |
| **CLI** | `julia` para scripts; `Pkg` (gestor de paquetes) para proyectos |
| **Scripts simples** | `julia <archivo>.jl` — sin `Project.toml` ni compilación previa |
| **Proyectos con tests** | Paquete estándar: `Project.toml` + `src/` + `test/` |
| **Manifiesto** | `Project.toml` — nombre, UUID, versión y `[extras]`/`[targets]` para `Test` |
| **Framework de tests** | `Test` (biblioteca estándar) con `@testset` y `@test` |
| **Módulos** | `module <Nombre>` en `src/<Nombre>.jl`; `export` para las funciones públicas |
| **I/O** | `print` (sin salto), `println` (con salto), `readline()`; interpolación con `$(expr)` |
| **Bucles** | `for`/`while` nativos; Julia **no garantiza TCO** (la variante `_acc` se conserva como puente didáctico y no tiene pruebas propias) |
| **Tipado** | Dinámico con despacho múltiple |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Hello, World!
cd helloworld
julia helloworld.jl

# Hello, User!
cd hellouser
julia hellouser.jl

# Calculator Tests
cd unit_test/calculator
julia --project=. test/CalculatorTest.jl

# Numbers Tests
cd numbers
julia --project=. test/run_tests.jl
```

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

## ▶️ Siguiente / Next

👉 Después de fundamentos, continúa con [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-).  
👉 After foundations, continue with [Phase 1 — Algorithms Pure](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-).

---

*[← Volver a Julia](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
