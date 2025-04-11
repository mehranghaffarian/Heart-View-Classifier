import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hvc_app/src/helper/quad_clipper.dart';
import 'package:hvc_app/src/theme/color/light_color.dart';

Widget decorationContainer() {
  final random = Random();
  final Color randomColor = LightColor.getRandomColor();
  int index = random.nextInt(5);

  switch (index) {
    case 0:
      return _decorationContainerA(randomColor, random.nextDouble() * 80, random.nextDouble() * 50);
    case 1:
      return _decorationContainerB(randomColor);
    case 2:
    return _decorationContainerC(randomColor);
    case 3:
    return decorationContainerD(randomColor);
    case 4:
    return _decorationContainerE(randomColor);
    case 5:
    default:
    return _decorationContainerF(randomColor);
  }
}

Widget _decorationContainerA(Color primaryColor, double top, double left) {
  return Stack(
    children: <Widget>[
      Positioned(
        top: top,
        left: left,
        child: const CircleAvatar(
          radius: 100,
          backgroundColor: LightColor.darkseeBlue,
        ),
      ),
      smallContainer(primaryColor, 40, 20),
      Positioned(
        top: -30,
        right: -10,
        child: circularContainer(80, Colors.transparent,
            borderColor: Colors.white),
      ),
      const Positioned(
        top: 110,
        right: -50,
        child: CircleAvatar(
          radius: 60,
          backgroundColor: LightColor.darkseeBlue,
          child:
          CircleAvatar(radius: 40, backgroundColor: LightColor.seeBlue),
        ),
      ),
    ],
  );
}

Widget _decorationContainerB(Color color) {
  return Stack(
    children: <Widget>[
      Positioned(
        top: -65,
        left: -65,
        child: CircleAvatar(
          radius: 70,
          backgroundColor: color,
          child: const CircleAvatar(
            radius: 30,
            backgroundColor: LightColor.darkOrange,
          ),
        ),
      ),
      const Positioned(
        bottom: -35,
        right: -40,
        child: CircleAvatar(backgroundColor: LightColor.yellow, radius: 40),
      ),
      Positioned(
        top: 50,
        left: -40,
        child: circularContainer(70, Colors.transparent, borderColor: Colors.white),
      ),
    ],
  );
}

Widget _decorationContainerC(Color color) {
  return Stack(
    children: <Widget>[
      Positioned(
        bottom: -65,
        left: -35,
        child: CircleAvatar(
          radius: 70,
          backgroundColor: color,
        ),
      ),
      Positioned(
        bottom: -30,
        right: -25,
        child: ClipRect(
          clipper: QuadClipper(),
          child: const CircleAvatar(
            backgroundColor: LightColor.yellow,
            radius: 40,
          ),
        ),
      ),
      smallContainer(
        Colors.yellow,
        35,
        70,
      ),
    ],
  );
}
Widget decorationContainerD(Color primary) {
  return Stack(
    children: <Widget>[
      Positioned(
        top: -50,
        left: 30,
        child: CircleAvatar(
          radius: 100,
          backgroundColor: LightColor.getRandomColor(),
        ),
      ),
      smallContainer(primary, 18, 35, radius: 12),
      Positioned(
        top: 130,
        left: -50,
        child: CircleAvatar(
          radius: 80,
          backgroundColor: primary,
          child: CircleAvatar(radius: 50, backgroundColor: LightColor.getRandomColor()),
        ),
      ),
      Positioned(
        top: -30,
        right: -40,
        child: circularContainer(80, Colors.transparent,
            borderColor: Colors.white),
      )
    ],
  );
}

Widget _decorationContainerE(Color primary,
    ) {
  return Stack(
    children: <Widget>[
      Positioned(
        top: -105,
        left: -35,
        child: CircleAvatar(
          radius: 70,
          backgroundColor: primary.withAlpha(100),
        ),
      ),
      Positioned(
          top: 40,
          right: -25,
          child: ClipRect(
              clipper: QuadClipper(),
              child: CircleAvatar(backgroundColor: primary, radius: 40))),
      Positioned(
          top: 45,
          right: -50,
          child: ClipRect(
              clipper: QuadClipper(),
              child: CircleAvatar(backgroundColor: LightColor.getRandomColor(), radius: 50))),
      smallContainer(primary, 15, 90, radius: 5)
    ],
  );
}

Widget _decorationContainerF(
    Color primary) {
  return Stack(
    children: <Widget>[
      Positioned(
          top: 25,
          right: -20,
          child: RotatedBox(
            quarterTurns: 1,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: primary.withAlpha(100), radius: 50)),
          )),
      Positioned(
          top: 34,
          right: -8,
          child: ClipRect(
              clipper: QuadClipper(),
              child: CircleAvatar(
                  backgroundColor: LightColor.getRandomColor().withAlpha(100), radius: 40))),
      smallContainer(primary, 15, 90, radius: 5)
    ],
  );
}

Positioned smallContainer(Color primary, double top, double left,
    {double radius = 10}) {
  return Positioned(
      top: top,
      left: left,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: primary.withAlpha(255),
      ));
}

Widget circularContainer(double height, Color color,
    {Color borderColor = Colors.transparent, double borderWidth = 2}) {
  return Container(
    height: height,
    width: height,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      border: Border.all(color: borderColor, width: borderWidth),
    ),
  );
}