+++
# An example of using the custom widget to create your own homepage section.
# To create more sections, duplicate this file and edit the values below as desired.

date = "2016-04-20T00:00:00"
draft = false

title = "Examples"
subtitle = ""
widget = "custom-fullwidth"

# Order that this section will appear in.
weight = 2

+++

<div class="container">
    <div class="row">
        <div class="col-xs-12 col-md-6 no-padding">
            <p class="no-padding text-center">Create an index and define a text analyser</p>
            <pre class="clean"><code class="csharp">// Ensures index backwards compatibility
var AppLuceneVersion = LuceneVersion.LUCENE_48;

var indexLocation = @"C:\Index";
var dir = FSDirectory.Open(indexLocation);

//create an analyzer to process the text
var analyzer = new StandardAnalyzer(AppLuceneVersion);

//create an index writer
var indexConfig = new IndexWriterConfig(AppLuceneVersion, analyzer);
var writer = new IndexWriter(dir, indexConfig);
                 </code>
            </pre>
        </div>
        <div class="col-xs-12 col-md-6">
            <p class="no-padding text-center">Add to the index</p>
            <pre class="clean"><code class="csharp">var source = new
{
	Name = "Kermit the Frog",
	FavouritePhrase = "The quick brown fox jumps over the lazy dog"
};
var doc = new Document();
// StringField indexes but doesn't tokenise
doc.Add(new StringField("name", source.Name, Field.Store.YES));

doc.Add(new TextField("favouritePhrase", source.FavouritePhrase, Field.Store.YES));

writer.AddDocument(doc);
writer.Flush(triggerMerge: false, applyAllDeletes: false);
</code>
        </div>
    </div>
<div class="row">
    <div class="col-xs-12 col-md-6">
        <p class="no-padding text-center">Construct a query</p>
        <pre class="clean"><code class="csharp">// search with a phrase
var phrase = new MultiPhraseQuery();
phrase.Add(new Term("favouritePhrase", "brown"));
phrase.Add(new Term("favouritePhrase", "fox"));
            </code>
        </pre>
    </div>
 
<div class="col-xs-12 col-md-6">
        <p class="no-padding text-center">Fetch the results</p>
        <pre class="clean"><code class="csharp">// re-use the writer to get real-time updates
var searcher = new IndexSearcher(writer.GetReader(applyAllDeletes: true));

var hits = searcher.Search(phrase, 20 /* top 20 */).ScoreDocs;

foreach (var hit in hits)
{
	var foundDoc = searcher.Doc(hit.Doc);
	hit.Score.Dump("Score");
	foundDoc.Get("name").Dump("Name");
	foundDoc.Get("favouritePhrase").Dump("Favourite Phrase");
}</code>
</pre>
</div>
</div>
</div>