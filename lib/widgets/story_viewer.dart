import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryViewer extends StatefulWidget {
  const StoryViewer({super.key});

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {

  final controller = StoryController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StoryView(
        controller: controller,
        storyItems: [

          StoryItem.pageImage(
            url:
            "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d",
            controller: controller,
          ),

          StoryItem.text(
            title: "Flutter Instagram Clone",
            backgroundColor: Colors.black,
          )
        ],
      ),
    );
  }
}