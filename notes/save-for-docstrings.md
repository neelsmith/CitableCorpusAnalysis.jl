
### Aside: working with selections

You can use any of the functions of the `CitableCorpus` module to work with selections from a citable corpus.  E.g., you can retrieve selected passages, or select a complete document from the corpus

```jldoctest corpus
using CitableText
rangeUrn = CtsUrn("urn:cts:citedemo:gburg.nicolay.v2:1-2")
rangePassages = retrieve(rangeUrn, corpus)

# output

2-element Vector{Any}:
 <urn:cts:citedemo:gburg.nicolay.v2:1> Four score and seven years ago our fathers brought forth, upon this continent, a new nation, conceived in liberty, and dedicated to the proposition that all men are created equal.
 <urn:cts:citedemo:gburg.nicolay.v2:2> Now we are engaged in a great civil war, testing whether that nation, or any nation so conceived, and so dedicated, can long endure. We are met on a great battle field of that war. We come to dedicate a portion of it, as a final resting place for those who died here, that the nation might live. This we may, in all propriety do.
```

```jldoctest corpus
hayUrn = CtsUrn("urn:cts:citedemo:gburg.hay.v2:")
hay = document(hayUrn, corpus)

# output

"Citable document <urn:cts:citedemo:gburg.hay.v2:> 4 citable passages"
```

!!! note

    See the [documentation for the `CitableCorpus` module](https://cite-architecture.github.io/CitableCorpus.jl/stable/) to learn more about manipulating citable documents and corpora.
