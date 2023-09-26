class Post {

  final int id;
  final int authorId;
  final String authorUsername;
  String title;
  String content;
  final String createdAt;
  final String updatedAt;
  final bool isAuthor;
  final int? guestId;

  Post({
    required this.id,
    required this.authorId,
    required this.authorUsername,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.isAuthor,
    this.guestId,
  });

  factory Post.fromJson(Map<String, dynamic> data, int? guestStatus) => Post(
    id: data['id'],
    authorId: data['author']['id'],
    authorUsername: data['author']['name'],
    title: data['attributes']['title'],
    content: data['attributes']['content'],
    createdAt: data['attributes']['created_at'],
    updatedAt: data['attributes']['updated_at'],
    isAuthor: guestStatus == data['author']['id'],
    guestId: guestStatus,
  );

  factory Post.newJson(Map<String, dynamic> data) => Post(
    id: data['id'],
    authorId: data['user_id'],
    authorUsername: data['user_username'],
    title: data['title'],
    content: data['content'],
    createdAt: data['created_at'],
    updatedAt: data['updated_at'],
    isAuthor: true,
    guestId: data['user_id'],
  );

  @override
  bool operator==(other) => other is Post && (other.id == id);
  
  @override
  int get hashCode => id;

}