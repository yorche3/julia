# Hello, User! — Julia

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **Julia**, ejecutada con el binario `julia`.

Lee un nombre desde la entrada estándar y saluda al usuario.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hellouser.jl`](hellouser.jl) | Código fuente: solicita un nombre al usuario y saluda. |

**Estructura de directorios esperada:**

```text
hellouser/
├── hellouser.jl    # Código fuente
└── README.md       # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce dos conceptos nuevos respecto a `helloworld`:

1. **Lectura de entrada** — `readline()` lee una línea completa desde `stdin`.
2. **Interpolación de cadenas** — `$(name)` inserta el nombre dentro del saludo.

**EN:** This program introduces two new concepts compared to `helloworld`:

1. **Input reading** — `readline()` reads a full line from `stdin`.
2. **String interpolation** — `$(name)` inserts the name into the greeting.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `hellouser.jl`

**ES:** El flujo del programa es:

1. Imprimir `"Enter your name: "` con `print` (sin salto de línea, para que el cursor quede junto al prompt).
2. Leer el nombre con `readline()`.
3. Imprimir `"Hello, <nombre>!"` interpolando la variable con `$(name)`.

**EN:** Program flow:

1. Print `"Enter your name: "` with `print` (no newline, so the cursor stays next to the prompt).
2. Read the name with `readline()`.
3. Print `"Hello, <name>!"` interpolating the variable with `$(name)`.

```julia
#!/usr/bin/julia
print("Enter your name: ");
name = readline()

println("Hello, $(name)!")
```

| Elemento | Propósito |
|----------|-----------|
| `print(...)` | Imprime el prompt sin añadir salto de línea al final. |
| `readline()` | Lee una línea completa (hasta Enter) desde la entrada estándar. |
| `name` | Variable local que almacena el nombre ingresado. |
| `$(name)` | Interpolación de cadenas: inserta el valor de la variable en el literal. |
| `println(...)` | Imprime el saludo con un salto de línea al final. |

> **ES:** `readline()` lee desde `stdin` y retorna la cadena **sin** el salto de línea final.
> **EN:** `readline()` reads from `stdin` and returns the string **without** the trailing newline.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Julia instalado

Julia 1.12 se instaló en este entorno con [juliaup](https://github.com/JuliaLang/juliaup):

```bash
curl -fsSL https://install.julialang.org | sh
```

### Ejecutar / Run

```bash
cd julia/core/foundations/hellouser
julia hellouser.jl
```

**Salida esperada / Expected output:**

```text
Enter your name: Ada
Hello, Ada!
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** `print` no añade salto de línea, a diferencia de `println`, por lo que el cursor queda junto al prompt a la espera de la entrada del usuario.
- **EN:** `print` does not add a newline, unlike `println`, so the cursor stays next to the prompt waiting for user input.
- **ES:** Julia usa interpolación de cadenas con `$(expr)`: cualquier expresión válida se evalúa y se inserta dentro del literal.
- **EN:** Julia uses string interpolation with `$(expr)`: any valid expression is evaluated and inserted into the literal.
- **ES:** `readline()` retorna la línea sin el salto de línea final, así que no hay que limpiar el resultado antes de saludar.
- **EN:** `readline()` returns the line without the trailing newline, so there is no need to clean the result before greeting.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
