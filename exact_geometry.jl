module ExactGeometry

using AlgebraicNumbers

export Point, Line, Circle, line_from_angle, line_from_points, intersect,
       intersect_line_circle, squared_distance

const Point = Vector{AlgebraicNumber}

"An exact line `a*x + b*y + c = 0`."
struct Line
    a::AlgebraicNumber
    b::AlgebraicNumber
    c::AlgebraicNumber
end

struct Circle
    center::Point
    radius::AlgebraicNumber
end

"The line through `point`, at `angle * pi` from the positive x-axis."
function line_from_angle(point::AbstractVector{<:AlgebraicNumber}, angle::Rational)
    a = -sin_alg(angle)
    b = cos_alg(angle)
    Line(a, b, -a * point[1] - b * point[2])
end

"The line through two distinct exact points; vertical lines need no special case."
function line_from_points(p::AbstractVector{<:AlgebraicNumber}, q::AbstractVector{<:AlgebraicNumber})
    a = p[2] - q[2]
    b = q[1] - p[1]
    Line(a, b, -a * p[1] - b * p[2])
end

"Intersection of two non-parallel lines."
function intersect(l1::Line, l2::Line)
    determinant = l1.a * l2.b - l2.a * l1.b
    determinant == 0 && throw(ArgumentError("parallel lines do not intersect"))
    Point([(l1.b * l2.c - l2.b * l1.c) / determinant,
           (l1.c * l2.a - l2.c * l1.a) / determinant])
end

"The two exact intersections of a line and circle (equal for tangency)."
function intersect_line_circle(line::Line, circle::Circle)
    norm2 = line.a^2 + line.b^2
    # Orthogonally project the *circle centre* onto the line.
    signed_distance_numerator = line.a * circle.center[1] + line.b * circle.center[2] + line.c
    foot = Point([circle.center[1] - signed_distance_numerator * line.a / norm2,
                  circle.center[2] - signed_distance_numerator * line.b / norm2])
    offset2 = circle.radius^2 - squared_distance(foot, circle.center)
    real(offset2.apprx) < 0 && throw(ArgumentError("line does not meet circle"))
    t = sqrt(offset2 / norm2)
    direction = Point([-line.b, line.a])
    (foot .+ t .* direction, foot .- t .* direction)
end

squared_distance(p::AbstractVector{<:AlgebraicNumber}, q::AbstractVector{<:AlgebraicNumber}) = sum((p .- q) .^ 2)

end
