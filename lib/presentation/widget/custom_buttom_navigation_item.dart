
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/styles/style.dart';
import '../bloc/main_page/page_cubit.dart';


class CustomBottomNavigationItem extends StatelessWidget {
  final int index;
  final IconData icons;
  final String text;

  const CustomBottomNavigationItem({
    Key? key,
    required this.index,
    required this.icons, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PageCubit>().setPage(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icons,
            size: 24,
            color: context.read<PageCubit>().state == index
                ? kBlueDark
                : kGreyColor,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: context.read<PageCubit>().state == index
                ? TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: kBlueLight)
                : const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}