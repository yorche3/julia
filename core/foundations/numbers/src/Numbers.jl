# Módulo Numbers — algoritmos numéricos clásicos en tres enfoques.
#
# Enfoques (sufijos de las funciones):
#   _rec: recursión directa (definición matemática).
#   _acc: recursión con acumulador (tail-call style) — puente didáctico.
#   _ite: iterativo (bucles, memoria constante O(1)).
#
# Helpers privados con sufijo `_help` (no se exportan).

module Numbers

# Suma de los primeros n números
export sum_of_first_n_rec, sum_of_first_n_acc, sum_of_first_n_ite
# Factorial
export factorial_rec, factorial_acc, factorial_ite
# Fibonacci
export fibonacci_rec, fibonacci_acc, fibonacci_ite
# Máximo común divisor
export greatest_common_divisor_rec, greatest_common_divisor_acc, greatest_common_divisor_ite
# Mínimo común múltiplo
export least_common_multiple_rec, least_common_multiple_acc, least_common_multiple_ite

# ---------------------------------------------------------------------------
# Recursión directa (_rec)
# ---------------------------------------------------------------------------

sum_of_first_n_rec(n) = n == 0 ? 0 : n + sum_of_first_n_rec(n - 1)

factorial_rec(n) = n == 0 ? 1 : n * factorial_rec(n - 1)

fibonacci_rec(n) = n <= 1 ? n : fibonacci_rec(n - 1) + fibonacci_rec(n - 2)

greatest_common_divisor_rec(a, b) = b == 0 ? a : greatest_common_divisor_rec(b, mod(a, b))

least_common_multiple_rec(a, b) = div(a * b, greatest_common_divisor_rec(a, b))

# ---------------------------------------------------------------------------
# Recursión con acumulador (_acc, tail-call style)
# Julia no garantiza TCO, así que estas variantes se conservan como puente
# didáctico entre _rec e _ite; no tienen pruebas unitarias propias.
# ---------------------------------------------------------------------------

sum_of_first_n_acc(n) = sum_of_first_n_acc_help(n, 0)
sum_of_first_n_acc_help(n, acc) = n <= 0 ? acc : sum_of_first_n_acc_help(n - 1, n + acc)

factorial_acc(n) = factorial_acc_help(n, 1)
factorial_acc_help(n, acc) = n <= 1 ? acc : factorial_acc_help(n - 1, n * acc)

fibonacci_acc(n) = fibonacci_acc_help(n, 0, 1)
function fibonacci_acc_help(n, acc2, acc1)
    n <= 0 && return acc2
    n <= 2 && return acc1 + acc2
    return fibonacci_acc_help(n - 1, acc1, acc1 + acc2)
end

greatest_common_divisor_acc(a, b) = greatest_common_divisor_acc_help(a, b)
greatest_common_divisor_acc_help(a, b) = b == 0 ? a : greatest_common_divisor_acc_help(b, mod(a, b))

least_common_multiple_acc(a, b) = div(a * b, greatest_common_divisor_acc(a, b))

# ---------------------------------------------------------------------------
# Iterativo (_ite): bucles, sin recursión, memoria constante O(1)
# ---------------------------------------------------------------------------

function sum_of_first_n_ite(n)
    result = 0
    for i in 1:n
        result += i
    end
    return result
end

function factorial_ite(n)
    result = 1
    for i in 2:n
        result *= i
    end
    return result
end

function fibonacci_ite(n)
    n <= 1 && return n
    acc2 = 0
    acc1 = 1
    for _ in 2:n
        temp = acc1 + acc2
        acc2 = acc1
        acc1 = temp
    end
    return acc1
end

function greatest_common_divisor_ite(a, b)
    while b != 0
        temp = b
        b = mod(a, b)
        a = temp
    end
    return a
end

least_common_multiple_ite(a, b) = div(a * b, greatest_common_divisor_ite(a, b))

end # module Numbers
