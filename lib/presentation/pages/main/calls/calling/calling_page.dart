import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngandika_app/config/agora_config.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:ngandika_app/data/models/call_model.dart';
import 'package:ngandika_app/presentation/bloc/call/call_cubit.dart';
import 'package:ngandika_app/presentation/widget/custom_loading.dart';

class CallingPage extends StatefulWidget {
  static const routeName = 'call-pickup';

  final String channelId;
  final CallModel call;
  final bool isGroupChat;

  const CallingPage(
      {Key? key,
      required this.channelId,
      required this.call,
      required this.isGroupChat})
      : super(key: key);

  @override
  State<CallingPage> createState() => _CallingPageState();
}

class _CallingPageState extends State<CallingPage> {
  AgoraClient? client;
  String baseUrl = 'https://whatsapp-clone-rrr.herokuapp.com';

  @override
  void initState() {
    super.initState();
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channelId,
        tokenUrl: baseUrl,
      ),
    );
    initAgora();
  }

  void initAgora() async {
    await client!.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client == null
          ? const CustomLoading()
          : SafeArea(
              child: Stack(
                children: [
                  AgoraVideoViewer(client: client!),
                  AgoraVideoButtons(
                    client: client!,
                    disconnectButtonChild: IconButton(
                      onPressed: () async {
                        await client!.engine.leaveChannel();
                        context.read<CallCubit>().endCall(
                            callerId: widget.call.callId,
                            receiverId: widget.call.receiverId,
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.call_end),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
