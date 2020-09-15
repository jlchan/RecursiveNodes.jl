# for 1D,2D,3D: Xhat = d-tuple on biunit triangle
function ref_to_bary(Xhat::NTuple{N,T}) where {N,T}
    X = (x->@. (1+x)/2).(Xhat) # convert to 0,1
    return (X..., 1 .- sum(X))
end

ref_to_bary(Xhat) = ref_to_bary((Xhat,)) # specialize for single argument

pop(α,i) = (α[1:i-1]...,α[i+1:end]...) # pop out ith entry
pad(α,i) = (α[1:i-1]...,zero(eltype(α)),α[i:end]...) # pad by 0

"
function recursive_nodes(α,node_family):
Note α is a barycentric coordinate here, not a multi-index.
"
function recursive_nodes(α,node_family)
    d = length(α)-1
    xn = node_family[sum(α)+1]
    if d==1
        b = xn[α[1]+1],xn[α[2]+1]
        return b
    else
        b = zeros(eltype(xn),d+1)
        weight = zero(eltype(xn))
        for i = 1:d+1
            #@show recursive_nodes(pop(α,i),node_family)
            br = pad(recursive_nodes(pop(α,i),node_family),i)
            x_i = xn[sum(pop(α,i))+1]
            @. b += x_i*br
            weight += x_i
        end
        return Tuple(b./weight) # can I get rid of this conversion?
    end
end
