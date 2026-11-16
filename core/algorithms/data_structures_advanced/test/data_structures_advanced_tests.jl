# Casos de prueba de la especificación 07_Data_Structures_Advanced.md.
#
# Cada caso usa una instancia recién creada y ejecuta sus pasos en orden. Las
# aserciones solo usan operaciones del contrato. La ausencia de enlace es
# `nothing`; el fallo de `get_neighbors` es `nothing`, distinto de `Int[]`.

const PARENT_VALUE_INPUT = 10
const LEFT_VALUE_INPUT = 20
const RIGHT_VALUE_INPUT = 30

const ROOT_VALUE_INPUT = 50
const LOWER_VALUE_INPUT = 30
const HIGHER_VALUE_INPUT = 70
const LOWER_LEFT_VALUE_INPUT = 20
const LOWER_RIGHT_VALUE_INPUT = 40
const MISSING_VALUE_INPUT = 99

const EMPTY_SIZE_OUTPUT = 0
const EMPTY_NEIGHBORS_OUTPUT = Int[]

@testset "TreeNode" begin
    @testset "caso 1: crear un nodo de árbol" begin
        node = TreeNode(PARENT_VALUE_INPUT)

        @test get_value(node) == PARENT_VALUE_INPUT
    end

    @testset "caso 2: enlaces iniciales ausentes" begin
        node = TreeNode(PARENT_VALUE_INPUT)

        @test get_left(node) === nothing
        @test get_right(node) === nothing
    end

    @testset "caso 3: enlazar dos hijos" begin
        parent = TreeNode(PARENT_VALUE_INPUT)
        set_left!(parent, TreeNode(LEFT_VALUE_INPUT))
        set_right!(parent, TreeNode(RIGHT_VALUE_INPUT))

        @test get_value(get_left(parent)) == LEFT_VALUE_INPUT
        @test get_value(get_right(parent)) == RIGHT_VALUE_INPUT
    end

    @testset "caso 4: recorrer cada enlace" begin
        parent = TreeNode(PARENT_VALUE_INPUT)
        set_left!(parent, TreeNode(LEFT_VALUE_INPUT))
        set_right!(parent, TreeNode(RIGHT_VALUE_INPUT))

        left = get_left(parent)
        right = get_right(parent)
        @test get_value(left) == LEFT_VALUE_INPUT
        @test get_value(right) == RIGHT_VALUE_INPUT
        @test get_left(left) === nothing
        @test get_right(left) === nothing
        @test get_left(right) === nothing
        @test get_right(right) === nothing
    end

    @testset "caso 5: desenlazar hijos" begin
        parent = TreeNode(PARENT_VALUE_INPUT)
        set_left!(parent, TreeNode(LEFT_VALUE_INPUT))
        set_right!(parent, TreeNode(RIGHT_VALUE_INPUT))

        set_left!(parent, nothing)
        @test get_left(parent) === nothing
        @test get_value(parent) == PARENT_VALUE_INPUT
        @test get_value(get_right(parent)) == RIGHT_VALUE_INPUT

        set_right!(parent, nothing)
        @test get_left(parent) === nothing
        @test get_right(parent) === nothing
        @test get_value(parent) == PARENT_VALUE_INPUT
    end

    # Caso «Adaptación inmutable (si aplica)»: no aplica, `TreeNode` es mutable
    # en Julia y `set_left!` modifica el nodo en el sitio.
end

@testset "BinaryTree" begin
    @testset "caso 1: crear vacío" begin
        tree = BinaryTree()

        @test isempty(tree)
        @test length(tree) == EMPTY_SIZE_OUTPUT
        @test !contains(tree, ROOT_VALUE_INPUT)
    end

    @testset "caso 2: insertar la raíz" begin
        tree = BinaryTree()

        @test insert!(tree, ROOT_VALUE_INPUT)
        @test length(tree) == 1
        @test !isempty(tree)
        @test contains(tree, ROOT_VALUE_INPUT)
    end

    @testset "caso 3: insertar menor y mayor" begin
        tree = BinaryTree()

        @test insert!(tree, ROOT_VALUE_INPUT)
        @test insert!(tree, LOWER_VALUE_INPUT)
        @test insert!(tree, HIGHER_VALUE_INPUT)
        @test length(tree) == 3
        @test contains(tree, ROOT_VALUE_INPUT)
        @test contains(tree, LOWER_VALUE_INPUT)
        @test contains(tree, HIGHER_VALUE_INPUT)
    end

    @testset "caso 4: ramas de varios niveles" begin
        tree = BinaryTree()
        values = [ROOT_VALUE_INPUT, LOWER_VALUE_INPUT, HIGHER_VALUE_INPUT,
                  LOWER_LEFT_VALUE_INPUT, LOWER_RIGHT_VALUE_INPUT]

        for value in values
            @test insert!(tree, value)
        end
        for value in values
            @test contains(tree, value)
        end
        @test length(tree) == 5
    end

    @testset "caso 5: valor ausente en árbol no vacío" begin
        tree = BinaryTree()
        insert!(tree, ROOT_VALUE_INPUT)

        @test !contains(tree, MISSING_VALUE_INPUT)
        @test length(tree) == 1
        @test contains(tree, ROOT_VALUE_INPUT)
    end

    @testset "caso 6: duplicado idempotente" begin
        tree = BinaryTree()

        @test insert!(tree, ROOT_VALUE_INPUT)
        @test insert!(tree, LOWER_VALUE_INPUT)
        @test insert!(tree, HIGHER_VALUE_INPUT)
        @test insert!(tree, LOWER_VALUE_INPUT)
        @test length(tree) == 3
        @test contains(tree, ROOT_VALUE_INPUT)
        @test contains(tree, LOWER_VALUE_INPUT)
        @test contains(tree, HIGHER_VALUE_INPUT)
    end

    @testset "caso 7: inserciones ordenadas" begin
        tree = BinaryTree()
        values = [LOWER_LEFT_VALUE_INPUT, LOWER_VALUE_INPUT, LOWER_RIGHT_VALUE_INPUT,
                  ROOT_VALUE_INPUT, HIGHER_VALUE_INPUT]

        for value in values
            @test insert!(tree, value)
        end
        @test length(tree) == 5
        for value in values
            @test contains(tree, value)
        end
        @test !contains(tree, MISSING_VALUE_INPUT)
    end
end

@testset "Graph" begin
    @testset "caso 1: crear vacío" begin
        graph = Graph()

        @test isempty(graph)
        @test vertex_count(graph) == 0
        @test edge_count(graph) == 0
        @test !has_edge(graph, 10, 30)
        @test get_neighbors(graph, 10) === nothing
    end

    @testset "caso 2: vértice aislado" begin
        graph = Graph()

        @test add_vertex!(graph, 10)
        @test !isempty(graph)
        @test vertex_count(graph) == 1
        @test edge_count(graph) == 0
        @test get_neighbors(graph, 10) == EMPTY_NEIGHBORS_OUTPUT
    end

    @testset "caso 3: etiquetas no consecutivas y arista dirigida" begin
        graph = Graph()
        add_vertex!(graph, 10)
        add_vertex!(graph, 70)

        @test add_edge!(graph, 10, 70)
        @test has_edge(graph, 10, 70)
        @test !has_edge(graph, 70, 10)
        @test vertex_count(graph) == 2
        @test edge_count(graph) == 1
    end

    @testset "caso 4: vértice duplicado conserva adyacencia" begin
        graph = Graph()

        @test add_vertex!(graph, 10)
        @test add_vertex!(graph, 30)
        @test add_edge!(graph, 10, 30)
        @test add_vertex!(graph, 10)
        @test vertex_count(graph) == 2
        @test edge_count(graph) == 1
        @test get_neighbors(graph, 10) == [30]
    end

    @testset "caso 5: arista duplicada" begin
        graph = Graph()
        add_vertex!(graph, 10)
        add_vertex!(graph, 30)

        @test add_edge!(graph, 10, 30)
        @test add_edge!(graph, 10, 30)
        @test vertex_count(graph) == 2
        @test edge_count(graph) == 1
        @test get_neighbors(graph, 10) == [30]
    end

    @testset "caso 6: extremo inexistente sin mutación" begin
        graph = Graph()
        add_vertex!(graph, 10)
        add_vertex!(graph, 30)
        add_edge!(graph, 10, 30)

        @test !add_edge!(graph, 10, 99)
        @test !add_edge!(graph, 99, 10)
        @test !add_edge!(graph, 98, 99)
        @test !add_edge!(graph, 99, 99)
        @test vertex_count(graph) == 2
        @test edge_count(graph) == 1
        @test get_neighbors(graph, 10) == [30]
        @test get_neighbors(graph, 30) == EMPTY_NEIGHBORS_OUTPUT
        @test !has_edge(graph, 10, 99)
        @test !has_edge(graph, 99, 10)
        @test !has_edge(graph, 98, 99)
        @test !has_edge(graph, 99, 99)
        @test get_neighbors(graph, 98) === nothing
        @test get_neighbors(graph, 99) === nothing
    end

    @testset "caso 7: vecinos ordenados y contadores" begin
        graph = Graph()
        for label in (10, 30, 50, 70)
            add_vertex!(graph, label)
        end

        @test add_edge!(graph, 10, 70)
        @test add_edge!(graph, 10, 30)
        @test add_edge!(graph, 10, 50)
        @test add_edge!(graph, 30, 50)
        @test get_neighbors(graph, 10) == [30, 50, 70]
        @test get_neighbors(graph, 30) == [50]
        @test get_neighbors(graph, 50) == EMPTY_NEIGHBORS_OUTPUT
        @test get_neighbors(graph, 70) == EMPTY_NEIGHBORS_OUTPUT
        @test vertex_count(graph) == 4
        @test edge_count(graph) == 4
    end

    @testset "caso 8: consulta de arista ausente" begin
        graph = Graph()
        add_vertex!(graph, 10)
        add_vertex!(graph, 30)

        @test !has_edge(graph, 10, 30)
        @test vertex_count(graph) == 2
        @test edge_count(graph) == 0
        @test !isempty(graph)
    end

    @testset "caso 9: vecinos de vértice inexistente" begin
        graph = Graph()
        add_vertex!(graph, 10)

        @test get_neighbors(graph, 99) === nothing
        @test get_neighbors(graph, 10) !== nothing
        @test get_neighbors(graph, 10) == EMPTY_NEIGHBORS_OUTPUT
        @test vertex_count(graph) == 1
        @test edge_count(graph) == 0
    end

    @testset "caso 10: bucle y duplicado" begin
        graph = Graph()
        add_vertex!(graph, 10)

        @test add_edge!(graph, 10, 10)
        @test add_edge!(graph, 10, 10)
        @test has_edge(graph, 10, 10)
        @test get_neighbors(graph, 10) == [10]
        @test vertex_count(graph) == 1
        @test edge_count(graph) == 1
    end

    @testset "caso 11: aislamiento del resultado de vecinos" begin
        graph = Graph()
        for label in (10, 30, 50)
            add_vertex!(graph, label)
        end
        add_edge!(graph, 10, 30)

        saved = get_neighbors(graph, 10)
        copy_result = get_neighbors(graph, 10)
        push!(copy_result, 99)

        @test get_neighbors(graph, 10) == [30]
        @test add_edge!(graph, 10, 50)
        @test saved == [30]
        @test get_neighbors(graph, 10) == [30, 50]
        @test vertex_count(graph) == 3
        @test edge_count(graph) == 2
    end
end
