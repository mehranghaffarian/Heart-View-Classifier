import 'package:flutter/material.dart';

Widget header(
  BuildContext context,
  double? containerHeight,
  Color mainColor,
  Color firstCircularContainerColor,
  Color secondCircularContainerColor,
  Widget mainWidget,
) {
  var width = MediaQuery.of(context).size.width;
  return ClipRRect(
    borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
    child: Container(
        height: containerHeight,
        width: width,
        decoration: BoxDecoration(
          color: mainColor,
        ),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                top: 30,
                right: -100,
                child: _circularContainer(300, firstCircularContainerColor)),
            Positioned(
                top: -100,
                left: -45,
                child: _circularContainer(
                    width * .5, secondCircularContainerColor)),
            Positioned(
                top: -180,
                right: -30,
                child: _circularContainer(width * .7, Colors.transparent,
                    borderColor: Colors.white38)),
            Positioned(
              top: 40,
              left: 0,
              child: Container(
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: mainWidget,
              ),
            )
          ],
        )),
  );
}

Widget _circularContainer(double height, Color color,
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
