# Data Structures Basics — Julia

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) en **Julia**, con un enfoque manual y minimalista.

**ES:** Implementa `Node` (celda enlazada compartida), `LinkedList`, `Stack` y `Queue` sobre `mutable struct`, dentro de una estructura de paquete gestionada con `Pkg`, y los valida con pruebas unitarias usando `Test`.

**EN:** Implements `Node` (shared linked cell), `LinkedList`, `Stack` and `Queue` over `mutable struct`, within a package structure managed with `Pkg`, and validates them with unit tests using `Test`.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito / Purpose |
|---|---|
| [`Project.toml`](Project.toml) | Manifiesto del paquete (nombre, UUID y versión) / Package manifest (name, UUID and version) |
| [`src/data_structures_basics.jl`](src/data_structures_basics.jl) | Único archivo fuente: `Node`, `LinkedList`, `Stack`, `Queue` y sus operaciones / Single source file: `Node`, `LinkedList`, `Stack`, `Queue` and their operations |
| [`test/data_structures_basics_tests.jl`](test/data_structures_basics_tests.jl) | Suite de pruebas unitarias / Unit test suite |
| [`test/run_tests.jl`](test/run_tests.jl) | Punto de entrada de las pruebas / Test entry point |

**Estructura de directorios / Directory structure:**

```text
data_structures_basics/
├── Project.toml                        # Manifiesto del paquete (Pkg)
├── src/
│   └── data_structures_basics.jl       # Único archivo: Node + 3 ADT
├── test/
│   ├── data_structures_basics_tests.jl # Suite de pruebas
│   └── run_tests.jl                    # Punto de entrada
└── README.md                           # Este archivo
```

> **ES:** La especificación espera `data_structures_basics_test.ext` (singular); el archivo se llama `data_structures_basics_tests.jl` (plural), siguiendo la convención de otros módulos de Julia en este repositorio. El punto de entrada `run_tests.jl` y el `Project.toml` son propios de la estructura de paquete de Julia.
>
> **EN:** The specification expects `data_structures_basics_test.ext` (singular); the file is named `data_structures_basics_tests.jl` (plural), following the convention of other Julia modules in this repository. The `run_tests.jl` entry point and `Project.toml` are specific to Julia's package structure.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa la estructura estándar de paquete de Julia, gestionada con `Pkg`, con un único archivo fuente y una suite de pruebas.

Características:
- **Estructura de paquete**: `Project.toml` + módulo en `src/data_structures_basics.jl` y suite en `test/`.
- **Tipos mutables**: `Node`, `LinkedList`, `Stack` y `Queue` son `mutable struct` con constructores internos.
- **Extensión de Base**: `push!`, `pop!`, `delete!`, `length`, `isempty` y `peek` extienden `Base` con los nombres idiomáticos de Julia.
- **Framework de pruebas**: `Test` — el framework de testing estándar del ecosistema Julia.

**EN:** This project uses Julia's standard package structure, managed with `Pkg`, with a single source file and a test suite.

Features:
- **Package structure**: `Project.toml` + module in `src/data_structures_basics.jl` and suite in `test/`.
- **Mutable types**: `Node`, `LinkedList`, `Stack` and `Queue` are `mutable struct` with inner constructors.
- **Base extension**: `push!`, `pop!`, `delete!`, `length`, `isempty` and `peek` extend `Base` with Julia's idiomatic names.
- **Test framework**: `Test` — the standard testing framework in the Julia ecosystem.

---

## 📄 Configuración clave / Key Configuration

### `Project.toml` — Manifiesto del paquete

**ES:** Define el nombre, UUID, versión y autores. No declara dependencias externas; `Test` se carga con `include` directo desde `run_tests.jl`.

**EN:** Defines the name, UUID, version and authors. No external dependencies; `Test` is loaded via direct `include` from `run_tests.jl`.

```toml
name = "data_structures_basics"
uuid = "67c1f4dc-5c5a-40fc-a2b3-2b9c9b08f47f"
version = "0.1.0"
authors = ["yorche3 <hyaoki123@gmail.com>"]
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Julia instalado / Requirement: Julia installed

```bash
curl -fsSL https://install.julialang.org | sh
```

### Ejecutar pruebas / Run tests

```bash
cd julia/core/algorithms/data_structures_basics

julia --project=. test/run_tests.jl
```

**Salida real / Actual output:**

```text
Test Summary:                | Pass  Total  Time
Data Structures Basics Tests |   51     51  0.2s
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

### `Node`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Node(value)` | `Int → Node` | `O(1)` | Constructor; `next` queda en `nothing` / Constructor; `next` set to `nothing` |
| `get_value(n)` | `Node → Int` | `O(1)` | |
| `get_next(n)` | `Node → Union{Nothing, Node}` | `O(1)` | |
| `set_next!(n, next)` | `Node, Union{Nothing, Node} → Node` | `O(1)` | Mutante; devuelve la misma celda / Mutating; returns same cell |

### `LinkedList`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `LinkedList()` | `→ LinkedList` | `O(1)` | Cabeza, cola ausentes; contador 0 / Head, tail absent; count 0 |
| `isempty(l)` | `LinkedList → Bool` | `O(1)` | |
| `length(l)` | `LinkedList → Int` | `O(1)` | Equivalente a `size()` / Equivalent to `size()` |
| `get_head(l)` | `LinkedList → Int` | `O(1)` | `-1` si está vacía / `-1` if empty |
| `insert_head!(l, v)` | `LinkedList, Int → LinkedList` | `O(1)` | |
| `insert_tail!(l, v)` | `LinkedList, Int → LinkedList` | `O(1)` | |
| `delete!(l, v)` | `LinkedList, Int → Bool` | `O(n)` | Primera aparición; `false` si no está / First occurrence; `false` if absent |

### `Stack`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Stack()` | `→ Stack` | `O(1)` | Tope ausente; contador 0 / Top absent; count 0 |
| `isempty(s)` | `Stack → Bool` | `O(1)` | |
| `length(s)` | `Stack → Int` | `O(1)` | |
| `push!(s, v)` | `Stack, Int → Stack` | `O(1)` | |
| `pop!(s)` | `Stack → Int` | `O(1)` | `-1` si está vacía / `-1` if empty |
| `peek(s)` | `Stack → Int` | `O(1)` | `-1` si está vacía / `-1` if empty |

### `Queue`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Queue()` | `→ Queue` | `O(1)` | Frente y final ausentes; contador 0 / Front and rear absent; count 0 |
| `isempty(q)` | `Queue → Bool` | `O(1)` | |
| `length(q)` | `Queue → Int` | `O(1)` | |
| `enqueue!(q, v)` | `Queue, Int → Queue` | `O(1)` | |
| `dequeue!(q)` | `Queue → Int` | `O(1)` | `-1` si está vacía / `-1` if empty |
| `peek(q)` | `Queue → Int` | `O(1)` | `-1` si está vacía / `-1` if empty |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| `mutable struct` con campos `Union{Nothing, T}` | Tipo inmutable con `Ref` o celdas mutables | Julia permite mutación directa de campos en `mutable struct`; es la forma canónica de modelar nodos enlazados / Julia allows direct field mutation in `mutable struct`; it is the canonical way to model linked nodes |
| Extender `Base` (`push!`, `pop!`, `length`, `isempty`) | Nombres propios (`stack_push!`, `list_size`, …) | Los nombres con `!` y `length`/`isempty` son idiomáticos en Julia y permiten usar los tipos con código genérico que espera la interfaz de colección / Names with `!` and `length`/`isempty` are idiomatic in Julia and allow the types to work with generic code expecting the collection interface |
| Constructores internos sin argumentos `LinkedList()`, `Stack()`, `Queue()` | Función `init` separada | El constructor sin argumentos es el equivalente idiomático de `init()` en Julia; garantiza que toda instancia creada esté en estado válido / The no-argument constructor is Julia's idiomatic equivalent of `init()`; it guarantees every created instance is in a valid state |
| Un único `Node` compartido | Tipos de nodo separados por ADT | La especificación exige un único `Node`; `Stack` y `Queue` reutilizan el mismo tipo sin delegar en `LinkedList` / The specification requires a single `Node`; `Stack` and `Queue` reuse the same type without delegating to `LinkedList` |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| `init()` como operación separada tras la declaración | Constructores internos `Node(value)`, `LinkedList()`, `Stack()`, `Queue()` | Julia no tiene declaración sin inicialización como Ada; el constructor es el único modo de crear una instancia y equivale a `init` / Julia has no declaration-without-initialisation like Ada; the constructor is the only way to create an instance and is equivalent to `init` |
| `is_empty()`, `size()` | `isempty(l)` y `length(l)` extendiendo `Base` | Nombres idiomáticos de Julia; `isempty` y `length` son los nombres que el ecosistema espera para colecciones / Julia's idiomatic names; `isempty` and `length` are the names the ecosystem expects for collections |
| `insert_head(value)`, `insert_tail(value)` | `insert_head!(l, value)`, `insert_tail!(l, value)` | La convención `!` indica que la función muta su primer argumento / The `!` convention indicates the function mutates its first argument |
| `push(value)`, `pop()`, `enqueue(value)`, `dequeue()` | `push!(s, v)`, `pop!(s)`, `enqueue!(q, v)`, `dequeue!(q)` | Extienden `Base.push!`, `Base.pop!`; `enqueue!` y `dequeue!` siguen la misma convención `!` / Extend `Base.push!`, `Base.pop!`; `enqueue!` and `dequeue!` follow the same `!` convention |
| `delete(value)` | `delete!(l, value)` extendiendo `Base.delete!` | Muta la lista; el nombre con `!` es idiomático / Mutates the list; the `!` name is idiomatic |
| `get_head()`, `peek()` devuelven indicador de fallo | Devuelven `-1` (tipo `Int`) | El contrato permite el indicador natural del lenguaje; `-1` es el centinela entero de Julia para este módulo / The contract allows the language's natural indicator; `-1` is Julia's integer sentinel for this module |
| `data_structures_basics_test.ext` (singular) | `data_structures_basics_tests.jl` (plural) | Convención del repositorio para módulos de Julia / Repository convention for Julia modules |
| `run_tests` como punto de entrada | `test/run_tests.jl` | Nombre de la especificación; `Pkg.test()` buscaría `runtests.jl` por convención, pero el `include` directo funciona sin renombrar / Specification's name; `Pkg.test()` would look for `runtests.jl` by convention, but direct `include` works without renaming |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `get_head` | Lista vacía | `-1` | `get_head(LinkedList()) == -1` |
| `pop!` | Pila vacía | `-1` | `pop!(Stack()) == -1` |
| `peek` (Stack) | Pila vacía | `-1` | `peek(Stack()) == -1` |
| `dequeue!` | Cola vacía | `-1` | `dequeue!(Queue()) == -1` |
| `peek` (Queue) | Cola vacía | `-1` | `peek(Queue()) == -1` |
| `delete!` | Valor no encontrado | `false` | `delete!(l, 99) == false` |
| `get_next` | Enlace ausente | `nothing` | `get_next(Node(10)) === nothing` |

---

## ✅ Cobertura de pruebas / Test coverage

### `Node`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Inicializar y observar valor/enlace | Sí | `test/data_structures_basics_tests.jl` — `@testset "caso 1"` | |
| Inicializar otro nodo, enlazar y recorrer | Sí | `test/data_structures_basics_tests.jl` — `@testset "caso 2"` | |

### `LinkedList`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Estado vacío (`is_empty`, `size`, `get_head`) | Sí | `@testset "paso 1: estado vacío"` | |
| Insertar por ambos extremos | Sí | `@testset "paso 2: insertar por ambos extremos"` | |
| Eliminar primera aparición | Sí | `@testset "paso 3: eliminar la primera aparición"` | |
| Valor ausente (`delete(99)`) | Sí | `@testset "paso 4: valor ausente"` | |
| Vaciar la lista | Sí | `@testset "paso 5: vaciar la lista"` | |

### `Stack`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Estado vacío y extracción fallida | Sí | `@testset "paso 1: estado vacío y extracción fallida"` | |
| LIFO y `peek` no mutante | Sí | `@testset "paso 2: LIFO y peek no mutante"` | |
| Extracción y reutilización | Sí | `@testset "paso 3: extracción y reutilización"` | |
| Vacío tras extracción | Sí | `@testset "paso 4: vacío tras extracción"` | |

### `Queue`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Estado vacío y extracción fallida | Sí | `@testset "paso 1: estado vacío y extracción fallida"` | |
| FIFO y `peek` no mutante | Sí | `@testset "paso 2: FIFO y peek no mutante"` | |
| Extracción y reutilización | Sí | `@testset "paso 3: extracción y reutilización"` | |
| Vacío tras extracción | Sí | `@testset "paso 4: vacío tras extracción"` | |

**Total: 51 aserciones (`@test`), todas en verde.**

**Total: 51 assertions (`@test`), all passing.**

---

## ⚠️ Limitaciones conocidas / Known limitations

Ninguna / None

**ES:** El módulo cumple todas las operaciones del contrato con las complejidades declaradas. Los valores de prueba son enteros positivos que no colisionan con el indicador de fallo `-1`.

**EN:** The module fulfils every contract operation with the stated complexities. Test values are positive integers that do not collide with the `-1` failure indicator.

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** `mutable struct` permite mutar campos directamente (`l.head = new_node`), lo que simplifica las operaciones de inserción y eliminación sin necesidad de devolver copias.
- **EN:** `mutable struct` allows direct field mutation (`l.head = new_node`), which simplifies insertion and deletion operations without needing to return copies.

- **ES:** `import Base: push!, pop!, delete!, length, isempty, peek` extiende los nombres de `Base` para que funcionen con la sintaxis habitual de Julia (`push!(stack, 10)`, `length(list)`, etc.).
- **EN:** `import Base: push!, pop!, delete!, length, isempty, peek` extends `Base` names so they work with Julia's usual syntax (`push!(stack, 10)`, `length(list)`, etc.).

- **ES:** El constructor interno `Node(value::Int) = new(value, nothing)` garantiza que todo nodo nuevo tiene `next` en `nothing`, equivalente a la ausencia nativa.
- **EN:** The inner constructor `Node(value::Int) = new(value, nothing)` guarantees every new node has `next` set to `nothing`, equivalent to native absence.

- **ES:** `delete!` devuelve `Bool` (`true`/`false`) en lugar de un indicador entero, porque el contrato de la especificación dice «devuelve éxito» o «devuelve fallo» para la eliminación, y `Bool` es el tipo natural de Julia para éxito/fracaso.
- **EN:** `delete!` returns `Bool` (`true`/`false`) instead of an integer indicator, because the specification's contract says "returns success" or "returns failure" for deletion, and `Bool` is Julia's natural type for success/failure.

- **ES:** Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para consultar las demás versiones.
- **EN:** This project is also implemented in other languages. Explore the [main repository](https://github.com/yorche3/programming_languages) to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`06_Data_Structures_Basics.md`](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) |
| Módulo homologado del lenguaje / Homologated module | [`julia/core/foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](https://yorche3.github.io/programming_languages/core/00_Project_Initialization_Guide/) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](https://yorche3.github.io/programming_languages/docs/AGENT_Template/) |
| Documentación oficial del lenguaje / Language official docs | [Julia Documentation](https://docs.julialang.org/) |

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
