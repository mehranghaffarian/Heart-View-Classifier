import 'dart:math';

import 'package:flutter/material.dart';

class LightColor {
  static const Color background = Color(0XFFFFFFFF);

  static const Color titleTextColor = Color(0xff5a5d85);
  static const Color subTitleTextColor = Color(0xff797878);

  static const Color bottonTitleTextColor = Color(0xffd4d4ea);

  static const Color grey = Color(0xff9D99A7);
  static const Color darkgrey = Color(0xff625f6a);

  static const Color yellow = Color(0xfffbbd5c);

  static const Color orange = Color(0xfff96d5b);
  static const Color darkOrange = Color(0xfff46352);
  static const Color lightOrange = Color(0xfffa8e5c);
  static const Color lightOrange2 = Color(0xfff97d6d);

  static const Color purple = Color(0xff7a81dd);
  static const Color lightpurple = Color(0xff898edf);
  static const Color darkpurple = Color(0xff7178d3);
  static const Color extraDarkPurple = Color(0xff494c79);

  static const Color seeBlue = Color(0xff73d4dd);
  static const Color darkseeBlue = Color(0xff63c4cf);
  static const Color lightseeBlue = Color(0xffb9e6fc);

  static const Color brighter = Color(0xff3754aa);
  static const Color Darker = Color(0xffffffff);
  static const Color black = Color(0xff040405);
  static const Color lightblack = Color(0xff3E404D);
  static const Color lightGrey = Color(0xffDFE7DD);
  static const Color darkBlue = Color(0xff13165A);
  static const Color lightBlue = Color(0xff203387);

  static const Color green = Color(0xff5abf90);
  static const Color darkGreen = Color(0xff4aa07a);
  static const Color lightGreen = Color(0xff7cd8ac);
  static const Color extraDarkGreen = Color(0xff3a7a5d);

  static const List<Color> colors = [background,
    titleTextColor,
    subTitleTextColor,
    bottonTitleTextColor,
    grey,
    // darkgrey,
    yellow,
    orange,
    darkOrange,
    lightOrange,
    lightOrange2,
    purple,
    lightpurple,
    // darkpurple,
    extraDarkPurple,
    seeBlue,
    // darkseeBlue,
    lightseeBlue,
    brighter,
    Darker,
    // black,
    lightblack,
    lightGrey,
    // darkBlue,
    lightBlue,];

  static Color getRandomColor() {
    final random = Random();
    return colors[random.nextInt(colors.length)];
  }
}
