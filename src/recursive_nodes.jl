

pop(α,i) = [α[1:i-1]...,α[i+1:end]...] # pop out ith entry
pad(α,i) = [α[1:i-1]...,zero(eltype(α)),α[i:end]...] # pad by 0

"
function recursive_nodes(α,node_family):
Note α is a barycentric coordinate here, not a multi-index.
"
function recursive_nodes(α,node_family)
    d = length(α)-1
    xn = node_family[sum(α)+1]
    if d==1
        b = [xn[α[1]+1],xn[α[2]+1]]
        return b
    else
        b = zeros(eltype(xn),d+1)
        weight = zero(eltype(xn))
        for i = 1:d+1
            br = pad(recursive_nodes(pop(α,i),node_family),i)
            x_i = xn[sum(pop(α,i))+1]
            @. b += x_i*br
            weight += x_i
        end
        return b./weight
    end
end

# recursive_nodes(d::Int,N::Int,node_family) =
#     recursive_nodes(MultiIndexSet(d,N),node_family)
#
# function recursive_nodes(set::MultiIndexSet,node_family)
#     X = ntuple(x->zeros(length(Ndset)),d)
#     for (index,α) in enumerate(Ndset)
#         b = recursive_nodes((α...,N-sum(α)),node_family)
#         for i = 1:d
#             X[i][index] = sum(b.*VXYZ[i])
#         end
#     end
#     return X
# end
