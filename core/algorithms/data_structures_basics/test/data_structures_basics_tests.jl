# Casos de prueba de la especificación 06_Data_Structures_Basics.md.
#
# Los pasos de cada estructura son sucesivos sobre la misma instancia: Julia es
# mutable, así que cada operación modifica la estructura ya creada y el escenario
# no se reinicia. Las aserciones solo usan operaciones del contrato: los enlaces
# de `Node` se observan con `nothing` porque son la única ausencia del módulo.

const NODE_A_INPUT = 10
const NODE_B_INPUT = 20

const LIST_FIRST_VALUE = 10
const LIST_SECOND_VALUE = 20
const LIST_HEAD_VALUE = 5
const LIST_ABSENT_VALUE = 99

const STACK_FIRST_VALUE = 10
const STACK_SECOND_VALUE = 20
const STACK_THIRD_VALUE = 30
const STACK_REUSE_VALUE = 40

const QUEUE_FIRST_VALUE = 10
const QUEUE_SECOND_VALUE = 20
const QUEUE_THIRD_VALUE = 30
const QUEUE_REUSE_VALUE = 40

const EMPTY_SIZE_OUTPUT = 0
const EMPTY_VALUE_OUTPUT = -1
const INSERTED_LIST_SIZE_OUTPUT = 4
const DELETED_LIST_SIZE_OUTPUT = 3

@testset "Node" begin
    @testset "caso 1: inicializar y observar valor/enlace" begin
        a = Node(NODE_A_INPUT)

        @test get_value(a) == NODE_A_INPUT
        @test get_next(a) === nothing
    end

    @testset "caso 2: inicializar otro nodo, enlazar y recorrer" begin
        a = Node(NODE_A_INPUT)
        b = Node(NODE_B_INPUT)
        set_next!(a, b)

        @test get_value(get_next(a)) == NODE_B_INPUT
        @test get_next(b) === nothing
    end
end

@testset "LinkedList" begin
    list = LinkedList()

    @testset "paso 1: estado vacío" begin
        @test isempty(list)
        @test length(list) == EMPTY_SIZE_OUTPUT
        @test get_head(list) == EMPTY_VALUE_OUTPUT
    end

    @testset "paso 2: insertar por ambos extremos" begin
        insert_tail!(list, LIST_FIRST_VALUE)
        insert_tail!(list, LIST_SECOND_VALUE)
        insert_head!(list, LIST_HEAD_VALUE)
        insert_tail!(list, LIST_FIRST_VALUE)

        @test length(list) == INSERTED_LIST_SIZE_OUTPUT
        @test get_head(list) == LIST_HEAD_VALUE
    end

    @testset "paso 3: eliminar la primera aparición" begin
        @test delete!(list, LIST_FIRST_VALUE)
        @test get_head(list) == LIST_HEAD_VALUE
        @test length(list) == DELETED_LIST_SIZE_OUTPUT
    end

    @testset "paso 4: valor ausente" begin
        @test !delete!(list, LIST_ABSENT_VALUE)
        @test get_head(list) == LIST_HEAD_VALUE
        @test length(list) == DELETED_LIST_SIZE_OUTPUT
    end

    @testset "paso 5: vaciar la lista" begin
        @test delete!(list, LIST_HEAD_VALUE)
        @test delete!(list, LIST_SECOND_VALUE)
        @test delete!(list, LIST_FIRST_VALUE)
        @test isempty(list)
        @test length(list) == EMPTY_SIZE_OUTPUT
        @test get_head(list) == EMPTY_VALUE_OUTPUT
    end
end

@testset "Stack" begin
    stack = Stack()

    @testset "paso 1: estado vacío y extracción fallida" begin
        @test isempty(stack)
        @test length(stack) == EMPTY_SIZE_OUTPUT
        @test peek(stack) == EMPTY_VALUE_OUTPUT
        @test pop!(stack) == EMPTY_VALUE_OUTPUT
        @test isempty(stack)
    end

    @testset "paso 2: LIFO y peek no mutante" begin
        push!(stack, STACK_FIRST_VALUE)
        push!(stack, STACK_SECOND_VALUE)
        push!(stack, STACK_THIRD_VALUE)

        @test peek(stack) == STACK_THIRD_VALUE
        @test length(stack) == 3
    end

    @testset "paso 3: extracción y reutilización" begin
        @test pop!(stack) == STACK_THIRD_VALUE
        push!(stack, STACK_REUSE_VALUE)
        @test pop!(stack) == STACK_REUSE_VALUE
        @test pop!(stack) == STACK_SECOND_VALUE
        @test pop!(stack) == STACK_FIRST_VALUE
        @test isempty(stack)
        @test length(stack) == EMPTY_SIZE_OUTPUT
    end

    @testset "paso 4: vacío tras extracción" begin
        @test pop!(stack) == EMPTY_VALUE_OUTPUT
        @test isempty(stack)
    end
end

@testset "Queue" begin
    queue = Queue()

    @testset "paso 1: estado vacío y extracción fallida" begin
        @test isempty(queue)
        @test length(queue) == EMPTY_SIZE_OUTPUT
        @test peek(queue) == EMPTY_VALUE_OUTPUT
        @test dequeue!(queue) == EMPTY_VALUE_OUTPUT
        @test isempty(queue)
    end

    @testset "paso 2: FIFO y peek no mutante" begin
        enqueue!(queue, QUEUE_FIRST_VALUE)
        enqueue!(queue, QUEUE_SECOND_VALUE)
        enqueue!(queue, QUEUE_THIRD_VALUE)

        @test peek(queue) == QUEUE_FIRST_VALUE
        @test length(queue) == 3
    end

    @testset "paso 3: extracción y reutilización" begin
        @test dequeue!(queue) == QUEUE_FIRST_VALUE
        enqueue!(queue, QUEUE_REUSE_VALUE)
        @test dequeue!(queue) == QUEUE_SECOND_VALUE
        @test dequeue!(queue) == QUEUE_THIRD_VALUE
        @test dequeue!(queue) == QUEUE_REUSE_VALUE
        @test isempty(queue)
        @test length(queue) == EMPTY_SIZE_OUTPUT
    end

    @testset "paso 4: vacío tras extracción" begin
        @test dequeue!(queue) == EMPTY_VALUE_OUTPUT
        @test isempty(queue)
    end
end
