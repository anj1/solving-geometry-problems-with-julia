# Presh Talwakar's problem
# https://www.youtube.com/watch?v=CFhFx4n3aH8

using AlgebraicNumbers
include("exact_geometry.jl")
using .ExactGeometry

# Construct the three triangle points.
# Because the base of the triangle AB is arbitrary, we choose a length of 1.
# And let A be at the origin.
# So:

point_A = AlgebraicNumber[0,  0]
point_B = AlgebraicNumber[0, -1]


# Construct the line AE.
# Remember: the angle is relative to a global coordinate system,
# so it's actually 270 + 70, or -20 degrees.
line_AE = line_from_angle(point_A, -20//180)

# Construct the line AC.
# Again, the angle is 270 + 70 + 10 or -10 degrees.
line_AC = line_from_angle(point_A, -10//180)

# Construct the line BD.
# The angle is (90-80)+20 = 30 degrees
line_BD = line_from_angle(point_B, 30//180)

# Construct the line BC
line_BC = line_from_angle(point_B, 10//180)

# intersect AC and BD to get point D 
point_D = ExactGeometry.intersect(line_AC, line_BD)

# intersect AE and BC to get point E 
point_E = ExactGeometry.intersect(line_AE, line_BC)

# Get vectors EA and ED
vec_ED  = point_D .- point_E
vec_EA  = point_A .- point_E

# get their lengths 
len_ED = sqrt(sum(vec_ED .* vec_ED))
len_EA = sqrt(sum(vec_EA .* vec_EA))

# project D on to line AE, to get distance D' = len_ED*len_EA*cos(E) 
len_EDp = sum(vec_ED .* vec_EA)

# now just divide through to get the cos(angle)
cos_DEA =  len_EDp/(len_ED*len_EA)

# Calculating the inverse cosine 'roughly' gives pi/9 = 20 deg.
println(acos_alg(cos_DEA))
