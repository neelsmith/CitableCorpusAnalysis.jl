module CitableCorpusAnalysis

# Encapsulate and extend these:
import Orthography: tokenize
import Orthography: tokenizedcorpus

using CitableBase
using CitableText, CitableCorpus
using Orthography
using CitableParserBuilder
using TextAnalysis

import Base: show

using Documenter, DocStringExtensions

include("analyticalcorpus.jl")
include("profiling_ortho.jl")
include("profiling_parsing.jl")
include("tacorpus.jl")
include("topicmodel.jl")

export AnalyticalCorpus
export analyzecorpus, serialize_analyses
export tacorpus, talexicon, dtmatrix

export TopicModel
export lda_tm
export labeltopic



export tokenize, tokenizedcorpus
export lexicalcorpus, lexicalsize
export vocabulary, vocabulary_size, vocabulary_density

end # module
