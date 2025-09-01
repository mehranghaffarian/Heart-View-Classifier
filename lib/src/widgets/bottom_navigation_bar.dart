import 'package:flutter/material.dart';
import 'package:hvc_app/src/pages/home_page.dart';
import 'package:hvc_app/src/theme/color/light_color.dart';

BottomNavigationBarItem _bottomIcons(IconData icon) {
  return BottomNavigationBarItem(
      //  backgroundColor: Colors.blue,
      icon: Icon(icon),
      label: '');
}

Widget bottomNavigationBar(BuildContext context, Color color, int currentIndex, Function(int)? onPageIconTapped) {
  return BottomNavigationBar(
    backgroundColor: LightColor.background,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: color,
    unselectedItemColor: Colors.grey.shade300,
    type: BottomNavigationBarType.fixed,
    currentIndex: currentIndex,
    items: [
      _bottomIcons(Icons.home),
      _bottomIcons(Icons.star_border),
      _bottomIcons(Icons.account_tree_sharp),
    ],
    onTap: onPageIconTapped,
  );
}
