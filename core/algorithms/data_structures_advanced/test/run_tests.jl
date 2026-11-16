# Punto de entrada de las pruebas (nombre de la especificación: run_tests).
# Se ejecuta directo con: julia --project=. test/run_tests.jl
# Nota: `Pkg.test()` usa por convención el nombre test/run_tests.jl.
using Test

include(joinpath(@__DIR__, "..", "src", "data_structures_advanced.jl"))
using .data_structures_advanced

@testset "Data Structures Advanced Tests" begin
    include(joinpath(@__DIR__, "data_structures_advanced_tests.jl"))
end
