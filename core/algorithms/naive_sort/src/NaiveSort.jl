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

function selection_sort(arr)
    if arr === nothing return nothing end
    n = length(arr)
    if n <= 1 return arr end
    for i in 1:n-1
        min_index = i
        for j in i+1:n
            if arr[j] < arr[min_index]
                min_index = j
            end
        end
        if min_index != i
            arr[i], arr[min_index] = arr[min_index], arr[i]
        end
    end
    return arr
end

function bubble_sort(arr)
    if arr === nothing return nothing end
    n = length(arr)
    if n <= 1 return arr end
    for i in 1:n-1
        swapped = false
        for j in 1:n-i
            if arr[j] > arr[j+1]
                arr[j], arr[j+1] = arr[j+1], arr[j]
                swapped = true
            end
        end
        if !swapped break end
    end
    return arr
end

function insertion_sort(arr)
    if arr === nothing return nothing end
    n = length(arr)
    if n <= 1 return arr end
    for i in 2:n
        key = arr[i]
        j = i - 1
        while j >= 1 && arr[j] > key
            arr[j+1] = arr[j]
            j -= 1
        end
        arr[j+1] = key
    end
    return arr
end

end # module NaiveSort
