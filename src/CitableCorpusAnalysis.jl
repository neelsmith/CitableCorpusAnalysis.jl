module CitableCorpusAnalysis

using CitableText, CitableCorpus
using Orthography
using CitableParserBuilder
using TextAnalysis
#using TopicModelsVB

using Documenter, DocStringExtensions

include("analyticalcorpus.jl")
include("tacorpus.jl")
#include("tmcorpus.jl")


#include("gettysburg.jl")

export AnalyticalCorpus
export analyzecorpus, serialize_analyses
export tacorpus, talexicon, dtmatrix
#export tmcorpus

end # module
