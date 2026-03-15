import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post_model.dart';
import '../services/post_repository.dart';

// Single repository provider
final postRepositoryProvider = Provider((ref) => PostRepository());

// StateNotifier to handle feed with pagination
class FeedNotifier extends StateNotifier<List<Post>> {
  FeedNotifier(this.repository) : super([]);

  final PostRepository repository;
  int page = 0;
  bool loading = false;

  // Load next page of posts
  Future<void> loadPosts() async {
    if (loading) return;

    loading = true;

    try {
      final posts = await repository.fetchPosts(page: page);
      state = [...state, ...posts]; // append new posts
      page++;
    } catch (e) {
      // handle error (optional)
      rethrow;
    } finally {
      loading = false;
    }
  }
}

// Provide the FeedNotifier
final feedNotifierProvider = StateNotifierProvider<FeedNotifier, List<Post>>((
  ref,
) {
  final repo = ref.watch(postRepositoryProvider);
  return FeedNotifier(repo);
});
