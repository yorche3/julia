# Numbers — Julia

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **Julia**, ejecutada con el binario `julia`.

Implementa los algoritmos de suma de los primeros n números, factorial, Fibonacci, máximo común divisor y mínimo común múltiplo en **tres enfoques** (recursión directa `_rec`, recursión con acumulador `_acc` e iterativo `_ite`), dentro de una estructura de paquete gestionada con `Pkg`, y los valida con pruebas unitarias usando `Test`.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`Project.toml`](Project.toml) | Manifiesto del paquete (nombre, UUID y target de test). |
| [`src/Numbers.jl`](src/Numbers.jl) | Único archivo fuente: los 3 enfoques y los helpers `_help`. |
| [`test/recursive_tests.jl`](test/recursive_tests.jl) | Suite del enfoque recursivo (`_rec`): 5 tests, 11 casos. |
| [`test/iterative_tests.jl`](test/iterative_tests.jl) | Suite del enfoque iterativo (`_ite`): 5 tests, 11 casos. |
| [`test/run_tests.jl`](test/run_tests.jl) | Punto de entrada que carga el módulo y ejecuta las dos suites. |

**Estructura de directorios esperada:**

```text
numbers/
├── Project.toml               # Manifiesto del paquete (Pkg)
├── src/
│   └── Numbers.jl             # Único archivo: 3 enfoques en 1 + helpers
├── test/
│   ├── recursive_tests.jl     # Tests: enfoque recursivo (5 tests, 11 casos)
│   ├── iterative_tests.jl     # Tests: enfoque iterativo (5 tests, 11 casos)
│   └── run_tests.jl           # Punto de entrada de las pruebas
└── README.md                  # Este archivo
```

> **ES:** No existe `recursive_with_acc_tests.jl`: en Julia el enfoque `_acc` se conserva en el código como puente didáctico pero no tiene pruebas unitarias propias (ver notas de implementación).
> **EN:** There is no `recursive_with_acc_tests.jl`: in Julia the `_acc` approach is kept in code as an educational bridge but has no dedicated unit tests (see implementation notes).

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa la estructura estándar de paquete de Julia, gestionada con `Pkg`, con un único archivo fuente y suites de pruebas separadas por enfoque.

Características:
- **Estructura de paquete**: `Project.toml` + módulo en `src/Numbers.jl` y suites en `test/`.
- **3 enfoques por algoritmo**: `_rec` (recursión directa), `_acc` (recursión con acumulador), `_ite` (iterativo).
- **Helpers privados `_help`**: usados por las variantes con acumulador; no se exportan.
- **Framework de pruebas**: `Test` — el framework de testing estándar del ecosistema Julia, integrado con `Pkg.test()`.

**EN:** This project uses Julia's standard package structure, managed with `Pkg`, with a single source file and test suites separated by approach.

Features:
- **Package structure**: `Project.toml` + module in `src/Numbers.jl` and suites in `test/`.
- **3 approaches per algorithm**: `_rec` (direct recursion), `_acc` (accumulator recursion), `_ite` (iterative).
- **Private `_help` helpers**: used by the accumulator variants; not exported.
- **Test framework**: `Test` — the standard testing framework in the Julia ecosystem, integrated with `Pkg.test()`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `Project.toml` — Manifiesto del paquete

**ES:** Define el nombre, UUID, versión y el target de pruebas. `Test` se declara en `[extras]` y `[targets]` para que `Pkg.test()` lo tenga disponible en el entorno de pruebas.

**EN:** Defines the name, UUID, version, and the test target. `Test` is declared under `[extras]` and `[targets]` so `Pkg.test()` has it available in the test environment.

```toml
name = "Numbers"
uuid = "fdcbc02e-b943-4a86-96c7-d7dc4218024c"
authors = ["yorche <hyaoki123@gmail.com>"]
version = "0.1.0"

[compat]
julia = "1.10"

[extras]
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[targets]
test = ["Test"]
```

### `src/Numbers.jl` — Módulo e implementación (único archivo)

**ES:** Los 5 algoritmos × 3 enfoques en un solo archivo, con helpers privados `_help` para las variantes con acumulador. Las funciones de una línea usan el operador ternario; las que tienen lógica de bucles usan `function`/`return`.

**EN:** The 5 algorithms × 3 approaches in a single file, with private `_help` helpers for the accumulator variants. One-line functions use the ternary operator; those with loop logic use `function`/`return`.

```julia
module Numbers

export sum_of_first_n_rec, sum_of_first_n_acc, sum_of_first_n_ite
export factorial_rec, factorial_acc, factorial_ite
export fibonacci_rec, fibonacci_acc, fibonacci_ite
export greatest_common_divisor_rec, greatest_common_divisor_acc, greatest_common_divisor_ite
export least_common_multiple_rec, least_common_multiple_acc, least_common_multiple_ite

# Recursión directa (_rec)
sum_of_first_n_rec(n) = n == 0 ? 0 : n + sum_of_first_n_rec(n - 1)
factorial_rec(n) = n == 0 ? 1 : n * factorial_rec(n - 1)
fibonacci_rec(n) = n <= 1 ? n : fibonacci_rec(n - 1) + fibonacci_rec(n - 2)
greatest_common_divisor_rec(a, b) = b == 0 ? a : greatest_common_divisor_rec(b, mod(a, b))
least_common_multiple_rec(a, b) = div(a * b, greatest_common_divisor_rec(a, b))

# Recursión con acumulador (_acc, tail-call style)
sum_of_first_n_acc(n) = sum_of_first_n_acc_help(n, 0)
sum_of_first_n_acc_help(n, acc) = n <= 0 ? acc : sum_of_first_n_acc_help(n - 1, n + acc)

factorial_acc(n) = factorial_acc_help(n, 1)
factorial_acc_help(n, acc) = n <= 1 ? acc : factorial_acc_help(n - 1, n * acc)

fibonacci_acc(n) = fibonacci_acc_help(n, 0, 1)
function fibonacci_acc_help(n, acc2, acc1)
    n <= 0 && return acc2
    n <= 2 && return acc1 + acc2
    return fibonacci_acc_help(n - 1, acc1, acc1 + acc2)
end

greatest_common_divisor_acc(a, b) = greatest_common_divisor_acc_help(a, b)
greatest_common_divisor_acc_help(a, b) = b == 0 ? a : greatest_common_divisor_acc_help(b, mod(a, b))
least_common_multiple_acc(a, b) = div(a * b, greatest_common_divisor_acc(a, b))

# Iterativo (_ite): bucles, sin recursión, memoria constante O(1)
function sum_of_first_n_ite(n)
    result = 0
    for i in 1:n
        result += i
    end
    return result
end

function factorial_ite(n)
    result = 1
    for i in 2:n
        result *= i
    end
    return result
end

function fibonacci_ite(n)
    n <= 1 && return n
    acc2 = 0
    acc1 = 1
    for _ in 2:n
        temp = acc1 + acc2
        acc2 = acc1
        acc1 = temp
    end
    return acc1
end

function greatest_common_divisor_ite(a, b)
    while b != 0
        temp = b
        b = mod(a, b)
        a = temp
    end
    return a
end

least_common_multiple_ite(a, b) = div(a * b, greatest_common_divisor_ite(a, b))

end # module Numbers
```

| Elemento | Propósito |
|----------|-----------|
| `_rec` | Recursión directa, cercana a la definición matemática. |
| `_acc` | Recursión con acumulador (tail-call style); puente didáctico hacia `_ite`. |
| `_ite` | Iterativo con bucles `for`/`while`; sin recursión, memoria O(1). |
| `_help` | Helpers privados del enfoque `_acc`; no se exportan. |
| `mod(a, b)` | Resto de la división (equivale al `%` del pseudocódigo). |
| `div(a * b, gcd)` | División entera para el MCM (el `/` del pseudocódigo devolvería `Float64` en Julia). |

### `test/recursive_tests.jl` y `test/iterative_tests.jl` — Suites

**ES:** Cada suite cubre los 11 casos de la especificación para su enfoque, agrupados en un `@testset` por función (5 por suite). Los `@testset` se incluyen desde `run_tests.jl`, que ya cargó el módulo.

**EN:** Each suite covers the specification's 11 cases for its approach, grouped into one `@testset` per function (5 per suite). The `@testset`s are included from `run_tests.jl`, which already loaded the module.

```julia
@testset "recursive" begin
    @testset "fibonacci" begin
        @test fibonacci_rec(0) == 0
        @test fibonacci_rec(1) == 1
        @test fibonacci_rec(6) == 8
    end

    @testset "least_common_multiple" begin
        @test least_common_multiple_rec(4, 6) == 12
        @test least_common_multiple_rec(6, 8) == 24
    end
end
```

### `test/run_tests.jl` — Punto de entrada

**ES:** Carga el módulo y ejecuta las dos suites. Lleva el nombre de la especificación (`run_tests`); si se quisiera usar `Pkg.test()` bastaría con renombrarlo a `runtests.jl` (el nombre que busca `Pkg` por convención).

**EN:** Loads the module and runs both suites. It uses the specification's name (`run_tests`); to use `Pkg.test()` it would only need to be renamed to `runtests.jl` (the name `Pkg` looks for by convention).

```julia
using Test

include(joinpath(@__DIR__, "..", "src", "Numbers.jl"))
using .Numbers

@testset "Numbers Tests" begin
    include(joinpath(@__DIR__, "recursive_tests.jl"))
    include(joinpath(@__DIR__, "iterative_tests.jl"))
end
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Julia instalado

Julia 1.12 se instaló en este entorno con [juliaup](https://github.com/JuliaLang/juliaup):

```bash
curl -fsSL https://install.julialang.org | sh
```

### Ejecutar pruebas / Run tests

```bash
cd julia/core/foundations/numbers

# Ejecución directa, con el entorno del proyecto activo
julia --project=. test/run_tests.jl

# Alternativa con Pkg.test(): renombrar test/run_tests.jl a test/runtests.jl
julia --project=. -e 'using Pkg; Pkg.test()'
```

**Salida esperada / Expected output:**

```text
Test Summary: | Pass  Total  Time
Numbers Tests |   22     22  0.1s
```

> **ES:** Julia cuenta 22 aserciones (`@test`), agrupadas en 5 `@testset` por suite (uno por función).
> **EN:** Julia counts 22 assertions (`@test`), grouped into 5 `@testset`s per suite (one per function).

> **ES:** La primera ejecución de `Pkg.test()` genera `Manifest.toml` automáticamente; el archivo está ignorado por git (`julia/.gitignore`), como es convención en los paquetes de Julia.
> **EN:** The first `Pkg.test()` run generates `Manifest.toml` automatically; the file is git-ignored (`julia/.gitignore`), as is convention for Julia packages.

---

## 📝 Notas de implementación / Implementation Notes

### 🔁 Sobre recursión con acumulador y Tail Call Optimization (TCO) / On recursion with accumulator and Tail Call Optimization (TCO)

**ES:**
Tail recursion ocurre cuando la llamada recursiva es la última acción que ejecuta una función; después de la llamada no hay más instrucciones y la función devuelve el resultado de la llamada recursiva. La recursión con acumulador consigue esto pasando el estado previo como parámetro a cada llamada, sin dejar trabajo pendiente en la pila.

En Julia **no se garantiza TCO**: el compilador puede optimizar algunas auto-llamadas de cola en casos simples, pero no es un comportamiento garantizado por el lenguaje, y una recursión profunda puede desbordar la pila.

Por eso, la implementación con acumulador (`_acc`) se conserva únicamente con fines educativos: sirve como puente conceptual entre la recursión directa (más cercana a la definición matemática) y la versión iterativa (memoria constante O(1)). Como en este contexto no hay un beneficio práctico de rendimiento garantizado, no se desarrollan pruebas unitarias específicas para los métodos con acumulador. La validación del comportamiento se cubre a través de las pruebas de los enfoques recursivo e iterativo, que juntos ejercitan los mismos resultados.

**Combinación aplicada**: TCO ❌ + iteración nativa ✅ → suites `_rec` (5 tests) + `_ite` (5 tests) = **10 tests, 22 casos**.

**EN:**
Tail recursion occurs when the recursive call is the last action that runs a function; after the call there are no more instructions and the function returns the result of the recursive call. Recursion with accumulator achieves this by passing the previous state as a parameter to each call, without leaving any pending work on the stack.

Julia **does not guarantee TCO**: the compiler may optimize some simple self-tail-calls, but this is not a language guarantee, and deep recursion can overflow the stack.

Therefore, the accumulator implementation (`_acc`) is preserved only for educational purposes: it serves as a conceptual bridge between direct recursion (closer to the mathematical definition) and the iterative version (constant O(1) memory). Since there is no guaranteed practical performance benefit in this context, no dedicated unit tests are developed for the accumulator methods. Behavior validation is covered by the recursive and iterative test suites, which together exercise the same results.

**Applied combination**: TCO ❌ + native iteration ✅ → `_rec` (5 tests) + `_ite` (5 tests) suites = **10 tests, 22 cases**.

### Otras notas / Other notes

- **ES:** `mod(a, b)` reemplaza el `%` del pseudocódigo; para operandos positivos equivale al resto común.
- **EN:** `mod(a, b)` replaces the pseudocode's `%`; for positive operands it equals the usual remainder.
- **ES:** Para el MCM se usa `div(a * b, gcd(...))` en lugar del `/` del pseudocódigo: en Julia `a / b` devuelve `Float64` incluso con enteros, y las pruebas comparan contra enteros.
- **EN:** For LCM, `div(a * b, gcd(...))` is used instead of the pseudocode's `/`: in Julia `a / b` returns `Float64` even for integers, and the tests compare against integers.
- **ES:** Los helpers `_help` no se exportan; son detalle de implementación visible dentro del módulo.
- **EN:** The `_help` helpers are not exported; they are implementation details visible within the module.
- **ES:** Las funciones de una línea usan el operador ternario (`cond ? a : b`); las variantes iterativas usan `function`/`return` por su lógica de bucles.
- **EN:** One-line functions use the ternary operator (`cond ? a : b`); the iterative variants use `function`/`return` due to their loop logic.
- **ES:** La estructura es la canónica de un paquete mínimo de Julia: `Project.toml` + `src/Numbers.jl` + `test/run_tests.jl`. Si el módulo creciera, se dividiría con `include(...)` dentro de `Numbers.jl`.
- **EN:** The structure is Julia's canonical minimal package layout: `Project.toml` + `src/Numbers.jl` + `test/run_tests.jl`. If the module grows, it would be split with `include(...)` inside `Numbers.jl`.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
