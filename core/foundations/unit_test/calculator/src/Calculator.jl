# Módulo Calculator — operaciones aritméticas con implementaciones educativas.
#
# multiplication: suma repetitiva (no usa el operador `*`).
# division:       resta repetitiva (no usa el operador `/`).
# modulus:        construido con division y multiplication (no usa el operador `%`).
module Calculator

export addition, subtraction, multiplication, division, modulus

"""
    addition(a, b)

Suma directa (`a + b`) — operación básica.
"""
addition(a, b) = a + b

"""
    subtraction(a, b)

Resta directa (`a - b`) — operación básica.
"""
subtraction(a, b) = a - b

"""
    multiplication(a, b)

Multiplicación por suma repetitiva: suma `a` consigo mismo `b` veces.
"""
function multiplication(a, b)
    result = 0
    for _ in 1:b
        result = addition(result, a)
    end
    return result
end

"""
    division(a, b)

División por resta repetitiva: cuenta cuántas veces cabe `b` en `a`.
(La división entre cero no está implementada en este ejemplo.)
"""
function division(a, b)
    quotient = 0
    while a >= b
        a = subtraction(a, b)
        quotient = addition(quotient, 1)
    end
    return quotient
end

"""
    modulus(a, b)

Módulo (resto de `a ÷ b`): usa `division` y `multiplication`.
"""
function modulus(a, b)
    q = division(a, b)
    p = multiplication(q, b)
    return subtraction(a, p)
end

end # module Calculator
