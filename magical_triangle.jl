# Presh Talwakar's problem
# https://www.youtube.com/watch?v=o1qiKJfe_3w


using AlgebraicNumbers
include("exact_geometry.jl")
using .ExactGeometry

point_A = AlgebraicNumber[0,  0]
point_B = AlgebraicNumber[1,  0]
point_D = AlgebraicNumber[0, -1]

angle_BAF = 1 - (70//180 + 90//180)

# Get point F 
line_AF = line_from_angle(point_A, -angle_BAF)
line_BC = Line(AlgebraicNumber(1), AlgebraicNumber(0), -point_B[1])
point_F = ExactGeometry.intersect(line_AF, line_BC)

# Get point E 
angle_FAE = 1//4
line_AE = line_from_angle(point_A, -angle_BAF-angle_FAE)
line_DC = line_from_angle(point_D, 0//1)
point_E = ExactGeometry.intersect(line_AE, line_DC)

# Get vectors EA and EF
vec_EA  = point_A .- point_E
vec_EF  = point_F .- point_E

# get their lengths 
len_EA = sqrt(sum(vec_EA .* vec_EA))
len_EF = sqrt(sum(vec_EF .* vec_EF))

# project A on to line FE, to get distance D' = len_EA*len_EF*cos(E) 
len_EAp = sum(vec_EA .* vec_EF)

# now just divide through to get the cos(angle)
cos_AEF =  len_EAp/(len_EA*len_EF)

# Calculating the inverse cosine
# Should print 13//36
println(acos_alg(cos_AEF))
