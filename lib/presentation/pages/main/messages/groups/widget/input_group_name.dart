import 'package:flutter/material.dart';

class InputGroupName extends StatelessWidget {
  const InputGroupName({
    super.key,
    required this.nameController,
  });

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorHeight: 30,
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Enter group name here",
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
