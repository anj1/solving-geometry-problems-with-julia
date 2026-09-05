# Presh Talwakar's Chinese sixth-grade geometry problem
# https://www.youtube.com/watch?v=xnE_sO7PbBs
# https://mindyourdecisions.com/blog/2016/08/07/can-you-solve-this-geometry-problem-for-6th-graders-in-china/

using AlgebraicNumbers
include("exact_geometry.jl")
include("exact_area.jl")
using .ExactGeometry
using .ExactAreas

# The assigned problem has a 20-by-10 rectangle, its diagonal, and two tangent
# circles.  Each circle has radius 5.  The diagonal splits the rectangle into
# equal triangles, while a 180-degree rotation about the rectangle's centre
# pairs the two circular pieces removed from the red region into one full disk.
width, height, radius = 20, 10, 5
triangle_area = width * height // 2
@assert triangle_area == 100
assigned_area = area(rational=triangle_area, pi=-radius^2)
@assert assigned_area == area(rational=100, pi=-25)
println("Assigned problem: red area = 100 - 25π")

# The social-media misprint adds the lower-left cutout.  Its diagonal is the
# anti-diagonal (0,10)--(20,0), not the diagonal (0,0)--(20,10).
top_left = AlgebraicNumber[0, height]
bottom_right = AlgebraicNumber[width, 0]
diagonal = line_from_points(top_left, bottom_right)
right_circle = Circle(AlgebraicNumber[width - radius, height // 2], AlgebraicNumber(radius))
intersections = intersect_line_circle(diagonal, right_circle)

P = only(p for p in intersections if p[1] == 10 && p[2] == 5)
A = only(p for p in intersections if p[1] == 18 && p[2] == 1)

# P is the tangency point of the two circles. The central angle α from CP to
# CA has algebraic sine and cosine, but is not a rational multiple of π.
C = right_circle.center
u = P .- C
v = A .- C
dotuv = sum(u .* v)
crossuv = u[1] * v[2] - u[2] * v[1]
r2 = right_circle.radius^2

cosα = dotuv / r2
sinα = abs(crossuv) / r2
@assert cosα == -3//5
@assert sinα == 4//5
# AlgebraicNumbers currently signals this failure with `Nothing` (the type),
# rather than the `nothing` value.  In either spelling, no rational multiple
# of π is available for this angle.
@assert acos_alg(cosα) === Nothing

# Nevertheless, tan(α/2) = 2, hence α = 2atan(2) = π - 2atan(1/2).
# No floating-point angle is used below.
tan_half_α = sinα / (1 + cosα)
@assert tan_half_α == 2
isosceles_area = abs(crossuv) / 2
@assert isosceles_area == 10

# Every area in this construction belongs to Q + Qπ + Qatan(1/2).
πexpr = area(pi=1)
θexpr = area(atanhalf=1)       # θ = atan(1/2)
αexpr = πexpr - 2 * θexpr

# Circular segment = sector - isosceles triangle.
sector = (radius^2 // 2) * αexpr
segment = sector - area(rational=10)

# The easy lower-right piece in the 10-by-10 auxiliary square, followed by
# the 10-by-5 setup triangle, gives the lower-left cutout.
quarter_gap = area(rational=radius^2) - (radius^2 // 4) * πexpr
setup_triangle = area(rational=(width ÷ 2) * radius // 2)
lower_left_piece = setup_triangle - quarter_gap - segment
@assert lower_left_piece == area(rational=10, pi=-25//4, atanhalf=25)

viral_area = assigned_area - lower_left_piece
@assert viral_area == area(rational=90, pi=-75//4, atanhalf=-25)
println("Viral-variation red area = 90 - 75π/4 - 25atan(1/2)")
