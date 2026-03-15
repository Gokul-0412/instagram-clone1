import '../models/post_model.dart';

class PostRepository {
  Future<List<Post>> fetchPosts({int page = 0}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Generate mock posts
    return List.generate(10, (index) {
      return Post(
        username: 'user$index',
        avatarUrl: 'https://i.pravatar.cc/150?img=$index',
        imageUrls: [
          'https://picsum.photos/id/${index + 10}/400/400',
          'https://picsum.photos/id/${index + 20}/400/400',
        ],
        caption: 'Caption for post $index',
        timestamp: '${2 * index}h',
        likes: index * 5, // ✅ MUST include likes
      );
    });
  }
}
