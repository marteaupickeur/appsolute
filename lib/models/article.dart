class Article {
  final Map<String, dynamic> source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  // my data model like data on API
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  // function : create an article with a Json or map format
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        source: json['source'],
        author: json['author'],
        title: json['title'],
        description: json['description'],
        url: json['url'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
        content: json['content']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return title!;
  }
}
