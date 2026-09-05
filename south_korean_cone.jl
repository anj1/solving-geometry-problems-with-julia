# Presh Talwakar's problem
# https://www.youtube.com/watch?v=Y6caQ_8_frU&t=138s

# The key 'insight' is that we can unwrap a cone to a plane,
# forming a section of a disk,
# While still preserving all distances.

using AlgebraicNumbers
include("exact_geometry.jl")
using .ExactGeometry

# The radius of this disk is just the side of the cone 
disk_rad = 60

# The outer perimeter of this disk is just the perimeter of the base of the cone.
# Here we calculate this up to the factor of pi.
disk_perim = 2*20

# Now here is the critical bit: find the total angle of the disk section,
# Again as a fraction of pi.
disk_θ = disk_perim//disk_rad

# distance of point B from O 
dist_OB = 50

point_O = AlgebraicNumber[0, 0]
point_B = AlgebraicNumber[dist_OB, 0]

point_A = disk_rad*[cos_alg(disk_θ), sin_alg(disk_θ)]


# find angle of line AB in global ref frame 
line_AB = line_from_points(point_A, point_B)
line_OP = Line(-1/line_AB.a, AlgebraicNumber(-1), AlgebraicNumber(0))

point_P = ExactGeometry.intersect(line_AB, line_OP)

d = point_P .- point_B 
dist_PB = sqrt(sum(d.^2))

# The result is 400/sqrt(91)
# or 91x^2 - 160000 = 0
println(dist_PB)
println(dist_PB.coeff)
