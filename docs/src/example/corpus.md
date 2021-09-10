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
using Othography
orthography = simpleAscii()

```

- orthography: tokenization
- morphological analysis

## Interoperating with Julia `TextAnalysis.Corpus`

- generate a `TextAnalysis.Corpus` from a `CitableCorpus`

Sometimes, you'll want to preprocess the original `CitableCorpus` so as not to depend on the tokenization of the `TextAnalysis` module.  You can do this by creating a tokenized corpus that takes account of a specified orthography, and constructing a `TextAnalysis.Corpus` from this source.

## Profiling a corpus

- lexical metrics
- morphological metrics