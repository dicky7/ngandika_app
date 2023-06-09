import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../../../utils/styles/style.dart';
import '../../../../../widget/custom_button.dart';
import '../../../../../widget/custom_list_tile.dart';

class ContactsNotOnAppList extends StatefulWidget {
  final List<Contact> contactsNotOnApp;

  const ContactsNotOnAppList({Key? key, required this.contactsNotOnApp})
      : super(key: key);

  @override
  _ContactsNotOnAppListState createState() => _ContactsNotOnAppListState();
}

class _ContactsNotOnAppListState extends State<ContactsNotOnAppList> {
  final int _itemsPerPage = 15;
  int _currentPage = 1;
  List<Contact> _contactsToDisplay = [];

  @override
  Widget build(BuildContext context) {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex =
        min(startIndex + _itemsPerPage, widget.contactsNotOnApp.length);
    _contactsToDisplay
        .addAll(widget.contactsNotOnApp.sublist(startIndex, endIndex));

    return ListView.builder(
      shrinkWrap: true,
      itemCount: _contactsToDisplay.length + 1,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (index == _contactsToDisplay.length) {
          return _buildPaginationButtons();
        } else {
          final contact = _contactsToDisplay[index];
          return CustomListTile(
            onTap: () {},
            leading: CircleAvatar(
              backgroundColor: kGreyColor,
              child: Icon(
                Icons.person_2_rounded,
                color: kPrimaryColor,
                size: 28,
              ),
            ),
            title: contact.displayName,
            titleButton: TextButton(
                onPressed: () {},
                child: Text("Invite",
                    style: context.bodyLarge?.copyWith(
                        color: kBlueLight, fontWeight: FontWeight.bold))),
          );
        }
      },
    );
  }

  Widget _buildPaginationButtons() {
    final isFirstPage = _currentPage == 1;
    final isLastPage =
        ((_currentPage * _itemsPerPage) >= widget.contactsNotOnApp.length);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 10),
        isLastPage
            ? const SizedBox()
            : CustomButton(
                onPress: () => _onPageChange(_currentPage + 1),
                text: "Load More",
                color: kBlue,
                width: context.width(0.3))

        // ElevatedButton(
        //   onPressed: isFirstPage ? null : () => _onPageChange(_currentPage - 1),
        //   child: const Icon(Icons.arrow_back_ios_new_rounded),
        // ),
        // const SizedBox(width: 10),
        // Text(
        //   'Page $_currentPage',
        //   style: Theme
        //       .of(context)
        //       .textTheme
        //       .headline6,
        // ),
        // const SizedBox(width: 10),
        // ElevatedButton(
        //   onPressed: isLastPage ? null : () => _onPageChange(_currentPage + 1),
        //   child: const Icon(Icons.arrow_forward_ios_rounded),
        // ),
      ],
    );
  }

  void _onPageChange(int page) {
    setState(() {
      _currentPage = page;
    });

    // un comment this code if you don't want new data bellow old data

    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex =
        min(startIndex + _itemsPerPage, widget.contactsNotOnApp.length);
    final contactsToDisplay =
        widget.contactsNotOnApp.sublist(startIndex, endIndex);

    setState(() {
      _contactsToDisplay.addAll(contactsToDisplay);
    });
  }
}
