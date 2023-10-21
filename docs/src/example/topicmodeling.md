# Topic modeling

To illustrate topic modeling, we will use the famous corpus of State of the Union addresses from 1914 through 2009, included in a citable format in the `test/data` directory of this repository.


```@example tm
using CitableBase, CitableCorpus
corpusurl = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/dev/test/data/sotu.cex"
corpus = fromcex(corpusurl, CitableTextCorpus, UrlReader)
```

To create an LDA topic model of a corpus, the only required parameters are the corpus and the number of topics.  The most important optional parameter is a stop-word list of tokens to ignore.  There is also a brief stop-word list for this corpus in the `test/data` directory.






```@example tm
using Downloads
stopurl = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/dev/test/data/stopwords-sotu.txt"
stopfile = Downloads.download(stopurl)
stopwords = readlines(stopfile)
rm(stopfile)
length(stopwords)
```

We can now create a 20-topic model for the corpus with the `lda_tm` function.

```@example tm
using CitableCorpusAnalysis
tm = lda_tm(corpus, 20; stopwords = stopwords)
```

