import 'package:flutter/material.dart';
import 'package:hvc_app/src/helper/quad_clipper.dart';
import 'package:hvc_app/src/pages/saved_page.dart';
import 'package:hvc_app/src/theme/color/light_color.dart';

class HomePage extends StatelessWidget {
  const HomePage() : super();

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 200,
          width: width,
          decoration: const BoxDecoration(
            color: LightColor.purple,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 30,
                  right: -100,
                  child: _circularContainer(300, LightColor.lightpurple)),
              Positioned(
                  top: -100,
                  left: -45,
                  child: _circularContainer(width * .5, LightColor.darkpurple)),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // const Icon(
                          //   Icons.keyboard_arrow_left,
                          //   color: Colors.white,
                          //   size: 40,
                          // ),
                          // const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              Text(
                                "Search models",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Type Something...",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )))
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

  Widget _categoryRow(
    String title,
    Color primary,
    Color textColor,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                color: LightColor.titleTextColor, fontWeight: FontWeight.bold),
          ),
          // _chip("See all", primary)
        ],
      ),
    );
  }

  Widget _featuredRowA(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _card(context,
              primary: LightColor.orange,
              backWidget:
                  _decorationContainerA(LightColor.lightOrange, 50, -30),
              chipColor: LightColor.orange,
              chipText1: "Find the right degree for you",
              chipText2: "8 Courses",
              isPrimaryCard: true,
              imgPath:
                  // "https://d1mo3tzxttab3n.cloudfront.net/static/img/shop/560x580/vint0080.jpg"),
                  "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
          _card(context,
              primary: Colors.white,
              chipColor: LightColor.seeBlue,
              backWidget: _decorationContainerB(Colors.white, 90, -40),
              chipText1: "Become a data scientist",
              chipText2: "8 Cources",
              imgPath:
                  // "https://hips.hearstapps.com/esquireuk.cdnds.net/16/39/980x980/square-1475143834-david-gandy.jpg?resize=480:*"
                  "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"
          ),
          _card(context,
              primary: Colors.white,
              chipColor: LightColor.lightOrange,
              backWidget: _decorationContainerC(Colors.white, 50, -30),
              chipText1: "Become a digital marketer",
              chipText2: "8 Cources",
              imgPath:
                  "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg",
          ),
          _card(context,
              primary: Colors.white,
              chipColor: LightColor.seeBlue,
              backWidget: _decorationContainerD(LightColor.seeBlue, -50, 30,
                  secondary: LightColor.lightseeBlue,
                  secondaryAccent: LightColor.darkseeBlue),
              chipText1: "Become a machine learner",
              chipText2: "8 Cources",
              imgPath:
                  // "https://d1mo3tzxttab3n.cloudfront.net/static/img/shop/560x580/vint0080.jpg"),
                  "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
        ],
      ),
    );
  }

  Widget _featuredRowB(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          _card(context,
              primary: LightColor.seeBlue,
              chipColor: LightColor.seeBlue,
              backWidget: _decorationContainerD(
                  LightColor.darkseeBlue, -100, -65,
                  secondary: LightColor.lightseeBlue,
                  secondaryAccent: LightColor.seeBlue),
              chipText1: "English for career development ",
              chipText2: "8 Cources",
              isPrimaryCard: true,
              imgPath:
                  // "https://www.reiss.com/media/product/946/218/silk-paisley-printed-pocket-square-mens-morocco-in-pink-red-20.jpg?format=jpeg&auto=webp&quality=85&width=1200&height=1200&fit=bounds"),
                  "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
          _card(context,
              primary: Colors.white,
              chipColor: LightColor.lightpurple,
              backWidget: _decorationContainerE(
                LightColor.lightpurple,
                90,
                -40,
                secondary: LightColor.lightseeBlue,
              ),
              chipText1: "Bussiness foundation",
              chipText2: "8 Cources",
              imgPath:
                  // "https://i.dailymail.co.uk/i/pix/2016/08/05/19/36E9139400000578-3725856-image-a-58_1470422921868.jpg"),
                  "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
          _card(context,
              primary: Colors.white,
              chipColor: LightColor.lightOrange,
              backWidget: _decorationContainerF(
                  LightColor.lightOrange, LightColor.orange, 50, -30),
              chipText1: "Excel skill for business",
              chipText2: "8 Cources",
              imgPath:
                  // "https://www.reiss.com/media/product/945/066/03-2.jpg?format=jpeg&auto=webp&quality=85&width=632&height=725&fit=bounds"),
                  "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
          _card(context,
              primary: Colors.white,
              chipColor: LightColor.seeBlue,
              backWidget: _decorationContainerA(
                Colors.white,
                -50,
                30,
              ),
              chipText1: "Beacame a data analyst",
              chipText2: "8 Cources",
              imgPath:
                  // "https://d1mo3tzxttab3n.cloudfront.net/static/img/shop/560x580/vint0080.jpg"),
                  "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
        ],
      ),
    );
  }

  Widget _card(BuildContext context,
      {Color primary = Colors.redAccent,
      required String imgPath,
      String chipText1 = '',
      String chipText2 = '',
      required Widget backWidget,
      Color chipColor = LightColor.orange,
      bool isPrimaryCard = false}) {
    final width = MediaQuery.of(context).size.width;
    ;
    return Container(
        height: isPrimaryCard ? 190 : 180,
        width: isPrimaryCard ? width * .32 : width * .32,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: primary.withAlpha(200),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                  color: LightColor.lightpurple.withAlpha(20))
            ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Stack(
            children: <Widget>[
              backWidget,
              Positioned(
                  top: 20,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: NetworkImage(imgPath),
                  )),
              Positioned(
                bottom: 10,
                left: 10,
                child: _cardInfo(context, chipText1, chipText2,
                    LightColor.titleTextColor, chipColor,
                    isPrimaryCard: isPrimaryCard),
              )
            ],
          ),
        ));
  }

  Widget _cardInfo(BuildContext context, String title, String courses,
      Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 10),
            width: MediaQuery.of(context).size.width * .32,
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isPrimaryCard ? Colors.white : textColor,
              ),
            ),
          ),
          const SizedBox(height: 5),
          _chip(courses, primary, height: 5, isPrimaryCard: isPrimaryCard)
        ],
      ),
    );
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

  Widget _decorationContainerA(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: primary.withAlpha(255),
          ),
        ),
        _smallContainer(primary, 20, 40),
        Positioned(
          top: 20,
          right: -30,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerB(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          right: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue.shade100,
            child: CircleAvatar(radius: 30, backgroundColor: primary),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: const CircleAvatar(
                    backgroundColor: LightColor.lightseeBlue, radius: 40)))
      ],
    );
  }

  Widget _decorationContainerC(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.orange.withAlpha(100),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: const CircleAvatar(
                    backgroundColor: LightColor.orange, radius: 40))),
        _smallContainer(
          LightColor.yellow,
          35,
          70,
        )
      ],
    );
  }

  Widget _decorationContainerD(Color primary, double top, double left,
      {required Color secondary, required Color secondaryAccent}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: secondary,
          ),
        ),
        _smallContainer(LightColor.yellow, 18, 35, radius: 12),
        Positioned(
          top: 130,
          left: -50,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: primary,
            child: CircleAvatar(radius: 50, backgroundColor: secondaryAccent),
          ),
        ),
        Positioned(
          top: -30,
          right: -40,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerE(Color primary, double top, double left,
      {required Color secondary}) {
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
                child: CircleAvatar(backgroundColor: secondary, radius: 50))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  Widget _decorationContainerF(
      Color primary, Color secondary, double top, double left) {
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
                    backgroundColor: secondary.withAlpha(100), radius: 40))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  Positioned _smallContainer(Color primary, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primary.withAlpha(255),
        ));
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), label: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: LightColor.purple,
        unselectedItemColor: Colors.grey.shade300,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: 0,
        items: [
          _bottomIcons(Icons.home),
          _bottomIcons(Icons.star_border),
          _bottomIcons(Icons.add_box_rounded),
        ],
        onTap: (index) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SavedPage(),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _header(context),
            const SizedBox(height: 20),
            _categoryRow("Deep Learning Models", LightColor.orange, LightColor.orange),
            _featuredRowA(context),
            const SizedBox(height: 0),
            _categoryRow(
                "Recently Used Models", LightColor.purple, LightColor.darkpurple),
            _featuredRowB(context)
          ],
        ),
      ),
    );
  }
}
