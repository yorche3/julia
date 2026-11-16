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

get_value(node::TreeNode)::Int = 0
get_left(node::TreeNode)::Union{Nothing, TreeNode} = nothing
get_right(node::TreeNode)::Union{Nothing, TreeNode} = nothing
set_left!(node::TreeNode, left::Union{Nothing, TreeNode})::Union{Nothing, TreeNode} = nothing
set_right!(node::TreeNode, right::Union{Nothing, TreeNode})::Union{Nothing, TreeNode} = nothing

mutable struct BinaryTree
    root::Union{Nothing, TreeNode}
    count::Int

    BinaryTree() = new(nothing, 0)
end

insert!(tree::BinaryTree, value::Int)::Bool = false
contains(tree::BinaryTree, value::Int)::Bool = false
isempty(tree::BinaryTree)::Bool = false
length(tree::BinaryTree)::Int = 0

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

add_vertex!(graph::Graph, label::Int)::Bool = false
add_edge!(graph::Graph, u::Int, v::Int)::Bool = false
has_edge(graph::Graph, u::Int, v::Int)::Bool = false
get_neighbors(graph::Graph, u::Int)::Union{Nothing, Vector{Int}} = nothing
isempty(graph::Graph)::Bool = false
vertex_count(graph::Graph)::Int = 0
edge_count(graph::Graph)::Int = 0

end # module data_structures_advanced
