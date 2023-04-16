import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/preview_message_content/app_bar_message_preview.dart';
import 'package:ngandika_app/utils/styles/style.dart';

import '../../../../../../../data/models/message_model.dart';

class VideoMessagePreview extends StatefulWidget {
  static const routeName = "video-message-preview";
  final MessageModel messageData;

  const VideoMessagePreview({Key? key, required this.messageData}) : super(key: key);

  @override
  State<VideoMessagePreview> createState() => _VideoMessagePreviewState();
}

class _VideoMessagePreviewState extends State<VideoMessagePreview> {
  late CachedVideoPlayerController _videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    //_controller object is initialized with a CachedVideoPlayerController that is created from a network and pass widget.messageData.text as url.
    // The initialize() method is called on the _controller object to initialize the video player, and a then() callback is used to trigger a setVolume after the video is initialized,
    _videoPlayerController = CachedVideoPlayerController.network(widget.messageData.text)..initialize().then((value) {
      _videoPlayerController.setVolume(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarMessagePreview(messageData: widget.messageData),
      body: Center(
        child: AspectRatio(
          aspectRatio: 9/16,
          child: Stack(
            children: [
              CachedVideoPlayer(_videoPlayerController),
              buildPlayPauseButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPlayPauseButton(){
    return Align(
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () {
          //If isPlay is true, _videoPlayerController.pause() is called to pause the video, otherwise _videoPlayerController.play() is called to play the video.
          // After that, setState() is called to update the state of the widget and toggle the value of isPlay using isPlay = !isPlay.
          if (isPlay) {
            _videoPlayerController.pause();
          } else {
            _videoPlayerController.play();
          }
          setState(() {
            isPlay = !isPlay;
          });
        },
        icon: Icon(
          isPlay ? Icons.pause_circle : Icons.play_circle,
          size: 60,
          color: kGreyColor,
        ),
      ),
    );
  }
}
