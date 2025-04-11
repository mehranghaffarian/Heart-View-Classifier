import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hvc_app/src/helper/dl_model_model.dart';
import 'package:hvc_app/src/pages/home_page.dart';
import 'package:hvc_app/src/theme/color/light_color.dart';
import 'package:hvc_app/src/theme/theme.dart';
import 'package:hvc_app/src/widgets/decoration_container.dart';

class SavedPage extends StatelessWidget {
  const SavedPage() : super();

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 120,
          width: width,
          decoration: const BoxDecoration(
            color: LightColor.orange,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: circularContainer(300, LightColor.lightOrange2)),
              Positioned(
                  top: -60,
                  left: -65,
                  child: circularContainer(width * .5, LightColor.darkOrange)),
              Positioned(
                  top: -230,
                  right: -30,
                  child: circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 50,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        children: const <Widget>[
                          Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.white,
                            size: 40,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Saved Models",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ))),
            ],
          )),
    );
  }

  Widget _categoryRow(BuildContext context, String title) {
    return SizedBox(
      // margin: EdgeInsets.symmetric(horizontal: 20),
      height: 68,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: const TextStyle(
                  color: LightColor.extraDarkPurple,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  const SizedBox(width: 20),
                  _chip("Data Scientist", LightColor.yellow, height: 5),
                  const SizedBox(width: 10),
                  _chip("Data Analyst", LightColor.seeBlue, height: 5),
                  const SizedBox(width: 10),
                  _chip("Data Engineer", LightColor.orange, height: 5),
                  const SizedBox(width: 10),
                  _chip("Data Scientist", LightColor.lightBlue, height: 5),
                ],
              )),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _courseList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: ModelsList.list.asMap().entries.expand((entry) {
          int i = entry.key;
          var e = entry.value;
          return [
            _courseInfo(context, e, decorationContainer(),
                background: LightColor.getRandomColor()),
            if (i != ModelsList.list.length - 1)
              const Divider(thickness: 1, endIndent: 20, indent: 20),
          ];
        }).toList(),
        /*<Widget>[
          _courseInfo(
            context,
            ModelsList.list[0],
            _decorationContainerA(Colors.redAccent, -110, -85),
            background: LightColor.seeBlue,
          ),
          const Divider(
            thickness: 1,
            endIndent: 20,
            indent: 20,
          ),
          _courseInfo(
            context,
            ModelsList.list[1],
            _decorationContainerB(),
            background: LightColor.darkOrange,
          ),
          const Divider(
            thickness: 1,
            endIndent: 20,
            indent: 20,
          ),
          _courseInfo(
            context,
            ModelsList.list[2],
            _decorationContainerC(),
            background: LightColor.lightOrange2,
          ),
        ],*/
      ),
    );
  }

  Widget _card(BuildContext context,
      {Color primaryColor = Colors.redAccent, required Widget backWidget}) {
    return Container(
      height: 190,
      width: MediaQuery.of(context).size.width * .34,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5), blurRadius: 10, color: Color(0x12000000))
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: backWidget,
      ),
    );
  }

  Widget _courseInfo(
      BuildContext context, DLModelModel model, Widget decoration,
      {required Color background}) {
    return SizedBox(
        height: 170,
        width: MediaQuery.of(context).size.width - 20,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .7,
              child: _card(context,
                  primaryColor: background, backWidget: decoration),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 15),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Text(model.name,
                          style: const TextStyle(
                              color: LightColor.purple,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    const CircleAvatar(
                      radius: 3,
                      backgroundColor: LightColor.darkseeBlue,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("${model.accuracy}%",
                        style: const TextStyle(
                          color: LightColor.grey,
                          fontSize: 14,
                        )),
                    const SizedBox(width: 10)
                  ],
                ),
                Text(model.inputSize,
                    style: AppTheme.h6Style.copyWith(
                      fontSize: 12,
                      color: LightColor.grey,
                    )),
                const SizedBox(height: 15),
                Text(model.summary,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: AppTheme.h6Style.copyWith(
                        fontSize: 12, color: LightColor.extraDarkPurple)),
                const SizedBox(height: 15),
                // Row(
                //   children: <Widget>[
                //     _chip(model.tag1, LightColor.darkOrange, height: 5),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     _chip(model.tag2, LightColor.seeBlue, height: 5),
                //   ],
                // )
              ],
            ))
          ],
        ));
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }

  Positioned _smallContainer(Color primaryColor, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primaryColor.withAlpha(255),
        ));
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(
        //  backgroundColor: Colors.blue,
        icon: Icon(icon),
        label: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: LightColor.background,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: LightColor.purple,
        unselectedItemColor: Colors.grey.shade300,
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        items: [
          _bottomIcons(Icons.home),
          _bottomIcons(Icons.star_border),
          _bottomIcons(Icons.add_box_rounded),
        ],
        onTap: (index) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _header(context),
            const SizedBox(height: 20),
            // _categoryRow(context, "Start a new career"),
            _courseList(context)
          ],
        ),
      ),
    );
  }
}
