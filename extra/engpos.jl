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
using CitableCorpusAnalysis

# POS values:
# https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html
#
# Source files:
# https://github.com/neelsmith/gettysburg


gburgfile = repo * "/test/data/gettysburg/gettysburgcorpus.csv"
corpus = corpus_fromfile(gburgfile, "|")
tacorp = tacorpus(corpus)

tkns = []
for doc in tacorp.documents
    push!(tkns,tokens(doc))
end
tknlist = tkns |> Iterators.flatten |> collect |> unique
tagged = ptag.pos_tag(tknlist)

lines = []
for t in tagged
    delimited = string(t[1], ",", t[2])
    push!(lines, delimited)
end
open("posdict.csv", "w") do io
    write(io, join(lines, "\n"))
end

