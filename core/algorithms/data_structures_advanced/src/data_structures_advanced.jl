module data_structures_advanced

import Base: contains, isempty, length, insert!

export TreeNode, BinaryTree, Graph
export get_value, get_left, get_right, set_left!, set_right!
export insert!, contains, isempty, length
export add_vertex!, add_edge!, has_edge, get_neighbors, vertex_count, edge_count

mutable struct TreeNode
    value::Int
    left::Union{Nothing, TreeNode}
    right::Union{Nothing, TreeNode}

    TreeNode(value::Int) = new(value, nothing, nothing)
end

get_value(node::TreeNode)::Int = node.value
get_left(node::TreeNode)::Union{Nothing, TreeNode} = node.left
get_right(node::TreeNode)::Union{Nothing, TreeNode} = node.right
function set_left!(node::TreeNode, left::Union{Nothing, TreeNode})::Union{Nothing, TreeNode}
    node.left = left
    return node
end
function set_right!(node::TreeNode, right::Union{Nothing, TreeNode})::Union{Nothing, TreeNode}
    node.right = right
    return node
end

mutable struct BinaryTree
    root::Union{Nothing, TreeNode}
    count::Int

    BinaryTree() = new(nothing, 0)
end

function insert!(tree::BinaryTree, value::Int)::Bool
    if tree.root === nothing
        tree.root = TreeNode(value)
        tree.count += 1
        return true
    end
    current::TreeNode = tree.root
    while true
        if value == current.value
            return true
        elseif value < current.value
            if current.left === nothing
                current.left = TreeNode(value)
                tree.count += 1
                return true
            else
                current = current.left
            end
        else
            if current.right === nothing
                current.right = TreeNode(value)
                tree.count += 1
                return true
            else
                current = current.right
            end
        end
    end
end
function contains(tree::BinaryTree, value::Int)::Bool
    current = tree.root
    while current !== nothing
        if value == current.value
            return true
        elseif value < current.value
            current = current.left
        else
            current = current.right
        end
    end
    return false
end

isempty(tree::BinaryTree)::Bool = tree.count == 0
length(tree::BinaryTree)::Int = tree.count

mutable struct NeighborNode
    label::Int
    next::Union{Nothing, NeighborNode}
end

mutable struct GraphNode
    value::Int
    neighbors::Union{Nothing, NeighborNode}
    next_vertex::Union{Nothing, GraphNode}

    GraphNode(label::Int) = new(label, nothing, nothing)
end

mutable struct Graph
    vertices::Union{Nothing, GraphNode}
    vertex_total::Int
    edges::Int

    Graph() = new(nothing, 0, 0)
end

function find_vertex(graph::Graph, label::Int)::Union{Nothing, GraphNode}
    current = graph.vertices
    while current !== nothing
        if current.value == label
            return current
        end
        current = current.next_vertex
    end
    return nothing
end

function add_vertex!(graph::Graph, label::Int)::Bool
    find_vertex(graph, label) !== nothing && return true
    new_vertex = GraphNode(label)
    new_vertex.next_vertex = graph.vertices
    graph.vertices = new_vertex
    graph.vertex_total += 1
    return true
end
function add_edge!(graph::Graph, u::Int, v::Int)::Bool
    vertex_u = find_vertex(graph, u)
    vertex_u === nothing && return false
    find_vertex(graph, v) === nothing && return false
    current = vertex_u.neighbors
    while current !== nothing
        current.label == v && return true
        current = current.next
    end
    previous = nothing
    current = vertex_u.neighbors
    while current !== nothing && current.label < v
        previous = current
        current = current.next
    end
    new_node = NeighborNode(v, current)
    if previous === nothing
        vertex_u.neighbors = new_node
    else
        previous.next = new_node
    end
    graph.edges += 1
    return true
end
function has_edge(graph::Graph, u::Int, v::Int)::Bool
    vertex_u = find_vertex(graph, u)
    vertex_u === nothing && return false
    current = vertex_u.neighbors
    while current !== nothing
        current.label == v && return true
        current = current.next
    end
    return false
end
function get_neighbors(graph::Graph, u::Int)::Union{Nothing, Vector{Int}}
    vertex_u = find_vertex(graph, u)
    vertex_u === nothing && return nothing
    neighbors = Vector{Int}()
    current = vertex_u.neighbors
    while current !== nothing
        push!(neighbors, current.label)
        current = current.next
    end
    return neighbors
end
isempty(graph::Graph)::Bool = graph.vertex_total == 0
vertex_count(graph::Graph)::Int = graph.vertex_total
edge_count(graph::Graph)::Int = graph.edges

end # module data_structures_advanced
