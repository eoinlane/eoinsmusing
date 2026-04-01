# Pi Hiding in Prime Regularities

A [Pluto.jl](https://github.com/fonsp/Pluto.jl) reactive notebook exploring the surprising connection between prime numbers and pi, inspired by [3Blue1Brown's video](https://www.youtube.com/watch?v=NaL_Cb42WyY).

## What's in the notebook

The notebook builds up to deriving pi from the way primes distribute among residues mod 4:

1. **Lattice point counting** — how many integer-coordinate points lie on a circle of radius sqrt(N)?
2. **Gaussian integer factorization** — factoring primes in the complex integers reveals the structure behind lattice points
3. **The Dirichlet character Chi** — classifies primes by their behaviour mod 4 (split, inert, or ramified)
4. **The Leibniz formula** — the lattice point counts sum to pi*R, giving pi/4 = 1 - 1/3 + 1/5 - 1/7 + ...

The notebook includes an interactive slider to explore how the approximation converges to pi.

## View online

The notebook is exported to HTML and published via GitHub Pages:

**[eoinlane.github.io/eoinsmusing](https://eoinlane.github.io/eoinsmusing/)**

## Run locally

```bash
julia -e 'using Pluto; Pluto.run()'
```

Then open `pi_hiding_in_prime_regularities.jl` from the Pluto interface. Dependencies are managed automatically by Pluto's built-in package manager.

Requires Julia 1.12+.

## Also included

- **My cool notebook.jl** — Tower of Hanoi puzzle (Pluto tutorial)
