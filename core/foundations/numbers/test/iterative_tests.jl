# Tests del enfoque iterativo (_ite): 5 tests, 11 casos.
@testset "iterative" begin
    @testset "sum_of_first_n" begin
        @test sum_of_first_n_ite(0) == 0
        @test sum_of_first_n_ite(3) == 6
    end

    @testset "factorial" begin
        @test factorial_ite(0) == 1
        @test factorial_ite(4) == 24
    end

    @testset "fibonacci" begin
        @test fibonacci_ite(0) == 0
        @test fibonacci_ite(1) == 1
        @test fibonacci_ite(6) == 8
    end

    @testset "greatest_common_divisor" begin
        @test greatest_common_divisor_ite(12, 8) == 4
        @test greatest_common_divisor_ite(7, 5) == 1
    end

    @testset "least_common_multiple" begin
        @test least_common_multiple_ite(4, 6) == 12
        @test least_common_multiple_ite(6, 8) == 24
    end
end
