# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A collection of Pluto.jl reactive notebooks exploring number theory — specifically the relationship between pi, prime numbers, and Gaussian integers, inspired by 3Blue1Brown's "Pi hiding in prime regularities" video.

## Notebooks

- **pi_hiding_in_prime_regularities.jl** — The main notebook. Implements lattice point counting, Gaussian integer factorization, the Dirichlet chi function (Χ), and derives pi via an alternating infinite sum. Uses CairoMakie for plotting, Primes.jl, DataFrames, and DataStructures.
- **pi.jl** — Earlier version of the same exploration using PyPlot instead of CairoMakie.
- **My cool notebook.jl** — Tower of Hanoi puzzle (Pluto tutorial notebook).

## Running Notebooks

```bash
julia -e 'using Pluto; Pluto.run()'
```
Then open the desired `.jl` file from the Pluto interface. Pluto's built-in package manager handles dependencies automatically.

## CI/CD

GitHub Actions workflow (`.github/workflows/ExportPluto.yaml`) exports all notebooks to static HTML and deploys to GitHub Pages via the `gh-pages` branch. Uses Julia 1.8 and PlutoSliderServer.

## Key Julia Dependencies

Primes, DataFrames, DataStructures, StatsBase, CairoMakie, LaTeXStrings, CSV, PlutoUI, PlutoTeachingTools, HypertextLiteral

## Notebook Format Notes

Pluto notebooks are valid `.jl` files with special cell delimiter comments (`# ╔═╡`). Cell order is declared at the bottom of the file. When editing, preserve these delimiters and the cell order section. Pluto enforces one expression per cell and reactive dependencies between cells.
