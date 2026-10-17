# run_tests.jl — Punto de entrada del módulo calculator.
#
# Convención del repositorio: cada módulo expone su runner en
# `test/run_tests.jl`, que es el comando que documenta el catálogo
# (`julia --project=. test/run_tests.jl`), como en `04_Numbers`.
#
# La suite vive en `CalculatorTest.jl` y también la ejecuta `Pkg.test()`.
include("CalculatorTest.jl")
