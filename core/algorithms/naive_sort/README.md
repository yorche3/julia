# Naive Sort — Julia

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **Julia**, ejecutada con el binario `julia` y dentro de una estructura de paquete gestionada con `Pkg`.

Los tres algoritmos elementales de ordenamiento ($O(n^2)$) — **Selection Sort**, **Bubble Sort** e **Insertion Sort** — trabajan **in-place** sobre `Vector{Int}` y no invocan ninguna biblioteca de ordenamiento: sólo comparaciones e intercambios paso a paso, sin usar `sort`.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`Project.toml`](Project.toml) | Manifiesto del paquete (nombre, UUID y target de test). |
| [`src/NaiveSort.jl`](src/NaiveSort.jl) | Único archivo fuente: las 3 funciones del contrato, exportadas. |
| [`test/naive_sort_tests.jl`](test/naive_sort_tests.jl) | Suite de la especificación: 3 algoritmos × 8 casos. |
| [`test/run_tests.jl`](test/run_tests.jl) | Punto de entrada que carga el módulo y ejecuta la suite. |

**Estructura de directorios esperada:**

```text
naive_sort/
├── Project.toml               # Manifiesto del paquete (Pkg)
├── src/
│   └── NaiveSort.jl           # Único archivo: 3 funciones, sin helpers
├── test/
│   ├── naive_sort_tests.jl    # 3 algoritmos × 8 casos
│   └── run_tests.jl           # Punto de entrada de las pruebas
└── README.md                  # Este archivo
```

A diferencia de `foundations/numbers/`, que reparte sus enfoques en dos suites (`recursive_tests.jl`, `iterative_tests.jl`), aquí los tres algoritmos comparten un único contrato y una única tabla de casos, así que una sola suite los recorre con un helper común.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Proyecto de estructura manual (`mkdir -p src test` + `Project.toml`), siguiendo la convención de `numbers/`: estructura estándar de paquete de Julia, con el módulo en `src/` y las pruebas en `test/`. No hay dependencias externas: el framework de pruebas es `Test`, de la biblioteca estándar.

**EN:** Manually structured project (`mkdir -p src test` + `Project.toml`), following the `numbers/` convention: Julia's standard package structure, with the module in `src/` and tests in `test/`. There are no external dependencies: the test framework is `Test`, from the standard library.

### Inicialización / Initialization

```bash
mkdir -p src test
```

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `Project.toml` — Manifiesto del paquete

**ES:** Define el nombre, un UUID propio del paquete, la versión y el target de pruebas. `Test` se declara en `[extras]` y `[targets]` para que `Pkg.test()` lo tenga disponible en el entorno de pruebas.

**EN:** It defines the name, the package's own UUID, the version and the test target. `Test` is declared under `[extras]` and `[targets]` so `Pkg.test()` has it available in the test environment.

```toml
name = "NaiveSort"
uuid = "a96f58fe-899f-4f32-bd97-f062093da5d5"
authors = ["yorche <hyaoki123@gmail.com>"]
version = "0.1.0"

[compat]
julia = "1.10"

[extras]
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[targets]
test = ["Test"]
```

### `.gitignore` — Archivos ignorados

**ES:** El módulo no necesita `.gitignore` propio: el de la raíz del submódulo `julia/` ya cubre los artefactos (`Manifest*.toml`, `*.jl.cov`, `*.jl.mem`, `LocalPreferences.toml`). Verificado con `git check-ignore -v core/algorithms/naive_sort/Manifest.toml` → `.gitignore:24:Manifest*.toml`, así que el `Manifest.toml` que genera `Pkg` no se versiona, igual que en `numbers/`.

**EN:** The module needs no `.gitignore` of its own: the one at the root of the `julia/` submodule already covers the artifacts (`Manifest*.toml`, `*.jl.cov`, `*.jl.mem`, `LocalPreferences.toml`). Verified with `git check-ignore -v core/algorithms/naive_sort/Manifest.toml` → `.gitignore:24:Manifest*.toml`, so the `Manifest.toml` that `Pkg` generates is not committed, as in `numbers/`.

---

## 🚀 Compilación y ejecución / Build & Run

### Verificar la carga del módulo / Check that the module loads

```bash
julia --project=. -e 'include("src/NaiveSort.jl")'
```

### Ejecutar pruebas / Run tests

```bash
julia --project=. test/run_tests.jl
```

**Salida real / Actual output:**

```text
$ julia --project=. -e 'include("src/NaiveSort.jl")'

$ julia --project=. test/run_tests.jl
Test Summary:    | Pass  Total  Time
Naive Sort Tests |   24     24  0.5s
```

> **ES:** Julia no tiene compilador con avisos ni linter configurado en este módulo (`numbers/` tampoco lo tiene), así que la verificación estática se hace cargando el módulo con `include`: no emite ninguna salida y devuelve 0. La suite ejecuta **24 aserciones**: 3 algoritmos × 8 casos (7 de la especificación + el nulo).
>
> **EN:** Julia has no warning-emitting compiler or configured linter in this module (neither does `numbers/`), so static verification is done by loading the module with `include`: it prints nothing and returns 0. The suite runs **24 assertions**: 3 algorithms × 8 cases (the 7 specification ones + the null one).

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Algoritmo | Estrategia | Complejidad | In-place |
|-----------|------------|-------------|:--------:|
| `selection_sort` | Busca el mínimo del tramo no ordenado y lo intercambia al inicio, con la guarda `min_index != i` | $O(n^2)$ siempre | ✅ |
| `bubble_sort` | Compara e intercambia adyacentes por pasadas, con **salida temprana** mediante la bandera `swapped` | $O(n^2)$ peor/promedio, $O(n)$ mejor | ✅ |
| `insertion_sort` | Inserta cada elemento en el sub-array ya ordenado desplazando los mayores | $O(n^2)$ peor/promedio, $O(n)$ mejor | ✅ |

### Casos cubiertos / Covered cases

| Caso | Entrada | Salida esperada |
|------|---------|-----------------|
| Array estándar desordenado | `[5, 2, 9, 1, 5, 6]` | `[1, 2, 5, 5, 6, 9]` |
| Array ya ordenado | `[1, 2, 3, 4, 5]` | `[1, 2, 3, 4, 5]` |
| Array en orden inverso | `[5, 4, 3, 2, 1]` | `[1, 2, 3, 4, 5]` |
| Elementos idénticos | `[7, 7, 7, 7]` | `[7, 7, 7, 7]` |
| Con números negativos | `[3, -1, 4, -5, 0]` | `[-5, -1, 0, 3, 4]` |
| Un solo elemento | `[42]` | `[42]` |
| Array vacío | `Int[]` | `Int[]` |
| **Entrada nula** | `nothing` | `nothing` |

---

## 📝 Notas de implementación / Implementation Notes

### 🧬 Ordenamiento *in-place* / In-place sorting

**ES:** El pseudocódigo ordena el propio array con `swap(arr, i, j)`, y Julia lo permite literalmente: `Vector` es mutable y se pasa por referencia, así que las tres funciones modifican el vector recibido y devuelven el mismo objeto. El intercambio usa la asignación múltiple `arr[i], arr[min_index] = arr[min_index], arr[i]`, que es el idioma de Julia y evita la variable temporal.

Como los *fixtures* de la suite son constantes de módulo y los vectores de Julia son mutables, cada caso ordena una **copia** creada con `copy(input)`. Sin ese aislamiento, el primer algoritmo dejaría los datos ordenados y los siguientes pasarían con entradas ya resueltas.

**EN:** The pseudocode sorts the array itself with `swap(arr, i, j)`, and Julia allows it literally: `Vector` is mutable and passed by reference, so all three functions modify the received vector and return the same object. The swap uses multiple assignment `arr[i], arr[min_index] = arr[min_index], arr[i]`, which is the Julia idiom and avoids the temporary variable.

Since the suite's fixtures are module-level constants and Julia vectors are mutable, each case sorts a **copy** created with `copy(input)`. Without that isolation, the first algorithm would leave the data sorted and the following ones would pass with already-solved inputs.

### 🆗 Indicador de fallo con `nothing` / Failure indicator via `nothing`

**ES:** Julia no tiene `null`; su valor de "ningún valor" es `nothing`, el singleton de `Nothing`. Las tres funciones empiezan con `if arr === nothing return nothing end` y devuelven `nothing` como indicador de fallo, sin lanzar errores. La comparación es **de identidad** (`===`), que es la forma idiomática de comprobar contra un singleton. El caso nulo se prueba de forma explícita y separada del caso vacío, porque `nothing` y `Int[]` son valores distintos.

**EN:** Julia has no `null`; its "no value" is `nothing`, the singleton of `Nothing`. All three functions start with `if arr === nothing return nothing end` and return `nothing` as the failure indicator, without throwing errors. The comparison is an **identity** comparison (`===`), which is the idiomatic way to check against a singleton. The null case is tested explicitly and separately from the empty case, because `nothing` and `Int[]` are different values.

### 🔢 Indexación basada en 1 / 1-based indexing

**ES:** Es la única divergencia estructural respecto al pseudocódigo, y es impuesta por el lenguaje: los arrays de Julia empiezan en el índice 1, así que todas las cotas están desplazadas una posición. El bucle interno de `selection_sort` pasa de `j = i + 1 to n - 1` a `for j in i+1:n`; el de `bubble_sort` pasa de `j = 0 to n - 2 - i` a `for j in 1:n-i`; y `insertion_sort` desplaza desde `i = 2` con la condición `j >= 1`. El número de iteraciones y el orden de las comparaciones son exactamente los del pseudocódigo.

**EN:** This is the only structural divergence from the pseudocode, and it is imposed by the language: Julia arrays start at index 1, so every bound is shifted by one position. The inner loop of `selection_sort` goes from `j = i + 1 to n - 1` to `for j in i+1:n`; the one in `bubble_sort` goes from `j = 0 to n - 2 - i` to `for j in 1:n-i`; and `insertion_sort` shifts from `i = 2` with the condition `j >= 1`. The number of iterations and the order of comparisons are exactly those of the pseudocode.

### 🔁 La bandera `swapped` con `break` / The `swapped` flag with `break`

**ES:** El criterio de aceptación exige conservar la optimización de salida temprana. Se implementa con `swapped = false` dentro del bucle externo y `if !swapped break end` al terminarlo, exactamente como el pseudocódigo: en cuanto una pasada completa no realiza ningún intercambio, el bucle termina y un array ya ordenado se resuelve en **una sola pasada** ($O(n)$ en el mejor caso).

**EN:** The acceptance criteria require preserving the early-exit optimization. It is implemented with `swapped = false` inside the outer loop and `if !swapped break end` when it finishes, exactly as in the pseudocode: as soon as a full pass performs no swap, the loop ends and an already sorted array is resolved in **a single pass** ($O(n)$ best case).

### 🔀 Estabilidad de `insertion_sort` / `insertion_sort` stability

**ES:** El bucle interno desplaza mientras `arr[j] > key` (estrictamente mayor), así que un elemento igual no se mueve y la ordenación es **estable**.

**EN:** The inner loop shifts while `arr[j] > key` (strictly greater), so an equal element does not move and the sort is **stable**.

### 🏷️ Naming, visibilidad y estilo / Naming, visibility and style

**ES:** Julia usa `snake_case` para las funciones, que es justo la convención de la especificación, así que la API es `selection_sort`, `bubble_sort` e `insertion_sort` **sin traducción de nombres**. Las tres se declaran con `function`/`return` y se exportan con `export`; el módulo no tiene helpers auxiliares. Los parámetros van sin anotación de tipo, igual que en `numbers/`, lo que además permite que la función acepte `nothing` y devuelva el indicador de fallo. Las guardas de una línea (`if arr === nothing return nothing end`) siguen el estilo compacto que ya usa `numbers/` con el operador ternario.

**EN:** Julia uses `snake_case` for functions, which is exactly the specification's convention, so the API is `selection_sort`, `bubble_sort` and `insertion_sort` **with no name translation**. All three are declared with `function`/`return` and exported with `export`; the module has no auxiliary helpers. Parameters are untyped, as in `numbers/`, which also allows the function to accept `nothing` and return the failure indicator. The one-line guards (`if arr === nothing return nothing end`) follow the compact style `numbers/` already uses with the ternary operator.

### 🧪 Estructura de los tests / Test structure

**ES:** La suite sigue el mismo patrón que los demás lenguajes, con las herramientas de `Test`:

- **Constantes con nombre** para cada entrada y salida esperada (`STANDARD_INPUT`, `STANDARD_OUTPUT`, `REVERSE_INPUT`, …), sin duplicar literales.
- Una **tabla de casos** (`CASES`) con descripción, entrada y salida esperada.
- Un **helper compartido** `assert_sorts_all_cases(sort_fn, algorithm)` que recibe la función a probar y el nombre del algoritmo, y recorre los 8 casos.
- **Un `@testset` por función** del contrato: `"selection_sort"`, `"bubble_sort"` e `"insertion_sort"`.
- La descripción de cada caso va en el **nombre del `@testset`** que genera el helper (`"$algorithm should sort $description"`), porque `@test` no admite un mensaje adjunto. Un fallo se ve así:

**EN:** The suite follows the same pattern as the other languages, using `Test`'s tooling:

- **Named constants** for every input and expected output (`STANDARD_INPUT`, `STANDARD_OUTPUT`, `REVERSE_INPUT`, …), with no duplicated literals.
- A **case table** (`CASES`) with description, input and expected output.
- A **shared helper** `assert_sorts_all_cases(sort_fn, algorithm)` that receives the function under test and the algorithm name, and walks the 8 cases.
- **One `@testset` per contract function**: `"selection_sort"`, `"bubble_sort"` and `"insertion_sort"`.
- Each case's description goes in the **`@testset` name** generated by the helper (`"$algorithm should sort $description"`), because `@test` does not accept an attached message. A failure looks like this:

```text
selection_sort should sort an unsorted array: Test Failed at .../naive_sort_tests.jl:53
```

### 📍 Desviaciones respecto a la ubicación esperada / Deviations from the expected location

| Especificación | Implementación | Motivo |
|----------------|----------------|--------|
| `src/naive_sort.ext` | `src/NaiveSort.jl` | `src/` coincide; el archivo se nombra en `PascalCase` igual que el módulo, como `Numbers.jl` en `numbers/`. |
| `test/naive_sort_test.ext` | `test/naive_sort_tests.jl` | La convención de `numbers/` para las suites es el sufijo `_tests.jl` (`recursive_tests.jl`). |
| `test/run_tests.ext` | `test/run_tests.jl` | El nombre coincide exactamente; es también el fichero que `Pkg.test()` busca por convención. |

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

*[← Volver a Algoritmos Puros](../README.md) · [↑ Volver a Core](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
