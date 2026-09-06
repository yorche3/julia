# Calculator — Julia

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Julia**, ejecutada con el binario `julia`.

Implementa 5 operaciones aritméticas (`addition`, `subtraction`, `multiplication`, `division`, `modulus`) usando únicamente `+` y `-` como operaciones primitivas, y las valida con pruebas unitarias con `Test`, el framework de pruebas estándar del ecosistema Julia, dentro de una estructura de paquete gestionada con `Pkg`.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`Project.toml`](Project.toml) | Manifiesto del paquete (nombre, UUID y target de test). |
| [`src/Calculator.jl`](src/Calculator.jl) | Módulo `Calculator` con las 5 operaciones aritméticas. |
| [`test/CalculatorTest.jl`](test/CalculatorTest.jl) | Punto de entrada de `Pkg.test()`: carga el módulo y ejecuta las 5 pruebas. |

**Estructura de directorios esperada:**

```text
calculator/
├── Project.toml               # Manifiesto del paquete (Pkg)
├── src/
│   └── Calculator.jl          # Módulo con las 5 operaciones aritméticas
├── test/
│   └── CalculatorTest.jl            # Punto de entrada de Pkg.test() con las 5 pruebas
└── README.md                  # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa la estructura estándar de paquete de Julia, gestionada con `Pkg`, pensada para crecer hacia implementaciones más complejas.

Características:
- **Estructura de paquete**: `Project.toml` + módulo en `src/Calculator.jl` y pruebas en `test/CalculatorTest.jl`.
- **5 operaciones**: `addition`, `subtraction`, `multiplication`, `division`, `modulus`.
- **Implementación educativa**: `multiplication` se construye con suma repetitiva; `division`, con resta repetitiva; y `modulus`, combinando `division` y `multiplication`. Solo `+` y `-` se usan como operaciones primitivas.
- **Framework de pruebas**: `Test` — el framework de testing estándar del ecosistema Julia, integrado con `Pkg.test()`.

**EN:** This project uses Julia's standard package structure, managed with `Pkg`, designed to grow toward more complex implementations.

Features:
- **Package structure**: `Project.toml` + module in `src/Calculator.jl` and tests in `test/CalculatorTest.jl`.
- **5 operations**: `addition`, `subtraction`, `multiplication`, `division`, `modulus`.
- **Educational implementation**: `multiplication` is built with repeated addition; `division`, with repeated subtraction; and `modulus`, combining `division` and `multiplication`. Only `+` and `-` are used as primitive operations.
- **Test framework**: `Test` — the standard testing framework in the Julia ecosystem, integrated with `Pkg.test()`.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `Project.toml` — Manifiesto del paquete

**ES:** Define el nombre, UUID, versión y el target de pruebas. `Test` se declara en `[extras]` y `[targets]` para que `Pkg.test()` lo tenga disponible en el entorno de pruebas.

**EN:** Defines the name, UUID, version, and the test target. `Test` is declared under `[extras]` and `[targets]` so `Pkg.test()` has it available in the test environment.

```toml
name = "Calculator"
uuid = "83b0dd59-1cd6-4525-a234-03fcc9eade44"
authors = ["yorche <hyaoki123@gmail.com>"]
version = "0.1.0"

[compat]
julia = "1.10"

[extras]
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[targets]
test = ["Test"]
```

### `src/Calculator.jl` — Módulo e implementación

**ES:** El módulo `Calculator` con las 5 operaciones. El nombre del archivo coincide con el del módulo, como exige la convención de paquetes de Julia. `multiplication` usa un bucle `for` de suma repetitiva y `division` usa un bucle `while` de resta repetitiva.

**EN:** The `Calculator` module with the 5 operations. The file name matches the module name, as required by Julia's package convention. `multiplication` uses a `for` loop of repeated addition and `division` uses a `while` loop of repeated subtraction.

```julia
module Calculator

export addition, subtraction, multiplication, division, modulus

addition(a, b) = a + b

subtraction(a, b) = a - b

function multiplication(a, b)
    result = 0
    for _ in 1:b
        result = addition(result, a)
    end
    return result
end

function division(a, b)
    quotient = 0
    while a >= b
        a = subtraction(a, b)
        quotient = addition(quotient, 1)
    end
    return quotient
end

function modulus(a, b)
    q = division(a, b)
    p = multiplication(q, b)
    return subtraction(a, p)
end

end # module Calculator
```

| Elemento | Propósito |
|----------|-----------|
| `module Calculator` | Agrupa las operaciones en un módulo (namespace). |
| `export` | Expone las funciones públicas al cargar el módulo con `using`. |
| `for _ in 1:b` | Repite la suma `b` veces (suma repetitiva, sin usar `*`). |
| `while a >= b` | Resta `b` de `a` hasta que no quepa más (resta repetitiva, sin usar `/`). |
| `modulus(a, b)` | Calcula el resto como `a - (division(a, b) * b)`, sin usar `%`. |

### `test/CalculatorTest.jl` — Pruebas y punto de entrada

**ES:** `Pkg.test()` ejecuta automáticamente este archivo (nombre estándar de Julia). Carga el módulo y ejecuta las 5 pruebas agrupadas en `@testset`; también funciona directo con `julia --project=. test/CalculatorTest.jl`.

**EN:** `Pkg.test()` automatically runs this file (Julia's standard name). It loads the module and runs the 5 tests grouped in `@testset`; it also works directly with `julia --project=. test/CalculatorTest.jl`.

```julia
using Test

include(joinpath(@__DIR__, "..", "src", "Calculator.jl"))
using .Calculator

@testset "Calculator Tests" begin
    @testset "addition" begin
        @test addition(2, 3) == 5
    end

    @testset "subtraction" begin
        @test subtraction(5, 2) == 3
    end

    @testset "multiplication" begin
        @test multiplication(3, 4) == 12
    end

    @testset "division" begin
        @test division(10, 3) == 3
    end

    @testset "modulus" begin
        @test modulus(10, 3) == 1
    end
end
```

> **ES:** `include(joinpath(@__DIR__, ...))` resuelve las rutas relativas al propio script, por lo que las pruebas funcionan sin importar desde qué directorio se ejecute `julia`.
> **EN:** `include(joinpath(@__DIR__, ...))` resolves paths relative to the script itself, so the tests work no matter which directory `julia` is run from.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Julia instalado

Julia 1.12 se instaló en este entorno con [juliaup](https://github.com/JuliaLang/juliaup):

```bash
curl -fsSL https://install.julialang.org | sh
```

### Ejecutar pruebas / Run tests

```bash
cd julia/core/foundations/unit_test/calculator

# Opción 1: vía Pkg.test() (recomendada — crea el entorno de pruebas)
julia --project=. -e 'using Pkg; Pkg.test()'

# Opción 2: directo, con el entorno del proyecto activo
julia --project=. test/CalculatorTest.jl
```

**Salida esperada / Expected output:**

```text
Test Summary:    | Pass  Total  Time
Calculator Tests |    5      5  0.0s
```

> **ES:** La primera ejecución de `Pkg.test()` genera `Manifest.toml` automáticamente; el archivo está ignorado por git (`julia/.gitignore`), como es convención en los paquetes de Julia.
> **EN:** The first `Pkg.test()` run generates `Manifest.toml` automatically; the file is git-ignored (`julia/.gitignore`), as is convention for Julia packages.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** `Test` es el framework de pruebas estándar del ecosistema Julia (incluido con el lenguaje) y está integrado con `Pkg.test()`: `@testset` agrupa pruebas y `@test` evalúa una aserción booleana.
- **EN:** `Test` is the Julia ecosystem's standard testing framework (bundled with the language) and is integrated with `Pkg.test()`: `@testset` groups tests and `@test` evaluates a boolean assertion.
- **ES:** La estructura es la canónica de un paquete mínimo de Julia: `Project.toml` + `src/Calculator.jl` + `test/CalculatorTest.jl`. Cuando el módulo crezca, se puede dividir con `include(...)` dentro de `Calculator.jl`, y se pueden agregar dependencias con `Pkg.add`.
- **EN:** The structure is Julia's canonical minimal package layout: `Project.toml` + `src/Calculator.jl` + `test/CalculatorTest.jl`. When the module grows, it can be split with `include(...)` inside `Calculator.jl`, and dependencies can be added with `Pkg.add`.
- **ES:** `multiplication` usa el bucle `for _ in 1:b` como suma repetitiva educativa; la variable `_` indica que el índice no se usa. Con `b ≤ 0` el bucle no itera y devuelve `0`.
- **EN:** `multiplication` uses the `for _ in 1:b` loop as educational repeated addition; the `_` variable indicates the index is unused. With `b ≤ 0` the loop does not iterate and returns `0`.
- **ES:** `division` resta `b` de `a` mientras `a >= b`, contando cada resta como una unidad del cociente. La división entre cero no está implementada en este ejemplo.
- **EN:** `division` subtracts `b` from `a` while `a >= b`, counting each subtraction as one unit of the quotient. Division by zero is not implemented in this example.
- **ES:** `modulus` no usa el operador `%`: obtiene el cociente con `division`, lo multiplica por `b` con `multiplication` y resta el producto de `a`.
- **EN:** `modulus` does not use the `%` operator: it obtains the quotient with `division`, multiplies it by `b` with `multiplication`, and subtracts the product from `a`.
- **ES:** Las funciones se definen con una sola línea (`addition(a, b) = a + b`) cuando el cuerpo es simple, y con `function`/`return` cuando hay lógica con bucles.
- **EN:** Functions are defined in one line (`addition(a, b) = a + b`) when the body is simple, and with `function`/`return` when there is loop logic.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
