class Comment {

  final int id;
  final int postId;
  final int ownerId;
  final String ownerUsername;
  String content;
  final String createdAt;
  String updatedAt;

  Comment({
    required this.id,
    required this.postId,
    required this.ownerId,
    required this.ownerUsername,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> data) => Comment(
    id: data['id'],
    postId: data['post_id'],
    ownerId: data['owner']['id'],
    ownerUsername: data['owner']['name'],
    content: data['attributes']['content'],
    createdAt: data['attributes']['created_at'],
    updatedAt: data['attributes']['updated_at'],
  );
  
  @override
  bool operator==(other) => other is Comment && (other.id == id);
  
  @override
  int get hashCode => id;

}
