# Tests de la especificación 05_Naive_Sort: 3 algoritmos × 8 casos.
#
# Caso nulo incluido: Julia no tiene `null`, así que el indicador de fallo del
# contrato es `nothing`, y se comprueba con `=== nothing` en lugar de comparar
# contenidos.

# Casos de prueba de la especificación 05_Naive_Sort.md
const STANDARD_INPUT = [5, 2, 9, 1, 5, 6]
const STANDARD_OUTPUT = [1, 2, 5, 5, 6, 9]

const SORTED_INPUT = [1, 2, 3, 4, 5]
const SORTED_OUTPUT = [1, 2, 3, 4, 5]

const REVERSE_INPUT = [5, 4, 3, 2, 1]
const REVERSE_OUTPUT = [1, 2, 3, 4, 5]

const IDENTICAL_INPUT = [7, 7, 7, 7]
const IDENTICAL_OUTPUT = [7, 7, 7, 7]

const NEGATIVE_INPUT = [3, -1, 4, -5, 0]
const NEGATIVE_OUTPUT = [-5, -1, 0, 3, 4]

const SINGLE_INPUT = [42]
const SINGLE_OUTPUT = [42]

const EMPTY_INPUT = Int[]
const EMPTY_OUTPUT = Int[]

const CASES = [
    ("an unsorted array", STANDARD_INPUT, STANDARD_OUTPUT),
    ("an already sorted array", SORTED_INPUT, SORTED_OUTPUT),
    ("a reverse ordered array", REVERSE_INPUT, REVERSE_OUTPUT),
    ("an array of identical elements", IDENTICAL_INPUT, IDENTICAL_OUTPUT),
    ("an array with negative numbers", NEGATIVE_INPUT, NEGATIVE_OUTPUT),
    ("a single element array", SINGLE_INPUT, SINGLE_OUTPUT),
    ("an empty array", EMPTY_INPUT, EMPTY_OUTPUT),
    ("a null input", nothing, nothing),
]

# Helper compartido: recibe la función a probar y el nombre del algoritmo, y
# ejecuta todos los casos con un mensaje descriptivo cada uno.
#
# Cada caso ordena una copia del fixture (`copy`), porque los algoritmos ordenan
# in-place y los arrays de Julia son mutables.
function assert_sorts_all_cases(sort_fn, algorithm)
    for (description, input, expected) in CASES
        @testset "$algorithm should sort $description" begin
            input_copy = input === nothing ? nothing : copy(input)
            result = sort_fn(input_copy)
            if expected === nothing
                @test result === nothing
            else
                @test result == expected
            end
        end
    end
end

@testset "selection_sort" begin
    assert_sorts_all_cases(selection_sort, "selection_sort")
end

@testset "bubble_sort" begin
    assert_sorts_all_cases(bubble_sort, "bubble_sort")
end

@testset "insertion_sort" begin
    assert_sorts_all_cases(insertion_sort, "insertion_sort")
end
