class Post {
  final String publisher;
  final String thumbnail;
  final Map<String, dynamic> postRaw;
  late String imageURL;
  late String caption;
  late String hyperlink;
  late DateTime date;

  Post(
      {required this.publisher,
      required this.thumbnail,
      required this.postRaw}) {
    caption = postRaw['caption'];
    imageURL = postRaw['imageURL'];
    hyperlink = postRaw['hyperlink'];
    date = DateTime.fromMillisecondsSinceEpoch(postRaw['date']);
  }
}
