# Tests del enfoque iterativo (_ite): 11 casos.
@testset "iterative" begin
    # sum_of_first_n
    @test sum_of_first_n_ite(0) == 0
    @test sum_of_first_n_ite(3) == 6

    # factorial
    @test factorial_ite(0) == 1
    @test factorial_ite(4) == 24

    # fibonacci
    @test fibonacci_ite(0) == 0
    @test fibonacci_ite(1) == 1
    @test fibonacci_ite(6) == 8

    # greatest_common_divisor
    @test greatest_common_divisor_ite(12, 8) == 4
    @test greatest_common_divisor_ite(7, 5) == 1

    # least_common_multiple
    @test least_common_multiple_ite(4, 6) == 12
    @test least_common_multiple_ite(6, 8) == 24
end
