# Algorithms Pure — Julia

Implementaciones de la [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **Julia**: ordenamientos elementales, estructuras de datos propias, ordenamientos óptimos y distribuidos, y búsqueda.

Los módulos de esta fase trabajan sobre `Vector{Int}`, que en Julia **es mutable**, **se indexa desde 1** y usa `nothing` como indicador de fallo.

---

## 📂 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`naive_sort/`](naive_sort/) | [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) | `julia --project=.` + `Test` | 24 | ✅ |

---

## 📁 Estructura / Structure

```text
algorithms/
└── naive_sort/                    # 05_Naive_Sort
    ├── Project.toml
    ├── src/
    │   └── NaiveSort.jl           # selection_sort, bubble_sort, insertion_sort
    ├── test/
    │   ├── naive_sort_tests.jl    # 3 algoritmos × 8 casos
    │   └── run_tests.jl           # Entry point
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | Julia 1.12 sobre LLVM (JIT); los scripts corren sin paso de compilación |
| **CLI** | `julia --project=. test/run_tests.jl` |
| **Manifiesto** | `Project.toml` — nombre, UUID, `[compat]`, `[extras]` y `[targets]` |
| **Lock** | `Manifest.toml` lo genera `Pkg` y está **ignorado** por `.gitignore` (`Manifest*.toml`) |
| **Framework de tests** | `Test`, de la biblioteca estándar — `@testset` y `@test` |
| **Entry point** | `test/run_tests.jl`, que carga el módulo y ejecuta la suite |
| **Separación** | `src/{Modulo}.jl` (módulo) ↔ `test/` (suites `*_tests.jl` + runner) |
| **Iteración** | Bucles `for`/`while` nativos sobre `Vector{Int}` |
| **Indexación** | **1-based**: las cotas del pseudocódigo se desplazan una posición |
| **Visibilidad** | `export` para las funciones del contrato; los helpers no se exportan |
| **Naming** | `snake_case` (`selection_sort`), igual que la especificación; archivos en `PascalCase` |
| **Indicador de fallo** | `nothing` — se devuelve tal cual, sin lanzar errores |
| **Artefactos** | `Manifest.toml`, `*.jl.cov`, `*.jl.mem`, `LocalPreferences.toml` — ignorados por la raíz de `julia/` |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Naive Sort Tests
cd naive_sort
julia --project=. test/run_tests.jl
```

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

## ▶️ Siguiente / Next

👉 Continúa con los módulos pendientes de esta fase en el [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).
👉 Continue with the pending modules of this phase in the [Roadmap](https://yorche3.github.io/programming_languages/ROADMAP/).

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
