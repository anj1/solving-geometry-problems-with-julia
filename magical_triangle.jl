# Presh Talwakar's problem
# https://www.youtube.com/watch?v=o1qiKJfe_3w


using AlgebraicNumbers

# Define a Line as given by an equation ax + by + c == 0
struct Line
    a 
    b 
    c
end 

# Constructs a line from a starting point and angle.
function line_from_angle(point, ang)
    a = sin_alg(ang)/cos_alg(ang)
    b = AlgebraicNumber(-1)
    c = point[2] - a*point[1]
    return Line(a,b,c)
end

# This function finds the intersection between two lines
# It's just the classical formula which you can find in any textbook.
function intersect(l1::Line, l2::Line)
    denom = l1.a*l2.b - l2.a*l1.b
    x = (l1.b*l2.c - l2.b*l1.c)/denom
    y = (l1.c*l2.a - l2.c*l1.a)/denom
    return [x, y]
end

point_A = AlgebraicNumber[0,  0]
point_B = AlgebraicNumber[1,  0]
point_D = AlgebraicNumber[0, -1]

angle_BAF = 1 - (70//180 + 90//180)

# Get point F 
line_AF = line_from_angle(point_A, -angle_BAF)
line_BC = Line(AlgebraicNumber(1), AlgebraicNumber(0), -point_B[1])
point_F = intersect(line_AF, line_BC)

# Get point E 
angle_FAE = 1//4
line_AE = line_from_angle(point_A, -angle_BAF-angle_FAE)
line_DC = line_from_angle(point_D, 0//1)
point_E = intersect(line_AE, line_DC)

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