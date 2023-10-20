using Pkg
Pkg.activate("..")

using CitableCorpusAnalysis
using CitableBase
using CitableCorpus, CitableText
using Orthography
using CitableParserBuilder
using TextAnalysis

using CSV
using Test
using TestSetExtensions

@testset "All the tests" begin
    println(map(s -> replace(s, r".jl$" => ""), ARGS))
    @includetests map(s -> replace(s, r".jl$" => ""), ARGS)
end

