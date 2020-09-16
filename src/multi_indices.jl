"iterator type over simplicial multi-indices"
struct MultiIndexSet
    d::Int # dimension
    N::Int # degree
end

Base.length(a::MultiIndexSet) = prod(ntuple(i->(a.N+i),a.d)) ÷ factorial(a.d)

function Base.iterate(set::MultiIndexSet)
    α = ntuple(x->zero(Int),set.d)
    return α,α
end
function Base.iterate(set::MultiIndexSet,α::NTuple)
    if last(α) == set.N
        return nothing
    else
        αnext = increment(α,set,1)
        return αnext,αnext
    end
end

"function increment(I::NTuple,set::MultiIndexSet,i::Int):
    increments a multi-index of arbitrary dimension and degree.
    Intended to be used within the interface for Base.iterate"
function increment(I::NTuple,set::MultiIndexSet,i::Int)
    if length(I) != set.d
        error(DimensionMismatch("Length of I = $(length(I)) while set.d = $(set.d)"))
    end
    if last(I)==set.N
        return (I[1:end-1]...,last(I)+1) # set "incorrect" state to end iteration
    end
    if sum(I) < set.N
        return (I[1:i-1]...,I[i]+1,I[i+1:end]...)
    else
        Inext = (zero.(I[1:i])...,I[i+1:end]...)
        increment(Inext,set,i+1) # recursive
    end
end
