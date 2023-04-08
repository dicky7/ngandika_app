import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/message_model.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/message_content_type/time_sent_message_widget.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/preview_message_content/video_message_preview.dart';
import 'package:video_player/video_player.dart';

class VideoMessageWidget extends StatefulWidget {
  final MessageModel messageData;

  const VideoMessageWidget({Key? key, required this.messageData}) : super(key: key);

  @override
  State<VideoMessageWidget> createState() => _VideoMessageWidgetState();
}

class _VideoMessageWidgetState extends State<VideoMessageWidget> {
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
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        Navigator.pushNamed(context, VideoMessagePreview.routeName, arguments: widget.messageData);
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AspectRatio(
            aspectRatio: 9/16,
            child: Stack(
              children: [
                CachedVideoPlayer(_videoPlayerController),
                buildPlayPauseButton(),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: TimeSentMessageWidget(messageData: widget.messageData),
                )
              ],
            ),
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
          size: 40,
        ),
      ),
    );
  }
}
