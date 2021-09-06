
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


In Julia, you can make the NLTK module's `tag` function available like this:

```@example parserexample
using PyCall
@pyimport nltk.tag as ptag
```

Now if we have a citable corpus named `corpus`, we can use the `TextAnalysis` functions to extract a unique lexicon, and apply the NLTK tagger to it.



```@example parserexample
using CitableCorpusAnalysis
using TextAnalysis
tacorp = tacorpus(corpus)

tkns = []
for doc in tacorp.documents
    push!(tkns, tokens(doc))
end
tknlist = tkns |> Iterators.flatten |> collect |> unique
tagged = ptag.pos_tag(tknlist)
```


```@example parserexample
lines = []
for t in tagged
    delimited = string(t[1], ",", t[2])
    push!(lines, delimited)
end
open("posdict.csv", "w") do io
    write(io, join(lines, "\n"))
end
```
