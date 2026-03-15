import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller =
        VideoPlayerController.network(
            "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
          )
          ..initialize().then((_) {
            setState(() {});
            controller.play();
            controller.setLooping(true);
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
