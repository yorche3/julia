# Módulo DataStructuresBasics — celda enlazada compartida, lista, pila y cola.
#
# Especificación: 06_Data_Structures_Basics
#
# Contrato del paso 4b: tipos nuevos y firmas, con el cuerpo de cada operación en
# su indicador natural; el algoritmo es del paso 5 y la suite, del 4c.
#
# Indicadores: solo el enlace de un `Node` puede ser `nothing`; las operaciones que
# extraen un entero devuelven `Int` y su fallo es -1; las banderas devuelven `Bool`
# y su fallo es `false`; los contadores devuelven `Int` y parten de 0.
#
# El `init` del contrato son los constructores: `Node(value)` y
# `LinkedList()`/`Stack()`/`Queue()` sin argumentos.

module DataStructuresBasics

# Se extiende Base en lugar de taparlo.
import Base: push!, pop!, delete!, length, isempty, peek

export Node, LinkedList, Stack, Queue
export get_value, get_next, set_next!
export get_head, insert_head!, insert_tail!
export push!, pop!, peek, enqueue!, dequeue!

# ---------------------------------------------------------------------------
# Tipos
# ---------------------------------------------------------------------------

"""
Celda enlazada compartida por LinkedList, Stack y Queue.

El valor es inmutable tras la construcción; el enlace es mutable. `next` es el
único valor anulable del módulo.
"""
mutable struct Node
    value::Int
    next::Union{Nothing, Node}

    Node(value::Int) = new(value, nothing)
end

"""
Lista enlazada construida a mano sobre Node.

`LinkedList()` es el equivalente idiomático de `init()`: la lista vacía, con
cabeza y cola ausentes y contador a cero.
"""
mutable struct LinkedList
    head::Union{Nothing, Node}
    tail::Union{Nothing, Node}
    count::Int

    LinkedList() = new(nothing, nothing, 0)
end

"""
Pila LIFO construida a mano sobre Node.

`Stack()` es el equivalente idiomático de `init()`.
"""
mutable struct Stack
    top::Union{Nothing, Node}
    count::Int

    Stack() = new(nothing, 0)
end

"""
Cola FIFO construida a mano sobre Node.

`Queue()` es el equivalente idiomático de `init()`.
"""
mutable struct Queue
    front::Union{Nothing, Node}
    rear::Union{Nothing, Node}
    count::Int

    Queue() = new(nothing, nothing, 0)
end

# ---------------------------------------------------------------------------
# Node
# ---------------------------------------------------------------------------

"""
Valor de la celda (`get_value`).
"""
get_value(n::Node)::Int = n.value

"""
Enlace de la celda, o `nothing` cuando está ausente (`get_next`).
"""
get_next(n::Node)::Union{Nothing, Node} = n.next

"""
Actualiza el enlace de la celda y devuelve la misma celda (`set_next`).
"""
function set_next!(n::Node, next::Union{Nothing, Node})::Node
    n.next = next
    return n
end

# ---------------------------------------------------------------------------
# LinkedList
# ---------------------------------------------------------------------------

"""
Valor de la cabeza, o -1 cuando la lista está vacía (`get_head`).
"""
get_head(l::LinkedList)::Int = isnothing(l.head) ? -1 : l.head.value

"""
Inserta el valor al principio de la lista (`insert_head`).
"""
function insert_head!(l::LinkedList, value::Int)::LinkedList
    new_node = Node(value)
    if isnothing(l.head)
        l.head = new_node
        l.tail = new_node
    else
        new_node.next = l.head
        l.head = new_node
    end
    l.count += 1
    return l
end

"""
Inserta el valor al final de la lista (`insert_tail`).
"""
function insert_tail!(l::LinkedList, value::Int)::LinkedList
    new_node = Node(value)
    if isnothing(l.tail)
        l.head = new_node
        l.tail = new_node
    else
        l.tail.next = new_node
        l.tail = new_node
    end
    l.count += 1
    return l
end

"""
Elimina la primera aparición del valor (`delete`): `true` cuando estaba y `false`
cuando no está.
"""
function delete!(l::LinkedList, value::Int)::Bool
    previous = nothing
    current = l.head
    while !isnothing(current)
        if current.value == value
            if isnothing(previous)
                l.head = current.next
            else
                previous.next = current.next
            end
            if isnothing(current.next)
                l.tail = previous
            end
            l.count -= 1
            return true
        end
        previous = current
        current = current.next
    end
    return false
end

"""
Número de nodos de la lista (`size`).
"""
length(l::LinkedList)::Int = l.count

"""
Informa si la lista no tiene nodos (`is_empty`).
"""
isempty(l::LinkedList)::Bool = l.count == 0

# ---------------------------------------------------------------------------
# Stack
# ---------------------------------------------------------------------------

"""
Apila el valor sobre el tope (`push`).
"""
function push!(s::Stack, value::Int)::Stack
    new_node = Node(value)
    if isnothing(s.top)
        s.top = new_node
    else
        new_node.next = s.top
        s.top = new_node
    end
    s.count += 1
    return s
end

"""
Extrae el tope, o -1 cuando la pila está vacía (`pop`).
"""
function pop!(s::Stack)::Int
    if isnothing(s.top)
        return -1
    else
        value = s.top.value
        s.top = s.top.next
        s.count -= 1
        return value
    end
end

"""
Observa el tope sin extraerlo, o -1 cuando la pila está vacía (`peek`).
"""
peek(s::Stack)::Int = isnothing(s.top) ? -1 : s.top.value

"""
Número de nodos de la pila (`size`).
"""
length(s::Stack)::Int = s.count

"""
Informa si la pila no tiene nodos (`is_empty`).
"""
isempty(s::Stack)::Bool = s.count == 0

# ---------------------------------------------------------------------------
# Queue
# ---------------------------------------------------------------------------

"""
Añade el valor por el final de la cola (`enqueue`).
"""
function enqueue!(q::Queue, value::Int)::Queue
    new_node = Node(value)
    if isnothing(q.rear)
        q.front = new_node
        q.rear = new_node
    else
        q.rear.next = new_node
        q.rear = new_node
    end
    q.count += 1
    return q
end

"""
Extrae el frente, o -1 cuando la cola está vacía (`dequeue`).
"""
function dequeue!(q::Queue)::Int
    if isempty(q)
        return -1
    else
        value = q.front.value
        q.front = q.front.next
        if isnothing(q.front)
            q.rear = nothing
        end
        q.count -= 1
        return value
    end
end

"""
Observa el frente sin extraerlo, o -1 cuando la cola está vacía (`peek`).
"""
peek(q::Queue)::Int = isnothing(q.front) ? -1 : q.front.value

"""
Número de nodos de la cola (`size`).
"""
length(q::Queue)::Int = q.count

"""
Informa si la cola no tiene nodos (`is_empty`).
"""
isempty(q::Queue)::Bool = q.count == 0

end # module DataStructuresBasics
