
# Appendix: a note on the citable parser

The `GettysburgParser` used in this demonstration works with a simple dictionary of tokens to POS tags.  The dictionary was constructed by wrapping the Python NLTK POS tagger in Julia function. This page documents how to do that so that you can generically apply the NTLK tagger to a list of tokens from Julia.


## Python prerequisites

You need to have Python, with `nltk`.

    pip install nltk

Then start python, and at the python prompt,

    import nltk
    nltk.download

## A Julia wrapper

```@setup parserexample
repo = pwd() |> dirname  |> dirname
bancroftfile = repo * "/test/data/gettysburg/bancroft.cex"
using CitableCorpus
corpus = fromfile(CitableTextCorpus, bancroftfile, "|")
```

```@example parserexample
using CitableTextAnalysis
using TextAnalysis
tacorp = tacorpus(corpus)

tkns = []
for doc in tacorp.documents
    push!(tkns,tokens(doc))
end
tknlist = tkns |> Iterators.flatten |> collect
```


```@example parserexample
using PyCall
@pyimport nltk.tag as ptag

parsed = ptag.pos_tag(tkns)
```
