# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
# Run this from repository root to serve:
#
#   julia -e 'using LiveServer; serve(dir="docs/build")'
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions
using CitableCorpusAnalysis


makedocs(
    sitename = "CitableCorpusAnalysis.jl",
    pages = [
        "Overview" => "index.md",
        "Example" => [
            "example/corpus.md",
            "example/models.md",
            "example/topicmodeling.md",
            "example/profiling.md"
        ],
        "API documentation" =>  "man/api.md"
    ]

)


deploydocs(
    repo = "github.com/neelsmith/CitableCorpusAnalysis.jl.git",
)

