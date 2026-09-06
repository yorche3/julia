# Hello, World! — Julia

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Julia**, ejecutada con el binario `julia`, con un enfoque manual y minimalista.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
| ------- | --------- |
| [`helloworld.jl`](helloworld.jl) | Código fuente: imprime `"Hello, World! from Julia!"` en la consola. |

**Estructura de directorios esperada:**

```text
helloworld/
├── helloworld.jl   # Código fuente
└── README.md       # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente, sin herramientas de scaffolding ni gestores de paquetes (Pkg), para mantener la máxima sencillez. Un único archivo `.jl` con una llamada a `println` es suficiente.

**EN:** The project was created manually, without scaffolding tools or package managers (Pkg), to keep it as simple as possible. A single `.jl` file with one `println` call is enough.

Características / Features:

- **Sin dependencias externas** — solo usa `println` de `Base`, el módulo del core de Julia.
- **Ejecución directa** — no requiere compilación previa; Julia compila y ejecuta el script en un solo paso.
- **Sin archivo de proyecto** — no se necesita `Project.toml` para scripts simples.

### Inicialización / Initialization

1. Crear la estructura de directorios:

   ```bash
   mkdir -p julia/core/foundations/helloworld
   ```

2. Escribir el archivo `helloworld.jl` con el código fuente.

3. No se necesita ningún paso adicional de construcción o vinculación de dependencias.

---

## 📄 Archivos de configuración clave / Key Configuration Files

No se requieren archivos de configuración. El programa se ejecuta directamente con el binario de Julia, sin `Project.toml` ni dependencias externas.

```julia
#!/usr/bin/julia
println("Hello, World! from Julia!")
```

| Elemento | Propósito |
| -------- | --------- |
| `#!/usr/bin/julia` | Shebang opcional: permite ejecutar el script directamente como `./helloworld.jl` (si el archivo tiene permiso de ejecución). |
| `println(...)` | Función de `Base` que imprime el argumento en la salida estándar seguido de un salto de línea. |
| `"Hello, World! from Julia!"` | Cadena literal que se muestra en la salida estándar. |

> **ES:** En Julia no se requiere una función `main` explícita; el código de nivel superior del script se ejecuta en orden al iniciar el programa.
> **EN:** Julia does not require an explicit `main` function; top-level code in the script runs in order when the program starts.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Julia instalado

Julia 1.12 se instaló en este entorno con [juliaup](https://github.com/JuliaLang/juliaup):

```bash
# Opción 1: con juliaup (recomendado)
curl -fsSL https://install.julialang.org | sh

# Opción 2: descargar el instalador oficial
# Ver: https://julialang.org/downloads/
```

### Ejecutar / Run

```bash
# Ejecutar el script directamente (recomendado)
cd julia/core/foundations/helloworld
julia helloworld.jl

# Alternativa: usar el shebang y el permiso de ejecución
chmod +x helloworld.jl
./helloworld.jl
```

**Salida esperada / Expected output:**

```text
Hello, World! from Julia!
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** Julia es un lenguaje compilado *just-in-time* (JIT); al ejecutar `julia helloworld.jl` la primera llamada compila el código y las siguientes son rápidas.
- **EN:** Julia is a *just-in-time* (JIT) compiled language; when running `julia helloworld.jl`, the first invocation compiles the code and subsequent ones are fast.
- **ES:** `println` pertenece al módulo `Base`, que se importa automáticamente en todos los programas de Julia.
- **EN:** `println` belongs to the `Base` module, which is imported automatically into every Julia program.
- **ES:** No se necesita `Project.toml` para scripts simples; solo se requiere cuando hay dependencias externas gestionadas con `Pkg`.
- **EN:** No `Project.toml` file is needed for simple scripts; it's only required when there are external dependencies managed with `Pkg`.

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
