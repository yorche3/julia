# Punto de entrada de las pruebas (nombre de la especificación: run_tests).
# Se ejecuta directo con: julia --project=. test/run_tests.jl
# Nota: `Pkg.test()` usa por convención el nombre test/run_tests.jl.
using Test

include(joinpath(@__DIR__, "..", "src", "Numbers.jl"))
using .Numbers

@testset "Numbers Tests" begin
    include(joinpath(@__DIR__, "recursive_tests.jl"))
    include(joinpath(@__DIR__, "iterative_tests.jl"))
end
