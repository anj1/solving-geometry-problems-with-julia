module ExactAreas

export ExactArea, area

"An area in Q + Qπ + Qatan(1/2), stored without numerical approximation."
struct ExactArea
    rational::Rational{BigInt}
    pi::Rational{BigInt}
    atanhalf::Rational{BigInt}
end

rat(x::Integer) = BigInt(x) // BigInt(1)
rat(x::Rational) = BigInt(numerator(x)) // BigInt(denominator(x))

area(; rational=0, pi=0, atanhalf=0) =
    ExactArea(rat(rational), rat(pi), rat(atanhalf))

Base.:+(a::ExactArea, b::ExactArea) =
    ExactArea(a.rational + b.rational, a.pi + b.pi, a.atanhalf + b.atanhalf)

Base.:-(a::ExactArea, b::ExactArea) =
    ExactArea(a.rational - b.rational, a.pi - b.pi, a.atanhalf - b.atanhalf)

Base.:*(k::Integer, a::ExactArea) = rat(k) * a
Base.:*(k::Rational, a::ExactArea) =
    ExactArea(k * a.rational, k * a.pi, k * a.atanhalf)
Base.:*(a::ExactArea, k::Union{Integer,Rational}) = k * a

Base.:(==)(a::ExactArea, b::ExactArea) =
    a.rational == b.rational && a.pi == b.pi && a.atanhalf == b.atanhalf

end
