// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_contacts/contact.dart';
// import 'package:ngandika_app/presentation/bloc/select_contact/getAllContact/get_all_contacts_state.dart';
// import 'package:ngandika_app/presentation/bloc/select_contact/getContactsNotOnApp/get_contacts_not_on_app_cubit.dart';
// import 'package:ngandika_app/presentation/bloc/select_contact/getContactsOnApp/get_contacts_on_app_cubit.dart';
// import 'package:ngandika_app/presentation/pages/main/select_contact/widget/select_contact_app_bar.dart';
// import 'package:ngandika_app/utils/extensions/extenstions.dart';
// import 'package:ngandika_app/utils/styles/style.dart';
//
// import '../../../bloc/select_contact/getAllContact/get_all_contacts_cubit.dart';
// import '../../../widget/custom_list_tile.dart';
//
// class ExampleSelectContactScrollPagination extends StatefulWidget {
//   static const routeName = "select-contact";
//
//   const ExampleSelectContactScrollPagination({Key? key}) : super(key: key);
//
//   @override
//   State<ExampleSelectContactScrollPagination> createState() => _ExampleSelectContactScrollPaginationState();
// }
//
// class _ExampleSelectContactScrollPaginationState extends State<ExampleSelectContactScrollPagination> {
//   final int _itemsPerPage = 15;
//   int _currentPage = 1;
//   List<Contact> _contactsToDisplay = [];
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<GetAllContactsCubit>().getAllContacts();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (context) {
//         context.read<GetAllContactsCubit>().getAllContacts();
//         return BlocBuilder<GetAllContactsCubit, GetAllContactsState>(
//           builder: (context, state) {
//             return Scaffold(
//               appBar: SelectContactAppBar(
//                 numOfContacts: context.watch<GetContactsOnAppCubit>().totalContacts,
//               ),
//               body: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 12),
//                     child: Text("Invite to Join Ngandika"),
//                   ),
//                   Expanded(
//                     child: StreamBuilder(
//                       stream: context.read<GetContactsNotOnAppCubit>().getContactsNotOnApp(),
//                       builder: (context, snapshot) {
//                         return BlocBuilder<GetContactsNotOnAppCubit, GetContactsNotOnAppState>(
//                           builder: (context, state) {
//                             if (state is GetContactsNotOnAppLoading) {
//                               return const Center(child: CircularProgressIndicator());
//                             } else if (state is GetContactsNotOnAppSuccess) {
//                               final contactsNotOnApp = state.contactsNotOnApp;
//                               final startIndex = (_currentPage - 1) * _itemsPerPage;
//                               final endIndex = min(startIndex + _itemsPerPage, contactsNotOnApp.length);
//                               _contactsToDisplay.addAll(contactsNotOnApp.sublist(startIndex, endIndex));
//
//                               return NotificationListener<ScrollNotification>(
//                                 onNotification: (ScrollNotification notification) {
//                                   if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
//                                     if ((_currentPage * _itemsPerPage) < contactsNotOnApp.length) {
//                                       setState(() {
//                                         _currentPage++;
//                                       });
//                                     }
//                                   }
//                                   return true;
//                                 },
//                                 child: ListView.builder(
//                                   shrinkWrap: true,
//                                   itemCount: _contactsToDisplay.length,
//                                   itemBuilder: (context, index) {
//                                     final contact = _contactsToDisplay[index];
//                                     return CustomListTile(
//                                       onTap: () {},
//                                       leading: CircleAvatar(
//                                         backgroundColor: kGreyColor,
//                                         child: Icon(
//                                           Icons.person_2_rounded,
//                                           color: kPrimaryColor,
//                                           size: 28,
//                                         ),
//                                       ),
//                                       title: contact.displayName,
//                                       titleButton: TextButton(
//                                           onPressed: () {},
//                                           child: Text("Invite",
//                                               style: context.bodyLarge?.copyWith(
//                                                   color: kBlueLight,
//                                                   fontWeight: FontWeight.bold))),
//                                     );
//                                   },
//                                 ),
//                               );
//                             } else {
//                               debugPrint("$state");
//                               return SizedBox();
//                             }
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
//
