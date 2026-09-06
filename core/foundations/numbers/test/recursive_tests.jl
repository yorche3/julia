# Tests del enfoque recursivo directo (_rec): 11 casos.
@testset "recursive" begin
    # sum_of_first_n
    @test sum_of_first_n_rec(0) == 0
    @test sum_of_first_n_rec(3) == 6

    # factorial
    @test factorial_rec(0) == 1
    @test factorial_rec(4) == 24

    # fibonacci
    @test fibonacci_rec(0) == 0
    @test fibonacci_rec(1) == 1
    @test fibonacci_rec(6) == 8

    # greatest_common_divisor
    @test greatest_common_divisor_rec(12, 8) == 4
    @test greatest_common_divisor_rec(7, 5) == 1

    # least_common_multiple
    @test least_common_multiple_rec(4, 6) == 12
    @test least_common_multiple_rec(6, 8) == 24
end
