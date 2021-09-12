# Modelling a text corpus


## Background

From `CitableText` and `CitableCorpus`:

### Load a corpus


In these examples, we'll work with a corpus of the extant versions of the Gettysburg Address.  We'll load it into the `CitableTextCorpus` model from a URL.

```jldoctest corpus
using CitableCorpus
corpusurl = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/main/test/data/gettysburg/gettysburgcorpus.cex"
corpus = corpus_fromurl(corpusurl, "|")
typeof(corpus)

# output

CitableTextCorpus
```


### Retrieve passages

## Orthographically aware parsing

Some key functions from libraries implementing `Orthography` and `CitableParser`:

- orthography: validation

```jldoctest corpus
using Orthography
orthography = simpleAscii()
typeof(orthography) |> supertype

# output

OrthographicSystem
```

- orthography: tokenization
- morphological analysis