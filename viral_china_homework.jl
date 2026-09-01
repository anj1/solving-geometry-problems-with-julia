# Presh Talwakar's problem
# https://www.youtube.com/watch?v=xnE_sO7PbBs

# The key 'insight' is that we need to find the position of the position
# where the line intersects the top right of the right circle.
# Let's call this point A.
# We can do this with algebraic numbers.

# Define a Line as given by an equation ax + by + c == 0
struct Line
    a 
    b 
    c
end 

struct Circle
    cx::AlgebraicNumber
    cy::AlgebraicNumber
    rad::AlgebraicNumber
end 

# Constructs a line from a starting point and angle.
function line_from_angle(point, ang)
    a = sin_alg(ang)/cos_alg(ang)
    b = AlgebraicNumber(-1)
    c = point[2] - a*point[1]
    return Line(a,b,c)
end

# Well known formula
function intersect_line_circle(line, circle::Circle)
    a = line.a^2 + line.b^2
    b = 2*line.a*line.c + 2*line.a*line.b*circle.cy - 2*(line.b^2)*circle.cx 
    c = line.c^2 + 2*line.b*line.c*circle.cy - (line.b^2)*(circle.r^2 - circle.cx^2 - circle.cy^2)

    delta = b^2 - 4*a*c

    x1 = (-b-sqrt(delta))/(2*a)
    
end