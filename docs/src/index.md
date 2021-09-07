# CitableCorpusAnalysis.jl

> Tokenize and analyze a citable text corpus.

There are many ways to model a text corpus.  `CitableCorpusAnalysis` integrates the models from these Julia modules:

- `Corpus` in `TextAnalysis`
- `Corpus` in `TopicModelsVB`
- `CitableTextCorpus` in `CitableCorpus`


## Overview



An `AnalyticalCorpus` has three components:

1. a citable corpus of texts
2. an orthographic system that can validate orthography and tokenize a citable text
3. a citable parser, that analyses citable tokens in terms of citable lexemes and morphological or other data.

Functions working an `AnalyticalCorpus` can 

## Example pages


The following pages walk through examples using a small corpus comprising all the extant versions of the Gettysburg address.  We will tokenize it with a simple ASCII tokenizer included in the `Orthography` module, and will parse it with a custom `GettysburgParser` built for this demo. (Its construction is documented in the appendix to these pages, and illustrates one simple way to build an English-language parser by wrapping the Python NLTK POS tagger.)



```jldoctest overview
using CitableCorpusAnalysis
using CitableCorpus
using Orthography

corpus = fromurl(CitableTextCorpus, "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/main/test/data/gettysburg/gettysburgcorpus.cex", "|")
orthography = simpleAscii()
parser = CitableCorpusAnalysis.gettysburgParser()
acorpus = AnalyticalCorpus(corpus, orthography, parser)
typeof(acorpus)

# output

AnalyticalCorpus
```



