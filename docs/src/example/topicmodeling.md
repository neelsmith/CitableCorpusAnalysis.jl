# Topic modeling

The `lda_tm` function creates a topic model for a citable corpus. It treats each citable passage as a document, and uses the `lda` function of the `TextAnalysis` package to create the model. The only required parameters are a citable corpus, and the number of topics to  create.  You can use the following optional parameters to tweak the settings of the underlying `lda` function:

- `alpha` is the `TextAnalysis` package's α. From its documentation: "The hyperparameter for topic distribution per document. α<1 yields a sparse topic mixture for each document. α>1 yields a more uniform topic mixture for each document."
- `beta`  is the `TextAnalysis` package's β. "The hyperparameter for word distribution per topic. β<1 yields a sparse word mixture for each topic. β>1 yields a more uniform word mixture for each topic."
- `iters` Number of iterations.
- `stopwords` List of terms to omit from the model.

In addition, you can optionally supply a vector of string values to identify each document in the `doclabels` parameter.  By default, this parameter is an empty Vector; in that case, `lda_tm` uses the string value of each passage's URN to identify the topic modeling document.  Note that if you choose to supply a `doclabels` parameter, values must be unique, and the length of `doclabels` must equal the number of citable passages in the source citable corpus.


The following example uses the famous corpus of State of the Union addresses from 1914 through 2009, included in a citable format in the `test/data` directory of this repository.

```@example tm
using CitableBase, CitableCorpus
corpusurl = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/dev/test/data/sotu.cex"
corpus = fromcex(corpusurl, CitableTextCorpus, UrlReader)
```

In the same `test/data` directory, there is a brief stop-word list for this corpus.

```@example tm
using Downloads
stopurl = "https://raw.githubusercontent.com/neelsmith/CitableCorpusAnalysis.jl/dev/test/data/stopwords-sotu.txt"
stopfile = Downloads.download(stopurl)
stopwords = readlines(stopfile)
rm(stopfile)
length(stopwords)
```

We can now create a model for the corpus.  We'll  iterate 50 times and create 20 topics.

```@example tm
using CitableCorpusAnalysis
tm = lda_tm(corpus, 20; stopwords = stopwords, iters = 50)
```

The resulting `TopicModel` object has four fields.

- `terms` List of terms in the model.
- `docids` Identifiers for documents in the model.  This will be either the values provided in the `doclabels` parameter, or string values of each passage's URNs.
- `topic_terms` The topic-term matrix (ϕ of the `TextAnalysis` packages `lda` output)
- `topic_docs` The topic-document matrix (θ  of the `TextAnalysis` packages `lda` output)


The following functions provide convenient access to several simple operations on these values.

Number of topics computed (traditionally, `k`, equivalent to the second parameter provided to the `lda_tm` function):

```@example tm
k(tm)
```



A labelling string for a given topic number composed from the most common terms in the topic:

```@example tm
topiclabel(tm, 1)
```

A labelling string for all topics in the model:

```@example tm
topiclabels(tm)
```


Find string label and score for the top `n` scoring terms in a given topic:

```@example tm
topterms(tm, 1; n = 5)
```


Index of a given term in the `terms` field:

```@example tm
termindex(tm, "et")
```


Index of a given document in the `docids` field:
    
```@example tm
 documentindex(tm, "urn:cts:latinLit:stoa1263.stoa001.hc:t.1") 
```

Scores of each topic for a given document:

```@example tm
topicsfordoc(tm, 1)
```

Label and score of the highest-scored topic for a given document:

```@example tm
topicfordoc(tm, 1) 
```


Function to label and score of all `n` highest-scoring topics for a given document is currently broken!

```@example tm
#topdocs(tm, 1; n = 5)
```    

