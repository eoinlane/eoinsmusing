### A Pluto.jl notebook ###
# v0.20.24

using Markdown
using InteractiveUtils

# ╔═╡ eae0d1c0-8b19-43e4-97f8-21f89708018e
begin
	using PlutoUI, PlutoTeachingTools, HypertextLiteral
	
	# PlutoTeachingTools looks up language based on ENV["LANG"]
	# Uncomment a line below to override default language
	#set_language!(PlutoTeachingTools.EnglishUS())      # default
	#set_language!(PlutoTeachingTools.GermanGermany())  
end

# ╔═╡ fe677804-cf1f-4413-abe4-684943d68d5f
using CairoMakie, Makie.GeometryBasics, LaTeXStrings

# ╔═╡ 08a9d538-1eba-11ed-1ac4-c1b15c5bb280
using DataFrames, StatsBase,  DataStructures ,Primes

# ╔═╡ a28594c7-c134-4548-9ac1-1049bbe14f4b
using CSV

# ╔═╡ 4bb7d51f-ef33-4228-a39f-0f39a709899a
TableOfContents()   # from PlutoUI

# ╔═╡ 4e5fccf3-d7d3-4e7f-be3f-4eb24f5a4239
@htl("""
<article class="learning">
	<h4>
		Pi hiding in prime regularities
	</h4>
	<p>
		The story here is to tie together &pi;, prime numbers, complex numbers and pi and come up with a formula for &pi; using an alternating infinite sum. When you see &pi; see up in math, there’s a circle hiding somewhere, sometimes very sneakily. So the goal here is to discover alternating infinite sum, and find the circle hiding behind it.
	</p>
	<p>
		An outline for the approach is as follows:
	</p>
<p>
<ol>
<li>Count lattice points </li>
<li>Things like 17 = 4<sup>2</sup> + 1<sup>2</sup> </li>
<li>Things like 17 = (4 + <i>i</i>)(4 - <i>i</i>)  </li>
<li>Introduce  	&#967; </li>
</ol>
</p>
</article>


<style>

	article.learning {
		background: #f996a84f;
		padding: 1em;
		border-radius: 5px;
	}

	article.learning h4::before {
		content: "☝️";
	}

	article.learning p::first-letter {
		font-size: 1.5em;
		font-family: cursive;
	}

</style>
""")

# ╔═╡ ca796498-1218-4109-b90f-5038ab76c629
tip(md" A “lattice point” is a point (a, b) in the plane where a and b are both integers, a point where grid lines cross. .")

# ╔═╡ 4c72470d-729d-480d-ac59-f65f195ec4ce
md"""

$\frac{π}{4}= \frac{1}{1}+ \frac{0}{2}+\frac{-1}{3}+\frac{0}{4}+\frac{1}{5}+\ldots$

"""

# ╔═╡ 08df6171-cc09-4239-b458-2a8ba87d69ca
aside(tip(md"This notebook is built with [Pluto Markdown](https://www.juliafordatascience.com/first-steps-5-pluto/) using $\LaTeX$") )

# ╔═╡ 73b1b527-d820-4531-92a1-73df0a492b0b
md"""
## Introduction
"""

# ╔═╡ ceb4fa2c-3981-466d-b0f8-0468bb264c68
md"""
It looks to build the math around this video on [Pi hiding in prime regularities](https://www.youtube.com/watch?v=NaL_Cb42WyY&t=209s)

*Primitive* Pythagorean Triples (or **PPT** for short)[^1]

A *primitive* Pythagorean triple is as follows

$a^2 + b^2 = c^2$

"""

# ╔═╡ 5b5ff634-c6bf-4fe9-b442-8e9821156e75
md"""

In additive number theory, Fermat's theorem on sums of two squares states that an odd prime p can be expressed as


${\displaystyle p=x^{2}+y^{2},}$
with x and y integers, if and only if

$p \equiv 1 \pmod{4}.$
The prime numbers for which this is true are called *Pythagorean primes*. For example, the primes $5, 13, 17, 29, 37$ and $41$ are all congruent to 1 modulo 4, and they can be expressed as sums of two squares in the following ways:

$5 = 1^2 + 2^2, \quad 13 = 2^2 + 3^2, \quad 17 = 1^2 + 4^2, \quad 29 = 2^2 + 5^2, \quad 37 = 1^2 + 6^2, \quad 41 = 4^2 + 5^2.$

On the other hand, the primes $3, 7, 11, 19, 23$ and $31$ are all congruent to 3 modulo 4, and none of them can be expressed as the sum of two squares. This is the easier part of the theorem and follows immediately from the observation that all squares are congruent to 0 or 1 modulo 4.

See here: 
- https://www.wikiwand.com/en/Proofs_of_Fermat%27s_theorem_on_sums_of_two_squares
- https://www.had2know.org/academics/gaussian-prime-factorization-calculator.html
- https://stackoverflow.com/questions/2269810/whats-a-nice-method-to-factor-gaussian-integers
- https://en.wikipedia.org/wiki/Table_of_Gaussian_integer_factorizations

"""

# ╔═╡ f89f32a4-2d1d-4905-90d9-6746576bf432
# https://docs.makie.org/stable/tutorials/basic-tutorial/
begin
	f = Figure()
	ax = Axis(f[1, 1], 
    	title = "A Makie Axis",
    	xlabel = "The x label",
    	ylabel = "The y label"
	)
#x = range(0, 10, length=100)
#y = sin.(x)
	r = 5
	Θ = LinRange(0,2*π, 500)
	x = r*sin.(Θ)
	y = r*cos.(Θ)
	# https://discourse.julialang.org/t/how-to-add-grid-lines-on-top-of-a-heatmap-in-makie/77578
	f, ax, l1 = lines(x, y, linewidth = .5, color = :red, label = "cicle";
		figure = (; resolution = (500, 500)),	
		axis = (; title = L"Lattice points on a circle of radius $\sqrt{25}$", xlabel = L"\Re(z)", ylabel = L"\Im(z)", aspect = DataAspect(), xgridcolor = :black, ygridcolor = :black, xgridwidth = 0.5, ygridwidth = 0.5, xminorgridcolor = :grey,
    	yminorgridcolor = :grey,
		xminorgridvisible = true,
		yminorgridvisible = true,
		xminorticks = IntervalsBetween(3),
		yminorticks = IntervalsBetween(3),
		#https://github.com/MakieOrg/Makie.jl/issues/158
		backgroundcolor = :transparent,
        leftspinevisible = false,
        rightspinevisible = false,
        bottomspinevisible = false,
        topspinevisible = false,
		)
	)
	scatter!(ax, 4, 3, color = :yellow, label = "point")
	scatter!(ax, 3, 4, color = :yellow)
	scatter!(ax, -3, 4, color = :yellow)
	scatter!(ax, -4, 3, color = :yellow)
	scatter!(ax, -3, -4, color = :yellow)
	scatter!(ax, -4, -3, color = :yellow)
	scatter!(ax, 3, -4, color = :yellow)
	scatter!(ax, 4, -3, color = :yellow)
	#\textcolor{blue}
	text!(L"(-3+4i)", position=(-3,4))
	text!(L"\sqrt{25}", position=(2,0))
	axislegend()
	xs = [Point2f(0,0)]
	ys = [Point2f(5,0)]
	arrows!(ax, xs, ys, linewidth = 2, arrowsize = 15, color = :red)
	#tightlimits!(ax)
f
end

# ╔═╡ ea560410-5c83-4fe2-afd5-03d09af0685d
begin
	"""
    primeFactors(number, list = Int[] )

Compute the prime factor of a number.  See here for implementation  http://juliamath.github.io/Primes.jl/v0.3/api.html#Prime-factorization-1

# Examples
```julia-repl
julia> primeFactors(10)
[2, 5]
```
"""
	function primeFactors(x)
	x = Primes.factor(Vector, x)
	end
end

# ╔═╡ 7463bf07-e164-4580-9a0f-581625994762
md"""
## Dataframe with a range of radius $\sqrt{k}$.
"""

# ╔═╡ 542584b1-5cff-4096-9626-bda7c57df38c
radius = 100000

# ╔═╡ 72460280-bbfa-492d-8270-e44293266e09
df_pi = DataFrame(sqrt_radius= 2:radius)

# ╔═╡ bb47b3f0-b4d7-43d8-945f-ee94e9def8f6
begin
	"""
    gcd(z1, z2)

Complex numbers version of greatest common divisor operator. Call this function with a pair of complex number arguments, i.e. `gcd(z1, z2)`. See [here for implementation](https://github.com/JuliaLang/julia/issues/35125#issuecomment-609364575)
# Examples
```julia-repl
julia> gcd((3 + 4im),(4 + 3im))
1 + 0im
```
"""
	function gcd(z1::Complex{T}, z2::Complex{V}) where {T<:Integer,V<:Integer}
	    R = promote_type(T, V)
	    a = Complex{R}(z1)
	    b = Complex{R}(z2)
	    if abs(a) < abs(b)
	        a, b = b, a
	    end
	    while b != 0
	        # TODO: Create rem(::Complex{<:Integer}, ::Complex{<:Integer})
	        # TODO: Create div(::Complex{<:Integer}, ::Complex{<:Integer})
	        b̅ = conj(b)
	        # TODO: Handle overflow when calculating a*b̅
	        t = a * b̅
	        # TODO: Create checked_abs2(::Complex{<:Integer})
	        # TODO: Handle overflow when calculating the norm of complex numbers
	        abs2_b = abs2(b)
	        abs2_b < 0 && __throw_gcd_overflow(z1, z2)
	        r = a - b * complex(div(real(t), abs2_b, RoundNearest),
	            div(imag(t), abs2_b, RoundNearest))
	        a = b
	        b = r
	    end
	    ar, ai = reim(a)
	    if ar == 0
	        complex(abs(ai), zero(ar))
	    elseif ai == 0
	        complex(abs(ar), zero(ai))
	    elseif ar > 0 && ai >= 0   # gcd is already in first quadrant
	        a
	    elseif ar < 0 && ai > 0     # In second quadrant
	        complex(ai, -ar)
	    elseif ar < 0 && ai < 0     # In third quadrant
	        -a
	    else                               # In fourth quadrant
	        complex(-ai, ar)
	    end
	end
end

# ╔═╡ 96c8a707-30be-4154-aaf3-bc48b39cfb85
int(x) = floor(Int, x)

# ╔═╡ af516c3f-6fcf-4db7-a89f-30b1e813863c
begin
	"""
    gaussianPrime(arr)
	
Compute the Gaussian primes from a list of primes. See [here for implementation](https://stackoverflow.com/questions/2269810/whats-a-nice-method-to-factor-gaussian-integers)

# Examples
```julia-repl
julia> gprime(5)
[2+1im, 2-1im]
```
"""
	const _gprime_cache = Dict{Int, Complex}()
	function gprime(arr)
	    x = Complex[]
	    for p in arr
	        if p == 2
	            push!(x, 1 + 1im)
	            push!(x, 1 - 1im)
	        elseif mod(p, 4) == 3 # p = 3 mod 4, q = p.
	            push!(x, p)
	        elseif mod(p, 4) == 1 # p = 1 mod 4
	            if haskey(_gprime_cache, p)
	                push!(x, _gprime_cache[p])
	                push!(x, conj(_gprime_cache[p]))
	            else
	                for k in 2:(p-1)
	                   # https://rosettacode.org/wiki/Modular_exponentiation#Julia2
						y = powermod(k,int((p-1)/2),p)
						if mod(y, p) == mod(-1, p)
	                        #real = BigInt(k)^((p - 1) / 4)
							real = powermod(k,int((p - 1) / 4),p)
	                        factor = gcd(Complex(p), (real) + 1im)
	                        if !in(factor, x)
	                            factor_complex_cong = conj(factor)
	                            push!(x, factor)
	                            push!(x, factor_complex_cong)
	                            _gprime_cache[p] = factor
	                            break
	                        end
	                    end
	                end
	            end
	        end
	    end
	    x
	end
end

# ╔═╡ 83fee348-2ee5-4612-b909-f73a800b9cb6
begin
	"""
    mod_4(x)

For inputs 1 above a multiple of 4, the output is 1. For inputs 3 above a multiple of 4, it outputs 3. 
	
# Examples
```julia-repl
julia>  mod_4(7) = 3
```
""" 
	function mod_4(x)
		if mod1(x,4) == 1
			1
		elseif mod1(x, 4) == 3
			3
		end
	end
end

# ╔═╡ 763c51c1-a1a8-4262-8d40-14799603279a
begin
	"""
    Χ(n)

For inputs 1 above a multiple of 4, the output of Χ is 1. For inputs 3 above a multiple of 4, it outputs -1. And for even numbers, it gives 0. if you evaluate Χ on the natural numbers, it gives this nice cyclic pattern 1, 0, -1, 0, and repeat.
	
# Examples
```julia-repl
julia>  Χ(7) = -1
```
""" 
	function Χ(n)
			if mod_4(n) == 1
				1
			elseif mod_4(n) == 3
				-1
			elseif iseven(n)
				0
			end
	end
end

# ╔═╡ 46b2299a-3c88-4f5f-9f46-3c773c70b189
aside(tip(md"The prime number $2$ is special, because it does factor, as $(1+i)(1-i)$.")) 

# ╔═╡ 7bc5e477-37b0-435e-9224-152bc562ff04
begin
	"""
    computeΧ(array)
	
# Examples
```julia-repl
julia>  Χ(7) = -1
```
""" 
	function computeΧ(array)
		isempty(array) && return 4
		result = 1
		i = 1
		while i <= length(array)
			p = array[i]
			e = 1
			while i + e <= length(array) && array[i + e] == p
				e += 1
			end
			if p == 2
				# Χ(2^i) = 0 for i ≥ 1, so sum is always 1
			elseif mod(p, 4) == 1
				# Χ(p^i) = 1 for all i, so sum = e + 1
				result *= (e + 1)
			else # p ≡ 3 (mod 4)
				# Χ(p^i) alternates 1, -1, ..., sum = 1 if e even, 0 if odd
				isodd(e) && return 0
			end
			i += e
		end
		4 * result
	end
end

# ╔═╡ 2de72be6-3ebd-4282-8ab0-d51bbe727aea


# ╔═╡ 9d7518a1-95a5-42fc-b268-87b100c3e96d
df_pi.isPrime = Primes.isprime.(df_pi.sqrt_radius)

# ╔═╡ c056d31e-6351-4d76-b484-fb8013c20b67
df_pi.mod4 = mod_4.(df_pi.sqrt_radius)

# ╔═╡ 5c522f78-8ac8-4ee8-860e-80f7b7a2023f
md"""
## The goal

The goal here is to count how many lattice points are a given distance away from the origin. Doing this systematically for all distances $\sqrt{N}$ can lead us to a formula for pi. And counting the number of lattice points with a given magnitude, like $\sqrt{25}$, is the same as asking how many Gaussian integers have the property that when you multiply by its complex conjugate, you get 25.
"""


# ╔═╡ 22e0a886-2b99-4453-b1f3-24a889d212e5
md"""
## Unique prime factorization of $\sqrt{radius}$.

Among the ordinary integers, every number can be factored as some unique collection of prime numbers. For example, 2,250 can be factored as 2*32*53, unless you just make some of the primes in this factorization negative.
"""

# ╔═╡ 2c8e6f69-f0b9-43a1-b18e-94a4e5de993d
df_pi.factors = primeFactors.(df_pi.sqrt_radius)

# ╔═╡ bcd7bbc4-90c8-492c-903d-b9559d8a2eb5
df_pi

# ╔═╡ 005b38ac-ef4c-4514-96d3-a14ea64af4a8
md"""
## (Almost) Unique Gaussian prime factorization of $\sqrt{radius}$.

Analogy with primes Factoring works very similarly in Gaussian integers. Some numbers, like 5, can be factored into smaller Gaussian integers, in this case (2+i)(2-i). This Gaussian integer (2+i), cant be factored into anything smaller, so we call it a “Gaussian prime”. This factorization is almost unique. other than the things you can get by multiplying some of these factors by -1, i or -i, factorization within the Gaussian integers is unique.
"""

# ╔═╡ b899d763-5636-4142-b93b-30b578144d01
df_pi.cc = gprime.(df_pi.factors)

# ╔═╡ f6795737-d724-4ee0-9be9-6fb92bb898fc
begin
	"""
    cartesian(complexArray) 

This function organizes the conjugate pairs into two columns, with conjugate pairs sitting right next to each other. Multiply what’s in each column, and you’ll come out with two Gaussian integers. Because everything on the right is a conjugate to everything on the left, what comes out will be a complex conjugate pair.
	
# Examples
```julia-repl
julia>  cartesian(Complex[2+1im, 2-1im]) = Complex[2+1im, 2-1im]
```

```julia-repl
julia>	@testset "Complex Product" begin \\\n @test v2(cc25, 25) == Complex[3+4im, 5+0im, 3-4im] 
    		@test v2(cc125, 125) == Complex[2+11im, 10+5im, 10-5im, 2-11im] \
    		@test v2(cc375, 375) == Complex[] \
    		@test v2(cc1125, 1125) == Complex[6 + 33im, 6 - 33im, 30 + 15im, 30 - 15im] \
    		@test v2(cc10, 10) == [1 + 3im, 3 - 1im,3 + 1im,1 - 3im] \
		 end;
```
""" 
	function cartesian(array)
	    result = Complex[]
	    org = Complex[]
	    con = Complex[]
	
	    # filter by p mod(4) == 1 and count each one
	    # if the count of p is even then split the p equality into org, and con
	    # if it is odd result zero complex numbers and the columns will be unbalanced
	    filtered_array = filter(y -> mod_4(real(y)) == 3 && imag(y) ==0, array)
		# https://discourse.julialang.org/t/counting-number-of-occurences-in-an-array/31613/2
	    c = counter(filtered_array)
	    for key in collect(keys(c))
	        val = c[key]
	        if isodd(val)
	            return Complex[]
	        else
	            half = round(Int, val/2)
	            append!(org, fill(key, half))
	            append!(con, fill(key, half))
	        end
	    end
	    half = round(Int, length(filtered_array)/2)
	 
	    # filter by !p mod(4) == 1 and count, this should give all the complex conjugates
	
	    array1 = filter(!(y -> mod_4(real(y)) == 3 && imag(y) ==0), array)
	    len = length(array1)
	        # first pass through to seperate out the complex conjugates 
		if len > 0
	        for x in 1:len
	            temp = array1[x]
	            if conj(temp) in org
	                push!(con, temp)
	            else
	                push!(org, temp)
	            end
	        end
	        push!(result, prod(org))
	        push!(result, prod(con))
	    end
		# https://stackoverflow.com/questions/40227282/combinations-of-two-arrays-with-ordering-in-julia
        combinations = vec(collect(Base.product(zip(org, con)...)))
        map((x) -> push!(result, prod(x)), combinations)
	    unique(result)
	end
end

# ╔═╡ a565a83c-247a-4367-a4dd-fe9bf86e0e6a
md"""
## Find all complex conjugate pairs with product $\sqrt{radius}$.

Next, organize these into two columns, with conjugate pairs sitting right next to each other. Now multiply what’s in each column, and you’ll come out with two Gaussian integers. Because everything in the right is a conjugate to everything in the left, what comes out will be a complex conjugate pair, which multiply to make 25.

The three lattice points we originally found, can each be multiplied by i, -1, or -i, and that accounts for all 12 ways to construct
a gaussian integer whose product with its own conjugate is 25. 
"""

# ╔═╡ 593279c7-1757-4c08-a19d-a3d269423040
df_pi.cartesian = cartesian.(df_pi.cc)

# ╔═╡ 7ec2f302-bd04-4e0e-97be-56e93ecc361c
df_pi

# ╔═╡ 9ca7013a-3115-4931-b9da-034934e50295
function img_ops(collection)
	if collection == 0
		return 0
	end
	unique(vcat(collection, collection * (0+1im), collection * (0-1im), collection * (-1+0im)), dims=1)
end

# ╔═╡ 09f4b07a-877c-4357-bbe1-4d46606e8dec
df_pi.img_ops = img_ops.(df_pi.cartesian)

# ╔═╡ e3cbf4ec-8e7b-44ce-887f-b978524c5cbf
df_pi.size = size.(df_pi.img_ops,1)

# ╔═╡ 10ed3abf-ae21-453c-ae7b-c27d0f106dae
df_pi.chi = computeΧ.(df_pi.factors)

# ╔═╡ af40960b-1d79-42ed-a69c-2f24465cfc02
df_pi

# ╔═╡ 332a89f4-ee30-4c27-8f77-af55144510fb
function complex_filter(size, chi)::Bool # https://juliadatascience.io/filter_subset
	size == chi
end

# ╔═╡ c35e5ed6-879d-4a29-b6e5-69e0d1ea669b
df_pi_1 = filter([:size, :chi] => !complex_filter, df_pi)

# ╔═╡ 11603b9f-0da0-43b4-9e22-a93a19b79d9f
sum(df_pi.size)/radius

# ╔═╡ d3a1f7c2-9e44-4b8a-a1d0-5f3c6e8b9d71
md"""
## From lattice points to π

Why does counting lattice points lead to π? The key insight is the **Dirichlet character** Χ, which classifies how primes behave in the Gaussian integers:

- Χ(n) = 1 if n ≡ 1 (mod 4) — these primes **split** into conjugate Gaussian primes
- Χ(n) = -1 if n ≡ 3 (mod 4) — these primes **stay prime** in the Gaussian integers
- Χ(n) = 0 if n is even

The number of lattice points at distance √N from the origin equals 4 times the sum of Χ(d) over all divisors d of N. This is exactly what `computeΧ` calculates.

When we sum the lattice point counts for all N from 1 to R, we are counting all lattice points inside a circle of radius √R. The area of that circle is πR, so:

$\sum_{N=1}^{R} \text{(lattice points at distance } \sqrt{N}) \approx \pi R$

Dividing by R gives us π. The deeper connection is that this sum telescopes into the **Leibniz formula**:

$\frac{\pi}{4} = 1 - \frac{1}{3} + \frac{1}{5} - \frac{1}{7} + \cdots = \sum_{k=0}^{\infty} \frac{\chi(2k+1)}{2k+1}$

This is the circle hiding behind prime regularities — the way primes distribute among residues mod 4 encodes π itself.
"""

# ╔═╡ b79e53f5-89c7-45c5-9ada-cff0f7345bb8
pi_approx = (sum(df_pi.chi)-1)/radius

# ╔═╡ a9d4a058-7ab0-42eb-b879-3787dcedf1c0
# https://discourse.julialang.org/t/how-to-convert-all-nothings-in-dataframe-to-missing/54004/10
df_pi_1.mod4 = replace(df_pi_1.mod4, nothing => missing)

# ╔═╡ c193d0f7-44d5-44ab-9a0e-1271e23b06f6
# ╠═╡ disabled = true
#=╠═╡
CSV.write("prime_pi.csv", df_pi_1)
  ╠═╡ =#



# ╔═╡ Cell order:
# ╟─eae0d1c0-8b19-43e4-97f8-21f89708018e
# ╟─4bb7d51f-ef33-4228-a39f-0f39a709899a
# ╟─4e5fccf3-d7d3-4e7f-be3f-4eb24f5a4239
# ╟─ca796498-1218-4109-b90f-5038ab76c629
# ╟─4c72470d-729d-480d-ac59-f65f195ec4ce
# ╟─08df6171-cc09-4239-b458-2a8ba87d69ca
# ╟─73b1b527-d820-4531-92a1-73df0a492b0b
# ╟─ceb4fa2c-3981-466d-b0f8-0468bb264c68
# ╟─5b5ff634-c6bf-4fe9-b442-8e9821156e75
# ╠═fe677804-cf1f-4413-abe4-684943d68d5f
# ╠═08a9d538-1eba-11ed-1ac4-c1b15c5bb280
# ╟─f89f32a4-2d1d-4905-90d9-6746576bf432
# ╠═ea560410-5c83-4fe2-afd5-03d09af0685d
# ╠═7463bf07-e164-4580-9a0f-581625994762
# ╠═542584b1-5cff-4096-9626-bda7c57df38c
# ╠═72460280-bbfa-492d-8270-e44293266e09
# ╟─bb47b3f0-b4d7-43d8-945f-ee94e9def8f6
# ╠═96c8a707-30be-4154-aaf3-bc48b39cfb85
# ╠═af516c3f-6fcf-4db7-a89f-30b1e813863c
# ╟─83fee348-2ee5-4612-b909-f73a800b9cb6
# ╟─763c51c1-a1a8-4262-8d40-14799603279a
# ╟─46b2299a-3c88-4f5f-9f46-3c773c70b189
# ╠═7bc5e477-37b0-435e-9224-152bc562ff04
# ╠═2de72be6-3ebd-4282-8ab0-d51bbe727aea
# ╠═9d7518a1-95a5-42fc-b268-87b100c3e96d
# ╠═c056d31e-6351-4d76-b484-fb8013c20b67
# ╟─5c522f78-8ac8-4ee8-860e-80f7b7a2023f
# ╟─22e0a886-2b99-4453-b1f3-24a889d212e5
# ╠═2c8e6f69-f0b9-43a1-b18e-94a4e5de993d
# ╠═bcd7bbc4-90c8-492c-903d-b9559d8a2eb5
# ╟─005b38ac-ef4c-4514-96d3-a14ea64af4a8
# ╠═b899d763-5636-4142-b93b-30b578144d01
# ╠═f6795737-d724-4ee0-9be9-6fb92bb898fc
# ╟─a565a83c-247a-4367-a4dd-fe9bf86e0e6a
# ╠═593279c7-1757-4c08-a19d-a3d269423040
# ╠═7ec2f302-bd04-4e0e-97be-56e93ecc361c
# ╠═9ca7013a-3115-4931-b9da-034934e50295
# ╠═09f4b07a-877c-4357-bbe1-4d46606e8dec
# ╠═e3cbf4ec-8e7b-44ce-887f-b978524c5cbf
# ╠═10ed3abf-ae21-453c-ae7b-c27d0f106dae
# ╠═af40960b-1d79-42ed-a69c-2f24465cfc02
# ╠═332a89f4-ee30-4c27-8f77-af55144510fb
# ╠═c35e5ed6-879d-4a29-b6e5-69e0d1ea669b
# ╠═11603b9f-0da0-43b4-9e22-a93a19b79d9f
# ╟─d3a1f7c2-9e44-4b8a-a1d0-5f3c6e8b9d71
# ╠═b79e53f5-89c7-45c5-9ada-cff0f7345bb8
# ╠═a9d4a058-7ab0-42eb-b879-3787dcedf1c0
# ╠═a28594c7-c134-4548-9ac1-1049bbe14f4b
# ╠═c193d0f7-44d5-44ab-9a0e-1271e23b06f6
