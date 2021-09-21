# CitableCorpusAnalysis.jl

> *Tokenize and analyze a citable text corpus*.

There are many ways to model a text corpus.  `CitableCorpusAnalysis` integrates the models from these Julia modules:

- `Corpus` in `TextAnalysis`
- `CitableTextCorpus` in `CitableCorpus`

It also introduces a further model, the `AnalyticalCorpus`.




## Overview



An `AnalyticalCorpus` has three components:

1. a citable corpus of texts (a `CitableText.CitableTextCorpus`)
2. an orthographic system that can validate orthography and tokenize a citable text (an `Orthography.OrthographicSystem`)
3. a citable parser, that analyses citable tokens in terms of citable lexemes and morphological or other data (a `CitableParserBuilder.CitableParser`)

Functions working with an `AnalyticalCorpus` can tokenize a corpus, analyze its tokens with a `CitableParser`, and can apply the corpus analytical functions of a `TextAnalysis.Corpus` to any citable text content.

## Example pages


The following pages walk through examples using a small corpus comprising all the extant versions of the Gettysburg address.  We will tokenize it with a simple ASCII tokenizer included in the `Orthography` module, and will parse it with a custom `GettysburgParser` built for this demo. (Its construction is documented in the appendix to these pages, and illustrates one simple way to build an English-language parser by wrapping the Python NLTK POS tagger.)



```jldoctest overview
using CitableCorpusAnalysis
using CitableCorpus
using Orthography
using HTTP
# Load a CitableCorpus from a URL:
url = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/dev/test/data/gettysburg/gettysburgcorpus.cex"
corpus = HTTP.get(url).body |> String  |> corpus_fromcex
# Instantiate orthographic system and parser
orthography = Orthography.simpleAscii()
parser = CitableCorpusAnalysis.gettysburgParser()
acorpus = AnalyticalCorpus(corpus, orthography, parser)
typeof(acorpus)

# output

AnalyticalCorpus
```

