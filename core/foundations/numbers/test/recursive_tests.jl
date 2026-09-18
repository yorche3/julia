# Tests del enfoque recursivo directo (_rec): 5 tests, 11 casos.
@testset "recursive" begin
    @testset "sum_of_first_n" begin
        @test sum_of_first_n_rec(0) == 0
        @test sum_of_first_n_rec(3) == 6
    end

    @testset "factorial" begin
        @test factorial_rec(0) == 1
        @test factorial_rec(4) == 24
    end

    @testset "fibonacci" begin
        @test fibonacci_rec(0) == 0
        @test fibonacci_rec(1) == 1
        @test fibonacci_rec(6) == 8
    end

    @testset "greatest_common_divisor" begin
        @test greatest_common_divisor_rec(12, 8) == 4
        @test greatest_common_divisor_rec(7, 5) == 1
    end

    @testset "least_common_multiple" begin
        @test least_common_multiple_rec(4, 6) == 12
        @test least_common_multiple_rec(6, 8) == 24
    end
end
