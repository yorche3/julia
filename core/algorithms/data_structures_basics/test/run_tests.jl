# Punto de entrada de las pruebas (nombre de la especificación: run_tests).
# Se ejecuta directo con: julia --project=. test/run_tests.jl
# Nota: `Pkg.test()` usa por convención el nombre test/run_tests.jl.
using Test

include(joinpath(@__DIR__, "..", "src", "data_structures_basics.jl"))
using .DataStructuresBasics

@testset "Data Structures Basics Tests" begin
    include(joinpath(@__DIR__, "data_structures_basics_tests.jl"))
end
