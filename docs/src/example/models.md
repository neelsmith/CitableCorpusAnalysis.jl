# Using different models of a text corpus



## `CitableTextCorpus`

The base model of a text corpus is the `CitableTextCorpus`: a citable, human-readable series of text passages.  


```@example models
using CitableBase, CitableCorpus
corpusurl = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/dev/test/data/gettysburg/gettysburgcorpus.cex"
corpus = fromcex(corpusurl, CitableTextCorpus, UrlReader)
```


## `TextAnalysis.Corpus`

You can convert this to the `Corpus`  model of Julia's `TextAnalysis` module.

```@example models
using CitableCorpusAnalysis
ta_corp = tacorpus(corpus)
```

The `TextAnalysis` module has a variety of functions for basic metrics on a text, and for corpora in English, includes more advanced tools for tokenizing, tagging for part of speech, and working with neural models.  See the [documentation for `TextAnalysis.Corpus`](https://docs.juliahub.com/TextAnalysis/5Mwet/0.7.3/).

!!! warning "Tokenization"

    If the assumptions of `TextAnalysis` (oriented towards English) are not appropriate for your corpus, you can sometimes work around this by preprocessing your original `CitableCorpus`.  E.g, by creating a tokenized corpus that takes account of a specified orthography, and using this as the source for a `TextAnalysis.Corpus`, you can protect your corpus from naive assumptions about tokenization.
