# Invoke this from repos. root, e.g.,
# 
#  julia --project=extra/ extra/engpos.jl
#
repo = pwd()

using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Conda
Conda.add("nltk")
using PyCall
@pyimport nltk.tag as ptag

using TextAnalysis
using CitableCorpus
using CitableTextAnalysis


#= Tokenize a document:
doc = StringDocument("In the beginning, God created the heavens and the earth.")
tkns = tokens(doc) # In TextAnalysis
parsed = ptag.pos_tag(tkns)

# Token values:
# https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html
println(join(parsed,"\n"))

# See also
# https://github.com/neelsmith/gettysburg
=#


bancroftfile = repo * "/test/data/gettysburg/bancroft.cex"
corpus = fromfile(CitableTextCorpus, bancroftfile, "|")
tacorp = tacorpus(corpus)

tkns = []
for doc in tacorp.documents
    push!(tkns,tokens(doc))
end
tknlist = tkns |> Iterators.flatten |> collect
