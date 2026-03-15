class Post {
  final String username;
  final String avatarUrl;
  final List<String> imageUrls;
  final String caption;
  final int likes;
  final String timestamp;

  Post({
    required this.username,
    required this.avatarUrl,
    required this.imageUrls,
    required this.caption,
    required this.likes, // ✅ added here
    required this.timestamp,
  });
}
