import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/gestures.dart'; // <-- Needed for ScrollDirection
import '../widgets/post_card.dart';
import '../widgets/story_bar.dart';
import '../providers/feed_provider.dart';
import 'package:flutter/rendering.dart';

class HomeFeedScreen extends ConsumerStatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  ConsumerState<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends ConsumerState<HomeFeedScreen> {
  final _scrollController = ScrollController();
  bool _isAppBarVisible = true;

  @override
  void initState() {
    super.initState();
    // Load posts after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feedNotifierProvider.notifier).loadPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(feedNotifierProvider);

    final stories = posts.isEmpty
        ? <String>[]
        : List<String>.from(posts.take(8).map((p) => p.avatarUrl));

    return Scaffold(
      appBar: _isAppBarVisible
          ? AppBar(
              title: const Text(
                'Instagram Clone',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: const [
                Icon(Icons.favorite_border),
                SizedBox(width: 16),
                Icon(Icons.send),
                SizedBox(width: 12),
              ],
            )
          : null,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          // Here ScrollDirection is now defined correctly
          if (notification.direction == ScrollDirection.forward) {
            if (!_isAppBarVisible) setState(() => _isAppBarVisible = true);
          } else if (notification.direction == ScrollDirection.reverse) {
            if (_isAppBarVisible) setState(() => _isAppBarVisible = false);
          }
          return true;
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: posts.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) return StoryBar(stories: stories);
            return PostCard(post: posts[index - 1]);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
