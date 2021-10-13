module CitableCorpusAnalysis

# Encapsulate and extend these:
import Orthography: tokenize
import Orthography: tokenizedcorpus

using CitableText, CitableCorpus
using Orthography
using CitableParserBuilder
using TextAnalysis
#using TopicModelsVB

using Documenter, DocStringExtensions

include("analyticalcorpus.jl")
include("profiling.jl")
include("tacorpus.jl")
#include("tmcorpus.jl")

export AnalyticalCorpus
export analyzecorpus, serialize_analyses
export tacorpus, talexicon, dtmatrix
#export tmcorpus


export tokenize, tokenizedcorpus, tokentuples
export lexicalcorpus
end # module
