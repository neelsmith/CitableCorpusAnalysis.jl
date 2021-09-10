"""Essential components of an analytical corpus.

Its contents must be citable, in a defined orthography,
and tokens defined by that orthography must be parseable.
"""
struct AnalyticalCorpus
    corpus::CitableTextCorpus
    orthography::OrthographicSystem
    parser::CitableParser
end