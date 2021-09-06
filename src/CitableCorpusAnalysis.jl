module CitableCorpusAnalysis

using CitableText, CitableCorpus
using Orthography
using CitableParserBuilder
using TextAnalysis

using Documenter, DocStringExtensions

include("analyticalcorpus.jl")
include("tacorpus.jl")
include("gettysburg.jl")

export AnalyticalCorpus
export tacorpus

end # module
