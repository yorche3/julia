# Data Structures Advanced — Julia

Implementación de la especificación [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) en **Julia**, con un enfoque manual y minimalista.

**ES:** Implementa un árbol binario de búsqueda (`BinaryTree`) sobre nodos enlazados (`TreeNode`) y un grafo dirigido (`Graph`) con registro enlazado canónico de vértices (`GraphNode`) y listas de adyacencia ordenadas (`NeighborNode`), gestionados con `Pkg` y validados mediante `Test`.

**EN:** Implements a binary search tree (`BinaryTree`) over linked nodes (`TreeNode`) and a directed graph (`Graph`) with a canonical linked vertex registry (`GraphNode`) and sorted adjacency lists (`NeighborNode`), managed with `Pkg` and validated using `Test`.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito / Purpose |
|---|---|
| [`Project.toml`](Project.toml) | Manifiesto del paquete (nombre, UUID, versión y targets) / Package manifest (name, UUID, version and targets) |
| [`src/data_structures_advanced.jl`](src/data_structures_advanced.jl) | Código fuente principal: `TreeNode`, `BinaryTree`, `Graph` y tipos auxiliares / Main source code: `TreeNode`, `BinaryTree`, `Graph` and auxiliary types |
| [`test/data_structures_advanced_tests.jl`](test/data_structures_advanced_tests.jl) | Suite de pruebas unitarias / Unit test suite |
| [`test/run_tests.jl`](test/run_tests.jl) | Punto de entrada de las pruebas / Test entry point |

**Estructura de directorios / Directory structure:**

```text
data_structures_advanced/
├── Project.toml                         # Manifiesto del paquete (Pkg)
├── src/
│   └── data_structures_advanced.jl      # Fuente principal: TreeNode, BinaryTree, Graph
├── test/
│   ├── data_structures_advanced_tests.jl # Suite completa de pruebas
│   └── run_tests.jl                     # Punto de entrada
└── README.md                            # Este archivo
```

> **ES:** La especificación propone `data_structures_advanced_test.ext` (singular); el archivo utiliza el plural `data_structures_advanced_tests.jl`, siguiendo la convención de los módulos de Julia en este repositorio (`data_structures_basics_tests.jl`, `numbers`). El punto de entrada `run_tests.jl` y el manifiesto `Project.toml` corresponden a la estructura estándar de paquetes de Julia.
>
> **EN:** The specification suggests `data_structures_advanced_test.ext` (singular); the file uses the plural `data_structures_advanced_tests.jl`, following the convention of Julia modules in this repository (`data_structures_basics_tests.jl`, `numbers`). The entry point `run_tests.jl` and manifest `Project.toml` match Julia's standard package layout.

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto adopta la estructura estándar de paquete de Julia gestionada con `Pkg`, estructurada en un módulo fuente y suites de pruebas sin dependencias externas fuera de la biblioteca estándar `Test`.

Características:
- **Estructura de paquete**: `Project.toml` con compatibilidad para Julia 1.10+ y módulo en `src/data_structures_advanced.jl`.
- **Base Node por valor embebido**: Al no admitir Julia herencia entre tipos concretos (`mutable struct`), el campo `value::Int` se declara directamente dentro de `TreeNode` y `GraphNode`, satisfaciendo la opción de valor embebido prevista por el contrato.
- **Implementación manual sin colecciones de biblioteca**: El registro de vértices del grafo se gestiona con una lista enlazada propia (`GraphNode` con enlace `next_vertex`), y la adyacencia con nodos enlazados ordenados (`NeighborNode`). No se utilizan `Dict`, `Set` ni ordenaciones automáticas.
- **Extensión de Base**: Se extienden `contains`, `isempty`, `length` e `insert!` para integrarse con la interfaz estándar de Julia.
- **Convención mutante**: Las operaciones que modifican la estructura en el sitio usan el sufijo `!` (`set_left!`, `set_right!`, `insert!`, `add_vertex!`, `add_edge!`).

**EN:** The project adopts Julia's standard package layout managed with `Pkg`, structured into a source module and test suites without external dependencies beyond standard library `Test`.

Features:
- **Package structure**: `Project.toml` compatible with Julia 1.10+ and module in `src/data_structures_advanced.jl`.
- **Node base via embedded value**: Since Julia does not allow inheritance between concrete types (`mutable struct`), the `value::Int` field is declared directly inside `TreeNode` and `GraphNode`, fulfilling the contract's embedded value option.
- **Manual implementation without library collections**: Graph vertex registry is maintained with a custom linked list (`GraphNode` with `next_vertex` link), and adjacency with sorted linked nodes (`NeighborNode`). No `Dict`, `Set` or library sorting are used.
- **Base extension**: Extends `contains`, `isempty`, `length` and `insert!` to integrate with Julia's collection conventions.
- **Mutating convention**: Operations modifying structures in-place use the `!` suffix (`set_left!`, `set_right!`, `insert!`, `add_vertex!`, `add_edge!`).

---

## 📄 Configuración clave / Key Configuration

### `Project.toml` — Manifiesto del paquete

**ES:** Declara el nombre del paquete, UUID, versión, compatibilidad con Julia 1.10 y la dependencia de pruebas `Test` en `[extras]` y `[targets]`.

**EN:** Declares package name, UUID, version, Julia 1.10 compatibility and test dependency `Test` in `[extras]` and `[targets]`.

```toml
name = "data_structures_advanced"
uuid = "7d16d57f-5f8c-4c3d-8318-30882db1d959"
version = "0.1.0"
authors = ["yorche3 <hyaoki123@gmail.com>"]

[compat]
julia = "1.10"

[extras]
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[targets]
test = ["Test"]
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Julia instalado / Requirement: Julia installed

```bash
curl -fsSL https://install.julialang.org | sh
```

### Ejecutar pruebas / Run tests

```bash
cd julia/core/algorithms/data_structures_advanced

julia --project=. test/run_tests.jl
```

**Salida real / Actual output:**

```text
Test Summary:                  | Pass  Total  Time
Data Structures Advanced Tests |  137    137  1.3s
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

### `TreeNode`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `TreeNode(value)` | `Int → TreeNode` | `O(1)` | Constructor; enlaces izquierdo y derecho inicializados a `nothing` / Constructor; left and right links set to `nothing` |
| `get_value(node)` | `TreeNode → Int` | `O(1)` | Observador de valor / Value accessor |
| `get_left(node)` | `TreeNode → Union{Nothing, TreeNode}` | `O(1)` | Devuelve el hijo izquierdo o `nothing` / Returns left child or `nothing` |
| `get_right(node)` | `TreeNode → Union{Nothing, TreeNode}` | `O(1)` | Devuelve el hijo derecho o `nothing` / Returns right child or `nothing` |
| `set_left!(node, left)` | `TreeNode, Union{Nothing, TreeNode} → TreeNode` | `O(1)` | Muta el enlace izquierdo; devuelve el mismo nodo / Mutates left link; returns same node |
| `set_right!(node, right)` | `TreeNode, Union{Nothing, TreeNode} → TreeNode` | `O(1)` | Muta el enlace derecho; devuelve el mismo nodo / Mutates right link; returns same node |

### `BinaryTree`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `BinaryTree()` | `→ BinaryTree` | `O(1)` | Raíz en `nothing`, contador 0 / Root set to `nothing`, count 0 |
| `isempty(tree)` | `BinaryTree → Bool` | `O(1)` | Extiende `Base.isempty` / Extends `Base.isempty` |
| `length(tree)` | `BinaryTree → Int` | `O(1)` | Equivalente a `size()`; extiende `Base.length` / Equivalent to `size()`; extends `Base.length` |
| `insert!(tree, value)` | `BinaryTree, Int → Bool` | `O(h)` | Inserción en ABB iterativa; duplicados conservan tamaño y devuelven `true` / Iterative BST insertion; duplicates preserve size and return `true` |
| `contains(tree, value)` | `BinaryTree, Int → Bool` | `O(h)` | Búsqueda en ABB iterativa siguiendo invariante menor/mayor / Iterative BST search following lower/higher invariant |

### `GraphNode` & `NeighborNode` (internos / internal)

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `GraphNode(label)` | `Int → GraphNode` | `O(1)` | Constructor de vértice con etiqueta y enlaces nulos / Vertex constructor with label and null links |
| `NeighborNode(label, next)` | `Int, Union{Nothing, NeighborNode} → NeighborNode` | `O(1)` | Celda enlazada de adyacencia / Linked adjacency cell |

### `Graph`

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `Graph()` | `→ Graph` | `O(1)` | Inicializa sin vértices ni aristas / Initializes with no vertices nor edges |
| `isempty(graph)` | `Graph → Bool` | `O(1)` | `true` si `vertex_total == 0` / `true` if `vertex_total == 0` |
| `vertex_count(graph)` | `Graph → Int` | `O(1)` | Número de vértices registrados / Registered vertex count |
| `edge_count(graph)` | `Graph → Int` | `O(1)` | Número de aristas dirigidas / Directed edge count |
| `find_vertex(graph, label)` | `Graph, Int → Union{Nothing, GraphNode}` | `O(V)` | Búsqueda lineal en el registro canónico de vértices / Linear traversal over canonical vertex registry |
| `add_vertex!(graph, label)` | `Graph, Int → Bool` | `O(V)` | Registra vértice si es nuevo; duplicados son idempotentes / Registers vertex if new; duplicates are idempotent |
| `add_edge!(graph, u, v)` | `Graph, Int, Int → Bool` | `O(V + d(u))` | Requiere extremos existentes; inserta ordenado en vecinos; bucles y duplicados permitidos / Requires existing endpoints; sorted insertion into neighbours; loops and duplicates allowed |
| `has_edge(graph, u, v)` | `Graph, Int, Int → Bool` | `O(V + d(u))` | Comprueba si existe la arista dirigida `u → v` / Checks if directed edge `u → v` exists |
| `get_neighbors(graph, u)` | `Graph, Int → Union{Nothing, Vector{Int}}` | `O(V + d(u))` | Copia independiente de vecinos ordenados; `nothing` si `u` no existe / Independent copy of sorted neighbours; `nothing` if `u` is missing |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Base `Node` mediante valor embebido (`value::Int`) | Tipo abstracto `abstract type AbstractNode end` | Julia no admite herencia entre tipos concretos (`mutable struct`). Un tipo abstracto añadiría una jerarquía vacía sin comportamiento compartido, ya que `TreeNode` y `GraphNode` manejan enlaces totalmente distintos. La especificación permite explícitamente el valor embebido. / Julia does not support inheritance between concrete types. An abstract type would introduce an empty hierarchy without shared behavior, as `TreeNode` and `GraphNode` manage distinct links. The specification explicitly permits embedded values. |
| `mutable struct` con `Union{Nothing, T}` para enlaces | Enfoque inmutable o vectores de índices preasignados | Modela punteros de memoria directos sin overhead de recreación de estructuras. `nothing` es el centinela estándar de ausencia en Julia con coste nulo. / Directly models memory pointers without structural copying overhead. `nothing` is Julia's standard zero-cost absence sentinel. |
| Extensión de funciones de `Base` (`contains`, `isempty`, `length`, `insert!`) | Métodos con prefijo exclusivo (`tree_insert!`, `graph_is_empty`, …) | Adopta los nombres idiomáticos del ecosistema de Julia, permitiendo el uso natural de las funciones de colección estándar. / Adopts idiomatic names from Julia's ecosystem, enabling standard collection function conventions. |
| Registro canónico y vecinos mediante listas enlazadas manuales | `Dict{Int, Vector{Int}}` o tablas hash | Cumple el mandato estricto de implementación manual de las estructuras y algoritmos con cotas `O(V)` y `O(d(u))`, evitando abstraer el aprendizaje en colecciones de biblioteca. / Satisfies the strict contract mandate of manual implementation with `O(V)` and `O(d(u))` bounds, avoiding delegating logic to library collections. |
| Retorno de copia independiente `Vector{Int}` en `get_neighbors` | Retornar la lista `NeighborNode` interna directamente | Garantiza el aislamiento contractual del resultado: mutaciones posteriores en el grafo o en la lista devuelta no interfieren mutuamente. / Ensures contractually required isolation: subsequent mutations to the graph or returned list do not interfere with each other. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| Base `Node(value)` por herencia | Valor embebido (`value::Int` en `TreeNode` y `GraphNode`) | Julia no soporta subtipado entre estructuras concretas; la especificación autoriza el valor embebido como alternativa válida. / Julia does not support subtyping between concrete structs; the specification authorizes embedded value as a valid alternative. |
| `set_left`, `set_right`, `insert`, `add_vertex`, `add_edge` | `set_left!`, `set_right!`, `insert!`, `add_vertex!`, `add_edge!` | Convención estándar en Julia para indicar funciones que mutan sus argumentos. / Standard Julia convention marking functions mutating their arguments. |
| `is_empty()`, `size()` | `isempty(x)` y `length(x)` extendiendo `Base` | Nombres idiomáticos de Julia para colecciones. / Idiomatic Julia names for collection queries. |
| Representación de ausencia en enlaces e indicador de fallo en `get_neighbors` | `nothing` (tipo `Nothing`) | Representación nativa de ausencia de valor o enlace en Julia. / Native Julia representation of missing value or link. |
| Fallo booleano en `contains`, `add_edge`, `has_edge` | `false` (tipo `Bool`) | Retorno idiomático para operaciones con resultado de éxito/fracaso booleano. / Idiomatic return for boolean success/failure operations. |
| `test/data_structures_advanced_test.ext` (singular) | `test/data_structures_advanced_tests.jl` (plural) | Convención de nombres del monorepo en Julia (`data_structures_basics_tests.jl`, `numbers`). / Repository convention for Julia modules. |
| Caso de prueba «Adaptación inmutable (si aplica)» | Omitido con justificación | `TreeNode` en Julia es un `mutable struct` que muta en el sitio; no aplica la variante inmutable. / Julia's `TreeNode` is an in-place mutating `mutable struct`; immutable variant does not apply. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `TreeNode.get_left` | Enlace izquierdo ausente | `nothing` | `get_left(TreeNode(10)) === nothing` |
| `TreeNode.get_right` | Enlace derecho ausente | `nothing` | `get_right(TreeNode(10)) === nothing` |
| `BinaryTree.contains` | Valor ausente en el árbol | `false` | `contains(BinaryTree(), 99) == false` |
| `Graph.add_edge!` | Extremo `u` o `v` no registrado | `false` | `add_edge!(Graph(), 10, 99) == false` |
| `Graph.has_edge` | Arista ausente o extremo no registrado | `false` | `has_edge(Graph(), 10, 30) == false` |
| `Graph.get_neighbors` | Vértice `u` no registrado en el grafo | `nothing` | `get_neighbors(Graph(), 99) === nothing` |

---

## ✅ Cobertura de pruebas / Test coverage

**Agrupación / Grouping:**
- `TreeNode` → casos 1 a 5 (inmutable omitido) → `@testset "TreeNode"` → `test/data_structures_advanced_tests.jl` → `test/run_tests.jl`
- `BinaryTree` → casos 1 a 7 → `@testset "BinaryTree"` → `test/data_structures_advanced_tests.jl` → `test/run_tests.jl`
- `Graph` → casos 1 a 11 → `@testset "Graph"` → `test/data_structures_advanced_tests.jl` → `test/run_tests.jl`

### `TreeNode`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Crear un nodo de árbol | Sí | `test/data_structures_advanced_tests.jl` — `@testset "caso 1: crear un nodo de árbol"` | Valida `get_value(node) == 10` |
| Enlaces iniciales ausentes | Sí | `@testset "caso 2: enlaces iniciales ausentes"` | Comprueba enlaces `nothing` |
| Enlazar dos hijos | Sí | `@testset "caso 3: enlazar dos hijos"` | Asigna hijos 20 y 30 con `set_left!` y `set_right!` |
| Recorrer cada enlace | Sí | `@testset "caso 4: recorrer cada enlace"` | Recorre hijos y comprueba que sus enlaces son `nothing` |
| Desenlazar hijos | Sí | `@testset "caso 5: desenlazar hijos"` | Desenlaza izquierdo y derecho con `nothing` preservando valor |
| Adaptación inmutable (si aplica) | Omitido | — | No aplica: `TreeNode` es mutable en Julia y muta en el sitio |

### `BinaryTree`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Crear vacío | Sí | `@testset "caso 1: crear vacío"` | `isempty`, `length == 0`, `!contains(50)` |
| Insertar la raíz | Sí | `@testset "caso 2: insertar la raíz"` | Inserta 50, valida tamaño 1 y presencia |
| Insertar menor y mayor | Sí | `@testset "caso 3: insertar menor y mayor"` | Inserta 50, 30, 70; tamaño 3 y pertenencia |
| Ramas de varios niveles | Sí | `@testset "caso 4: ramas de varios niveles"` | Inserta 50, 30, 70, 20, 40; tamaño 5 |
| Valor ausente en árbol no vacío | Sí | `@testset "caso 5: valor ausente en árbol no vacío"` | `!contains(99)` en árbol con 50 |
| Duplicado idempotente | Sí | `@testset "caso 6: duplicado idempotente"` | Inserta 30 duplicado; tamaño permanece en 3 |
| Inserciones ordenadas | Sí | `@testset "caso 7: inserciones ordenadas"` | Inserta 20, 30, 40, 50, 70 en orden; valida tamaño 5 |

### `Graph`

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| Crear vacío | Sí | `@testset "caso 1: crear vacío"` | `isempty`, 0 vértices, 0 aristas, `has_edge` y `get_neighbors` fallan |
| Vértice aislado | Sí | `@testset "caso 2: vértice aislado"` | Vértice 10; vecinos vacíos `Int[]`, 1 vértice, 0 aristas |
| Etiquetas no consecutivas y arista dirigida | Sí | `@testset "caso 3: etiquetas no consecutivas y arista dirigida"` | Arista 10 → 70 existe, 70 → 10 no existe |
| Vértice duplicado conserva adyacencia | Sí | `@testset "caso 4: vértice duplicado conserva adyacencia"` | Re-registro de 10 conserva vecinos `[30]` |
| Arista duplicada | Sí | `@testset "caso 5: arista duplicada"` | Arista repetida 10 → 30 mantiene 1 arista y `[30]` |
| Extremo inexistente sin mutación | Sí | `@testset "caso 6: extremo inexistente sin mutación"` | 4 intentos con extremos inexistentes fallan sin alterar grafo |
| Vecinos ordenados y contadores | Sí | `@testset "caso 7: vecinos ordenados y contadores"` | Vecinos de 10 son `[30, 50, 70]`, de 30 son `[50]`, contadores 4 y 4 |
| Consulta de arista ausente | Sí | `@testset "caso 8: consulta de arista ausente"` | `has_edge(10, 30) == false` con 0 aristas |
| Vecinos de vértice inexistente | Sí | `@testset "caso 9: vecinos de vértice inexistente"` | `get_neighbors(99) === nothing` frente a `Int[]` de vértice 10 |
| Bucle y duplicado | Sí | `@testset "caso 10: bucle y duplicado"` | Arista 10 → 10 dos veces; vecinos `[10]`, 1 arista |
| Aislamiento del resultado de vecinos | Sí | `@testset "caso 11: aislamiento del resultado de vecinos"` | Modificar copia o agregar aristas posteriores no afecta consultas previas |

**Total: 137 aserciones (`@test`), todas en verde.**  
**Total: 137 assertions (`@test`), all passing.**

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Ninguna / None | No aplica / Not applicable | El módulo cumple todas las operaciones del contrato con las complejidades declaradas. No introduce capacidades artificiales y mantiene implementaciones enlazadas manuales. / The module fulfils all contract operations with declared complexities. Introduces no artificial limits and keeps manual linked structures. |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** **Base Node con valor embebido**: Dado que en Julia no existe la herencia de campos entre estructuras concretas, `TreeNode` y `GraphNode` declaran el campo `value::Int` directamente en sus definiciones. Esto implementa limpiamente la opción de valor embebido autorizada por la especificación del módulo.
- **EN:** **Node base via embedded value**: Since field inheritance between concrete structs does not exist in Julia, `TreeNode` and `GraphNode` declare `value::Int` directly within their definitions, cleanly adhering to the embedded value pattern permitted by the specification.

- **ES:** **Implementación iterativa**: Las operaciones `insert!` y `contains` en `BinaryTree` se implementan mediante bucles iterativos `while` en lugar de recursión. Dado que Julia no garantiza la optimización de llamadas de cola (TCO), el enfoque iterativo asegura ejecución en `O(1)` de memoria auxiliar y previene desbordamientos de pila (`StackOverflowError`) en árboles desbalanceados.
- **EN:** **Iterative implementation**: `insert!` and `contains` in `BinaryTree` are implemented via iterative `while` loops instead of recursion. Since Julia does not guarantee Tail Call Optimization (TCO), iteration ensures `O(1)` auxiliary memory and prevents stack overflow (`StackOverflowError`) on degenerate trees.

- **ES:** **Implementación manual de Graph**: El registro de vértices es una lista simplemente enlazada (`GraphNode.next_vertex`), requiriendo `O(V)` para `find_vertex`. La lista de adyacencia (`NeighborNode`) se mantiene ordenada ascendentemente en cada inserción `O(d(u))`. No se recurre a `Dict`, `Set` ni operaciones automáticas de ordenación de biblioteca.
- **EN:** **Manual Graph implementation**: The vertex registry is a singly linked list (`GraphNode.next_vertex`), requiring `O(V)` for `find_vertex`. The adjacency list (`NeighborNode`) is maintained in ascending sorted order upon insertion `O(d(u))`. No `Dict`, `Set` or library sorting operations are used.

- **ES:** **Aislamiento en `get_neighbors`**: La operación construye un `Vector{Int}` nuevo al recorrer la lista enlazada de vecinos. Esto proporciona una copia aislada e independiente que satisface el criterio de no permitir que mutaciones externas alteren el grafo ni que inserciones posteriores modifiquen resultados obtenidos con anterioridad.
- **EN:** **Isolation in `get_neighbors`**: The operation builds a fresh `Vector{Int}` by traversing the linked neighbor list. This provides an isolated independent copy satisfying the criterion that external mutations do not affect the graph and later insertions do not alter previously fetched results.

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
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`../data_structures_basics/`](../data_structures_basics/) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`../../foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](https://yorche3.github.io/programming_languages/core/00_Project_Initialization_Guide/) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](https://yorche3.github.io/programming_languages/docs/AGENT_Template/) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](https://yorche3.github.io/programming_languages/docs/WORKFLOW/) |
| Documentación oficial del lenguaje / Language official docs | [Julia Documentation](https://docs.julialang.org/) |

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
