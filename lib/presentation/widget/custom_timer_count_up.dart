import 'dart:async';

import 'package:flutter/material.dart';

/// This widget shows the count-up timer
class CustomTimerCountUp extends StatefulWidget {
  final Color colors;
  const CustomTimerCountUp({Key? key, required this.colors}) : super(key: key);

  @override
  State<CustomTimerCountUp> createState() => _CustomTimerCountUpState();
}

class _CustomTimerCountUpState extends State<CustomTimerCountUp> {
  Duration duration = const Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTimer());
  }

  void addTimer() {
    const addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      "$minutes:$seconds",
      style: TextStyle(
        fontSize: 20,
        color: widget.colors,
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
