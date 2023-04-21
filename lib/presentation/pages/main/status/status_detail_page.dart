import 'package:flutter/material.dart';
import 'package:ngandika_app/data/models/status_model.dart';
import 'package:ngandika_app/presentation/widget/custom_list_tile.dart';
import 'package:ngandika_app/presentation/widget/custom_loading.dart';
import 'package:ngandika_app/utils/extensions/time_extension.dart';
import 'package:ngandika_app/utils/styles/style.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../../widget/custom_network_image.dart';

class StatusDetailPage extends StatefulWidget {
  static const routeName = "status-detail";
  final StatusModel status;
  final String myNumber;

  const StatusDetailPage({Key? key, required this.status, required this.myNumber}) : super(key: key);

  @override
  State<StatusDetailPage> createState() => _StatusDetailPageState();
}

class _StatusDetailPageState extends State<StatusDetailPage> {
  StoryController storyController = StoryController();
  List<StoryItem> storyItems = [];

  @override
  void initState() {
    super.initState();
    initStoryPageItems();
  }

  void initStoryPageItems() {
    for (int i = 0; i < widget.status.photoUrl.length; i++) {
      storyItems.add(StoryItem.pageImage(
        url: widget.status.photoUrl[i],
        caption: widget.status.caption,
        controller: storyController,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: storyItems.isEmpty
          ? const CustomLoading()
          : Stack(
              children: [
                StoryView(
                  storyItems: storyItems,
                  controller: storyController,
                  onComplete: () => Navigator.of(context).pop(),
                  onVerticalSwipeComplete: (direction) {
                    Navigator.pop(context);
                  },
                ),
                _buildProfileView()
              ],
            ),
    );
  }

  Container _buildProfileView() {
    return Container(
        padding: const EdgeInsets.only(
          top: 48,
          left: 16,
          right: 16,
        ),
        child: ListTile(
          leading: CustomNetworkImage(
            imageUrl: widget.status.profilePicture,
            radius: 25,
          ),
          title: Text(
            widget.status.phoneNumber == widget.myNumber
                ? "My Status"
                : widget.status.username,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: kPrimaryColor),
          ),
          subtitle: Text(
            widget.status.createdAt.getStatusTime24HoursMode,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kPrimaryColor),
          ),
        )
    );
  }
}
