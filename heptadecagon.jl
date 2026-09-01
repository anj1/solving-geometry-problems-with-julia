using AlgebraicNumbers

# See https://en.wikipedia.org/wiki/Trigonometric_number#Denominator_of_17
s17 = sqrt(AlgebraicNumber(17))
t1 = s17 - 1
t2 = sqrt(34 - 2*s17)
t3 = 17 + 3*s17
t4 = sqrt(170 + 38*s17)

t12 = t1 + t2 
t34 = 2*sqrt(t3 - t4)

x = (t12+t34)/16

# This will print 2//17
println(acos_alg(x))