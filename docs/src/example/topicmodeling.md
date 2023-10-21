# Topic modeling

To illustrate topic modeling, we will use the famous corpus of State of the Union addresses from 1914 through 2009, included in a citable format in the `test/data` directory of this repository.


```@example tm
using CitableBase, CitableCorpus
corpusurl = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/dev/test/data/sotu.cex"
corpus = fromcex(corpusurl, CitableTextCorpus, UrlReader)
```


