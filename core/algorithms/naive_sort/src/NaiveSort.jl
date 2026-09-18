# Módulo NaiveSort — ordenamientos elementales O(n²).
#
# Especificación: 05_Naive_Sort
#
# Contrato de las funciones (arr -> arr), de menor a mayor:
#   selection_sort: encuentra el mínimo del tramo no ordenado y lo ubica al inicio.
#   bubble_sort:    compara e intercambia adyacentes, con bandera `swapped`.
#   insertion_sort: inserta cada elemento en su sub-array ordenado.
#
# Caso nulo: Julia no tiene `null`, así que el indicador de fallo es `nothing`
# (el valor singleton de `Nothing`), que se devuelve tal cual sin lanzar errores.

module NaiveSort

export selection_sort, bubble_sort, insertion_sort

end # module NaiveSort
