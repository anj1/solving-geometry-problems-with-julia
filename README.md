## Exact geometry and algebra demos with AlgebraicNumbers.jl

Instantiate once, then run any demo with Julia's project flag:

```sh
~/julia-1.12.6/bin/julia --project=. -e 'using Pkg; Pkg.instantiate()'
~/julia-1.12.6/bin/julia --project=. morley.jl
```

`exact_geometry.jl` supplies one exact `Line`, `Circle`, intersection, and
line-circle intersection implementation for the geometry scripts. The main
new demonstrations are:

- `viral_china_homework.jl`: the Chinese sixth-grade tangent-circle area
  problem, including the exact diagonal--circle intersection used by its viral
  variation.
- `morley.jl`: a scalene rational-angle triangle whose three adjacent
  trisectors form an equilateral Morley triangle by exact equality.
- `constructibility.jl`: degrees and minimal polynomials for the 17-gon,
  7-gon, and angle trisection.
- `exact_dft.jl`: a 7-point DFT with exact root-of-unity cancellation and
  orthogonality.
