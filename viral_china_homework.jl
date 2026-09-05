# Presh Talwakar's Chinese sixth-grade geometry problem
# https://www.youtube.com/watch?v=xnE_sO7PbBs
# https://mindyourdecisions.com/blog/2016/08/07/can-you-solve-this-geometry-problem-for-6th-graders-in-china/

using AlgebraicNumbers
include("exact_geometry.jl")
using .ExactGeometry

# The assigned problem has a 20-by-10 rectangle, its diagonal, and two tangent
# circles.  Each circle has radius 5.  The diagonal splits the rectangle into
# equal triangles, while a 180-degree rotation about the rectangle's centre
# pairs the two circular pieces removed from the red region into one full disk.
width, height, radius = 20, 10, 5
triangle_area = width * height // 2
disk_area_coefficient = radius^2
@assert triangle_area == 100
@assert disk_area_coefficient == 25
println("Assigned problem: red area = 100 - 25π")

# The social-media misprint adds the lower-left cutout.  This is the exact
# construction that the old file had begun: find the top-right intersection A
# of the diagonal and the right circle.  It is (18, 1), with no tolerance.
top_left = AlgebraicNumber[0, height]
bottom_right = AlgebraicNumber[width, 0]
diagonal = line_from_points(top_left, bottom_right)
right_circle = Circle(AlgebraicNumber[15, 5], AlgebraicNumber(radius))
intersections = intersect_line_circle(diagonal, right_circle)
@assert any(p -> p[1] == 18 && p[2] == 1, intersections)
@assert any(p -> p[1] == 10 && p[2] == 5, intersections)

# For the harder viral variation, the additional lower-left piece is
# 10 - 25π/4 + 25atan(1/2); hence its red area is:
println("Viral-variation red area = 90 - 75π/4 - 25atan(1/2)")
