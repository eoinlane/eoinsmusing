# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A Pluto.jl reactive notebook exploring number theory — specifically the relationship between pi, prime numbers, and Gaussian integers, inspired by 3Blue1Brown's "Pi hiding in prime regularities" video.

## Notebooks

- **pi_hiding_in_prime_regularities.jl** — The main notebook. Implements lattice point counting, Gaussian integer factorization, the Dirichlet chi function (Χ), and derives pi via an alternating infinite sum. Uses CairoMakie for plotting, Primes.jl, DataFrames, and DataStructures. Has an interactive radius slider via PlutoUI.
- **My cool notebook.jl** — Tower of Hanoi puzzle (Pluto tutorial notebook).

## Running Notebooks

```bash
julia -e 'using Pluto; Pluto.run()'
```
Then open the desired `.jl` file from the Pluto interface. Pluto's built-in package manager handles dependencies automatically. Requires Julia 1.12+.

## CI/CD

GitHub Actions workflow (`.github/workflows/ExportPluto.yaml`) exports all notebooks to static HTML and deploys to GitHub Pages via the `gh-pages` branch. Uses Julia 1.12 and PlutoSliderServer. Site lives at https://eoinlane.github.io/eoinsmusing/.

## Key Julia Dependencies

Primes, DataFrames, DataStructures, StatsBase, CairoMakie, LaTeXStrings, CSV, PlutoUI, PlutoTeachingTools, HypertextLiteral

## Notebook Format Notes

Pluto notebooks are valid `.jl` files with special cell delimiter comments (`# ╔═╡`). Cell order is declared at the bottom of the file. When editing, preserve these delimiters and the cell order section. Pluto enforces one expression per cell and reactive dependencies between cells.

## Testing Notebooks

To export and verify a notebook runs without errors:
```bash
julia -e 'using Pkg; Pkg.activate(mktempdir()); Pkg.add("PlutoSliderServer"); import PlutoSliderServer; PlutoSliderServer.export_notebook("pi_hiding_in_prime_regularities.jl")'
```
For faster test iterations, reduce the radius slider default or use a smaller range.

## Julia Version Management

Julia is managed via juliaup. To check/update:
```bash
juliaup status
juliaup update
```
