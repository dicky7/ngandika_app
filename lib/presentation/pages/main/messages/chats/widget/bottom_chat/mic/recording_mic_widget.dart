import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ngandika_app/presentation/pages/main/messages/chats/widget/bottom_chat/mic/recording_timer.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../../utils/styles/style.dart';

class RecordingMicWidget extends StatefulWidget {
  final VoidCallback onVerticalScrollComplete;
  final VoidCallback onHorizontalScrollComplete;
  final VoidCallback onLongPress;
  final VoidCallback onLongPressCancel;
  final VoidCallback onSend;
  final VoidCallback onTapCancel;

  const RecordingMicWidget({Key? key,
    required this.onVerticalScrollComplete,
    required this.onHorizontalScrollComplete,
    required this.onLongPress,
    required this.onLongPressCancel,
    required this.onSend,
    required this.onTapCancel}) : super(key: key);

  @override
  _RecordingMicWidgetState createState() => _RecordingMicWidgetState();
}

class _RecordingMicWidgetState extends State<RecordingMicWidget> with SingleTickerProviderStateMixin {
  double micHorizontal = 6;
  double micVertical = 0;

  double micWidth = 50;
  double micHeight = 50;

  bool isVerticalScroll = true;
  bool showSwipeOptions = false;
  bool isVerticalActionComplete = false;
  bool isHorizontalActionComplete = false;
  bool isShowMic = false;
  bool isShowTime = false;

  late AnimationController _animationController;

  //Mic
  late Animation<double> _micTranslateTop;
  late Animation<double> _micRotationFirst;
  late Animation<double> _micTranslateRight;
  late Animation<double> _micTranslateLeft;
  late Animation<double> _micRotationSecond;
  late Animation<double> _micTranslateDown;
  late Animation<double> _micInsideTrashTranslateDown;


  //Trash Can
  late Animation<double> _trashWithCoverTranslateTop;
  late Animation<double> _trashCoverRotationFirst;
  late Animation<double> _trashCoverTranslateLeft;
  late Animation<double> _trashCoverRotationSecond;
  late Animation<double> _trashCoverTranslateRight;
  late Animation<double> _trashWithCoverTranslateDown;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    /**
     * Mic
     */

    _micTranslateTop = Tween(begin: 0.0, end: -150.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
      ),
    );

    _micRotationFirst = Tween(begin: 0.0, end: pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.2),
      ),
    );

    _micTranslateRight = Tween(begin: 0.0, end: 13.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.1),
      ),
    );

    _micTranslateLeft = Tween(begin: 0.0, end: -13.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.1, 0.2),
      ),
    );

    _micRotationSecond = Tween(begin: 0.0, end: pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.45),
      ),
    );

    _micTranslateDown = Tween(begin: 0.0, end: 150.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.45, 0.79, curve: Curves.easeInOut),
      ),
    );

    _micInsideTrashTranslateDown = Tween(begin: 0.0, end: 55.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.95, 1.0, curve: Curves.easeInOut),
      ),
    );

    /**
     * Trash Can
     */

    _trashWithCoverTranslateTop = Tween(begin: 30.0, end: -25.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.45, 0.6),
      ),
    );

    _trashCoverRotationFirst = Tween(begin: 0.0, end: -pi / 3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.6, 0.7),
      ),
    );

    _trashCoverTranslateLeft = Tween(begin: 0.0, end: -18.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.6, 0.7),
      ),
    );

    _trashCoverRotationSecond = Tween(begin: 0.0, end: pi / 3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.8, 0.9),
      ),
    );

    _trashCoverTranslateRight = Tween(begin: 0.0, end: 18.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.8, 0.9),
      ),
    );

    _trashWithCoverTranslateDown = Tween(begin: 0.0, end: 55.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.95, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Stack(
        children: [
          // this widget is for replacing the TextField with a Container similar to the TextField
          Positioned(
            bottom: 0,
            right: 50,
            child: Visibility(
              visible: showSwipeOptions || isVerticalActionComplete,
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26.00),
                    color: kPrimaryColor,
                    border: Border.all(width: 1, color: kGreyColor)
                  ),
                  width: context.width(1) - 65,
                  height: 50,
                ),
              ),
            ),
          ),

          //this widget show shimmer text to cancel recording mic
          Positioned(
            bottom: 15,
            right: 70,
            child: Visibility(
              visible: showSwipeOptions,
              child: Shimmer.fromColors(
                direction: ShimmerDirection.rtl,
                baseColor: Colors.grey.shade500,
                highlightColor: Colors.grey.shade300,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.chevron_left,
                    ),
                    Text(
                      "swipe to cancel",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //this widget will show text to cancel mic and only appears when user swipe up mic to lock recording mic
          Positioned(
            bottom: 15,
            right: 70,
            child: Visibility(
              visible: isVerticalActionComplete,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isVerticalActionComplete = false;
                    isShowMic =false;
                    isShowTime = false;
                  });
                  widget.onTapCancel();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),

          //this widget will show lock if user want to lock recording mic
          Positioned(
            bottom: 120,
            right: 0,
            child: Visibility(
              visible: showSwipeOptions,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.00),
                  color: Colors.white,
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade500,
                  highlightColor: Colors.grey.shade300,
                  child: const Icon(
                    Icons.lock_rounded,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),

          //this widget will show mic and user can press it to get action
          Positioned(
            right: micHorizontal,
            bottom: micVertical,
            child: GestureDetector(
              // this is used when the recording is locked and you want to save the audio
              onTap: () {
                if (isVerticalActionComplete) {
                  setState(() {
                    isVerticalActionComplete = false;
                    isShowMic =false;
                    isShowTime=false;
                  });
                  widget.onSend();
                }
              },

              //when the user long-presses on the mic icon.  it is used to initiate the recording process and update the UI by changing the
              // size of the mic icon, showing swipe options, and showing mic and time indicators.
              onLongPress: () {
                widget.onLongPress();
                isVerticalActionComplete = false;
                isHorizontalActionComplete = false;

                setState(() {
                  micWidth = 80;
                  micHeight = 80;
                  showSwipeOptions = true;
                  isShowMic =true;
                  isShowTime=true;
                });
              },

              //when the user releases the long-press on the mic icon. it is used to reset the UI and cancel the recording process if the long-press is not complete.
              onLongPressEnd: (LongPressEndDetails lg) {
                setState(() {
                  micWidth = 50;
                  micHeight = 50;
                  micVertical = 4;
                  micHorizontal = 4;
                  showSwipeOptions = false;
                });
                if (!isVerticalActionComplete && !isHorizontalActionComplete) {
                  widget.onLongPressCancel();
                  setState(() {
                    isShowMic =false;
                    isShowTime=false;
                  });
                }
              },

              //This gesture is triggered when the user moves their finger after initiating a long-press on the mic icon.
              // it is used to update the UI based on the movement of the finger, which is used to determine if the recording should be cancelled or locked.
              onLongPressMoveUpdate: (LongPressMoveUpdateDetails longPressData) {
                longPressUpdate(longPressData);
              },

              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: kBlue,
                ),
                width: micWidth,
                height: micHeight,
                child: Icon(
                  isVerticalActionComplete ? Icons.send : Icons.mic,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),

          //this widget will show when user swipe left to show animation remove mic recording
          Positioned(
            left: 10,
            bottom: -10,
            child: Visibility(
              visible: isShowMic,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 10)..translate(
                              _micTranslateRight.value)..translate(
                              _micTranslateLeft.value)..translate(
                              0.0, _micTranslateTop.value)..translate(
                              0.0, _micTranslateDown.value)..translate(
                              0.0, _micInsideTrashTranslateDown.value),
                        child: Transform.rotate(
                          angle: _micRotationFirst.value,
                          child: Transform.rotate(
                            angle: _micRotationSecond.value,
                            child: child,
                          ),
                        ),
                      );
                    },
                    child:  const Icon(
                      Icons.mic,
                      color: Color(0xFFef5552),
                      size: 30,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _trashWithCoverTranslateTop,
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.identity()
                          ..translate(
                              0.0, _trashWithCoverTranslateTop.value)..translate(
                              0.0, _trashWithCoverTranslateDown.value),
                        child: child,
                      );
                    },
                    child: Column(
                      children: [
                        AnimatedBuilder(
                            animation: _trashCoverRotationFirst,
                            builder: (context, child) {
                              return Transform(
                                transform: Matrix4.identity()
                                  ..translate(
                                      _trashCoverTranslateLeft.value)..translate(
                                      _trashCoverTranslateRight.value),
                                child: Transform.rotate(
                                  angle: _trashCoverRotationSecond.value,
                                  child: Transform.rotate(
                                    angle: _trashCoverRotationFirst.value,
                                    child: child,
                                  ),
                                ),
                              );
                            },
                            child: Image.asset(
                              "assets/trash_cover.png",
                              width: 30,
                            )
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 1.5),
                            child: Image.asset(
                              "assets/trash_container.png",
                              width: 30,
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //this widget will show recording timer
          Positioned(
            bottom: 15,
            left: 45,
            child: Visibility(
              visible: isShowTime,
              child: const RecordingTimer(),
            ),
          ),
        ],
      ),
    );
  }

  void longPressUpdate(LongPressMoveUpdateDetails longPressData) {
    //determine the direction of the swipe
    if (longPressData.localPosition.direction > 1) {
      // If the direction is greater than 1, it is considered a horizontal swipe,
      isVerticalScroll = false;
    } else {
      //otherwise it is considered a vertical swipe
      isVerticalScroll = true;
    }

    // handle the swipe data and move the mic position in vertical direction
    if (isVerticalScroll) {
      if (longPressData.localPosition.dy < 0) {
        if (longPressData.localPosition.dy > -100) {
          setState(() {
            micVertical = -longPressData.localPosition.dy;
          });
        } else {
          // reset only once
          // If the vertical movement is less than -100, it triggers a callback function (widget.onVerticalScrollComplete())
          // and resets the position of the microphone to its original state
          if (showSwipeOptions) {
            isVerticalActionComplete = true;
            widget.onVerticalScrollComplete();
            showSwipeOptions = false;
            resetMicPosition();
          }
        }
      } else {
        resetMicPosition();
      }
    }

    // handle the swipe data and move the mic position in horizontal direction
    if (!isVerticalScroll) {
      if (longPressData.localPosition.dx < 0) {
        if (longPressData.localPosition.dx > -150) {
          setState(() {
            micHorizontal = -longPressData.localPosition.dx;
          });
        } else {
          // reset only once
          // If the horizontal movement is less than -150, it triggers a series of actions, including running an animation, updating boolean variables
          // calling a callback function (widget.onHorizontalScrollComplete()), and resetting the position of the microphone
          if (showSwipeOptions) {
            isHorizontalActionComplete = true;
            isShowTime=false;
            _animationController.forward().then((_) {
              _animationController.reset();
              setState(() {
                isShowMic =false;
              });

            });
            widget.onHorizontalScrollComplete();
            showSwipeOptions = false;
            resetMicPosition();
          }
        }
      } else {
        resetMicPosition();
      }
    }

    // reset mic size when the swipe reaches the vertical bounds
    if (longPressData.localPosition.dy < -100 && micHeight != 50) {
      setState(() {
        micWidth = 50;
        micHeight = 50;
      });
    }

    // reset mic size when the swipe reaches the horizontal bounds
    if (longPressData.localPosition.dy < -150 && micWidth != 50) {
      setState(() {
        micWidth = 50;
        micHeight = 50;
      });
    }
  }

  void resetMicPosition() {
    setState(() {
      micHorizontal = 4;
      micVertical = 4;
    });
  }
}
