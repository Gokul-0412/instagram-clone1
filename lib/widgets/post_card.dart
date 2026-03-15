import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/post_model.dart';

// ✅ Extend ConsumerStatefulWidget instead of StatefulWidget if using ref inside state
class PostCard extends ConsumerStatefulWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  ConsumerState<PostCard> createState() => _PostCardState();
}

class _PostCardState extends ConsumerState<PostCard> {
  bool liked = false;
  bool saved = false;
  bool showHeart = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.post.avatarUrl),
          ),
          title: Text(
            widget.post.username,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.more_vert),
        ),
        SizedBox(
          height: 300,
          child: GestureDetector(
            onDoubleTap: () {
              setState(() {
                liked = true;
                showHeart = true;
              });
              Future.delayed(const Duration(milliseconds: 800), () {
                setState(() {
                  showHeart = false;
                });
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                PageView(
                  children: widget.post.imageUrls.map((url) {
                    return CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    );
                  }).toList(),
                ),
                if (showHeart)
                  const Icon(Icons.favorite, color: Colors.white, size: 100),
              ],
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                liked ? Icons.favorite : Icons.favorite_border,
                color: liked ? Colors.red : null,
              ),
              onPressed: () => setState(() => liked = !liked),
            ),
            IconButton(
              icon: const Icon(Icons.comment),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Comments coming soon"),
                  duration: Duration(seconds: 3),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Share coming soon"),
                  duration: Duration(seconds: 3),
                ),
              ),
            ),
            const Spacer(),
            IconButton(
              icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
              onPressed: () => setState(() => saved = !saved),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.post.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' '),
                TextSpan(text: widget.post.caption),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            widget.post.timestamp,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
