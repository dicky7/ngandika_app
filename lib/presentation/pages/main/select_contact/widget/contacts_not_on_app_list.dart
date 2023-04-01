import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:ngandika_app/presentation/bloc/select_contact/getContactsNotOnApp/get_contacts_not_on_app_cubit.dart';
import 'package:ngandika_app/utils/extensions/extenstions.dart';

import '../../../../../utils/styles/style.dart';
import '../../../../widget/custom_list_tile.dart';

class ContactsNotOnAppList extends StatelessWidget {

  ContactsNotOnAppList({Key? key}) : super(key: key);
  final int _itemsPerPage = 15;
  int _currentPage = 1;
  List<Contact> _contactsToDisplay = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<GetContactsNotOnAppCubit>().getContactsNotOnApp(),
      builder: (context, snapshot) {
        return BlocBuilder<GetContactsNotOnAppCubit, GetContactsNotOnAppState>(
          builder: (context, state) {
            if (state is GetContactsNotOnAppLoading) {
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is GetContactsNotOnAppSuccess) {
              final contactsNotOnApp = state.contactsNotOnApp;
              final startIndex = (_currentPage - 1) * _itemsPerPage;
              final endIndex = min(startIndex + _itemsPerPage, contactsNotOnApp.length);
              _contactsToDisplay.addAll(contactsNotOnApp.sublist(startIndex, endIndex));

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
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
                        child: Text(
                          "Invite",
                          style: context.bodyLarge?.copyWith(
                            color: kBlueLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: _contactsToDisplay.length,
                ),
              );
            } else {
              debugPrint("$state");
              return const SliverFillRemaining(
                child: SizedBox(),
              );
            }
          },
        );
      },
    );
  }
}
