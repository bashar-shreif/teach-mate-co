import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_svg/svg.dart';

class BottomBar extends StatelessWidget {
  BottomBar({this.onTap, key});
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      initialActiveIndex: 0,
      style: TabStyle.react,
      backgroundColor: Colors.white,
      height: 60 + MediaQuery.of(context).padding.bottom,
      curveSize: 100,
      top: -30,
      color: Color.fromARGB(68, 68, 68, 100),
      items: [
        TabItem(
          icon: SvgPicture.asset('assets/images/tasks.svg'),
          title: 'Tasks',
        ),
        TabItem(
          icon: SvgPicture.asset('assets/images/courses.svg'),
          title: 'Courses',
        ),
        TabItem(
          icon: SvgPicture.asset('assets/images/dashboard.svg'),
          title: 'Dashboard',
        ),
        TabItem(
          icon: SvgPicture.asset('assets/images/instructors.svg'),
          title: 'Instructors',
        ),
        TabItem(icon: SvgPicture.asset('assets/images/me.svg'), title: 'Me'),
      ],
    );
  }
}
