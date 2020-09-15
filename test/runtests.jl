using RecursiveNodes
using Test

@testset "RecursiveNodes.jl" begin
    target = ((0, 0, 0),(1, 0, 0), (0, 1, 0), (0, 0, 1))
    @test all(target .== collect(MultiIndexSet(3,1)))


end



# node_family = [[.5]]
# for N = 1:25
#     #push!(node_family,collect(LinRange(.1,.9,N+1)))
#     r = gauss_lobatto_quad(0,0,N)[1]
#     push!(node_family,@. (1+r)/2) # convert to [0,1]
# end
#
# d,N = 3,25
# Ndset = MultiIndexSet(d,N)
# # VXYZ = ((-1,1,-1),(-1,-1,1))
# VXYZ = ((-1,1,-1,-1),(-1,-1,1,-1),(-1,-1,-1,1))
# # VXYZ = ((-1,1,0),(0,0,sqrt(3)))
# X = ntuple(x->zeros(length(Ndset)),d)
# for (index,α) in enumerate(Ndset)
#     b = recursive_nodes((α...,N-sum(α)),node_family)
#     for i = 1:d
#         X[i][index] = sum(b.*VXYZ[i])
#     end
# end
#
# scatter(X...,ms=2,cam=(60,30),legend=false)
# # plot!([[VXYZ[i]...,first(VXYZ[i])] for i = 1:d]...)
