# Punto de entrada estándar de las pruebas.
# `Pkg.test()` ejecuta automáticamente este archivo (convención de Julia);
# también funciona directo con: julia --project=. test/runtests.jl
using Test

include(joinpath(@__DIR__, "..", "src", "Calculator.jl"))
using .Calculator

@testset "Calculator Tests" begin
    @testset "addition" begin
        @test addition(2, 3) == 5
    end

    @testset "subtraction" begin
        @test subtraction(5, 2) == 3
    end

    @testset "multiplication" begin
        @test multiplication(3, 4) == 12
    end

    @testset "division" begin
        @test division(10, 3) == 3
    end

    @testset "modulus" begin
        @test modulus(10, 3) == 1
    end
end
