import 'package:flutter/material.dart';
import 'package:hvc_app/src/helper/dl_model_model.dart';
import 'package:hvc_app/src/helper/quad_clipper.dart';
import 'package:hvc_app/src/pages/saved_page.dart';
import 'package:hvc_app/src/theme/color/light_color.dart';
import 'package:hvc_app/src/widgets/decoration_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  late List<DLModelModel> _allModels;
  late List<DLModelModel> _filteredModels;

  @override
  void initState() {
    super.initState();
    _allModels = ModelsList.list;
    _filteredModels = _allModels;

    _searchController.addListener(() {
      filterModels(_searchController.text);
    });
  }

  void filterModels(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredModels = _allModels;
      });
    } else {
      final filtered = _allModels.where((model) {
        final nameLower = model.name.toLowerCase();
        final summaryLower = model.summary.toLowerCase();
        final searchLower = query.toLowerCase();
        return nameLower.contains(searchLower) ||
            summaryLower.contains(searchLower);
      }).toList();
      setState(() {
        _filteredModels = filtered;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose(); // Always dispose controllers!
    super.dispose();
  }

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
                          TextField(
                            controller: _searchController,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Type something...',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                            ),
                          ),
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
    return Expanded(
      child: GridView(
        // scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10, // Space between columns
          mainAxisSpacing: 10, // Space between rows
          childAspectRatio: 0.8, // Width / Height ratio of each item
        ),
        children: <Widget>[
          ..._filteredModels.map(
            (e) => _card(
              context,
              dlModel: e,
              backWidget: decorationContainer(),
              chipColor: LightColor.getRandomColor(),
              isPrimaryCard: true,
              primary: LightColor.getRandomColor(),
            ),
          ),
          // _card(
          //   context,
          //   primary: LightColor.orange,
          //   backWidget: _decorationContainerA(LightColor.lightOrange, 50, -30),
          //   chipColor: LightColor.orange,
          //   chipText1: "Find the right degree for you",
          //   chipText2: "8 Courses",
          //   isPrimaryCard: true,
          //   title: 't1',
          // ),
          // _card(
          //   context,
          //   title: 't1',
          //   primary: Colors.white,
          //   chipColor: LightColor.seeBlue,
          //   backWidget: _decorationContainerB(Colors.white, 90, -40),
          //   chipText1: "Become a data scientist",
          //   chipText2: "8 Cources",
          // ),
          // _card(
          //   context,
          //   title: 't1',
          //   primary: Colors.white,
          //   chipColor: LightColor.seeBlue,
          //   backWidget: _decorationContainerB(Colors.white, 90, -40),
          //   chipText1: "Become a data scientist",
          //   chipText2: "8 Cources",
          // ),
          // _card(
          //   context,
          //   title: 't1',
          //   primary: Colors.white,
          //   chipColor: LightColor.seeBlue,
          //   backWidget: _decorationContainerB(Colors.white, 90, -40),
          //   chipText1: "Become a data scientist",
          //   chipText2: "8 Cources",
          // ),
          // _card(
          //   context,
          //   title: 't1',
          //   primary: Colors.white,
          //   chipColor: LightColor.seeBlue,
          //   backWidget: _decorationContainerB(Colors.white, 90, -40),
          //   chipText1: "Become a data scientist",
          //   chipText2: "8 Cources",
          // ),
          // _card(
          //   title: 't1',
          //   context,
          //   primary: Colors.white,
          //   chipColor: LightColor.lightOrange,
          //   backWidget: _decorationContainerC(Colors.white, 50, -30),
          //   chipText1: "Become a digital marketer",
          //   chipText2: "8 Cources",
          // ),
          // _card(
          //   context,
          //   title: 't1',
          //   primary: Colors.white,
          //   chipColor: LightColor.seeBlue,
          //   backWidget: decorationContainerD(LightColor.seeBlue),
          //   chipText1: "Become a machine learner",
          //   chipText2: "8 Cources",
          // ),
        ],
      ),
    );
  }

  // Widget _featuredRowB(BuildContext context) {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: <Widget>[
  //         _card(context,
  //             primary: LightColor.seeBlue,
  //             chipColor: LightColor.seeBlue,
  //             backWidget: _decorationContainerD(
  //                 LightColor.darkseeBlue, -100, -65,
  //                 secondary: LightColor.lightseeBlue,
  //                 secondaryAccent: LightColor.seeBlue),
  //             chipText1: "English for career development ",
  //             chipText2: "8 Cources",
  //             isPrimaryCard: true,
  //             imgPath:
  //                 // "https://www.reiss.com/media/product/946/218/silk-paisley-printed-pocket-square-mens-morocco-in-pink-red-20.jpg?format=jpeg&auto=webp&quality=85&width=1200&height=1200&fit=bounds"),
  //                 "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
  //         _card(context,
  //             primary: Colors.white,
  //             chipColor: LightColor.lightpurple,
  //             backWidget: _decorationContainerE(
  //               LightColor.lightpurple,
  //               90,
  //               -40,
  //               secondary: LightColor.lightseeBlue,
  //             ),
  //             chipText1: "Bussiness foundation",
  //             chipText2: "8 Cources",
  //             imgPath:
  //                 // "https://i.dailymail.co.uk/i/pix/2016/08/05/19/36E9139400000578-3725856-image-a-58_1470422921868.jpg"),
  //                 "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
  //         _card(context,
  //             primary: Colors.white,
  //             chipColor: LightColor.lightOrange,
  //             backWidget: _decorationContainerF(
  //                 LightColor.lightOrange, LightColor.orange, 50, -30),
  //             chipText1: "Excel skill for business",
  //             chipText2: "8 Cources",
  //             imgPath:
  //                 // "https://www.reiss.com/media/product/945/066/03-2.jpg?format=jpeg&auto=webp&quality=85&width=632&height=725&fit=bounds"),
  //                 "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
  //         _card(context,
  //             primary: Colors.white,
  //             chipColor: LightColor.seeBlue,
  //             backWidget: _decorationContainerA(
  //               Colors.white,
  //               -50,
  //               30,
  //             ),
  //             chipText1: "Beacame a data analyst",
  //             chipText2: "8 Cources",
  //             imgPath:
  //                 // "https://d1mo3tzxttab3n.cloudfront.net/static/img/shop/560x580/vint0080.jpg"),
  //                 "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
  //       ],
  //     ),
  //   );
  // }
  Widget _card(BuildContext context,
      {required Color primary,
      required DLModelModel dlModel,
      required Widget backWidget,
      required Color chipColor,
      bool isPrimaryCard = false}) {
    final width = MediaQuery.of(context).size.width;

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
            color: LightColor.lightpurple.withAlpha(20),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Stack(
          children: [
            backWidget,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    dlModel.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  /// Summary (multi-line with ellipsis)
                  Text(
                    dlModel.summary,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),

                  const Spacer(),

                  /// Bottom row with chip + accuracy
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _chip(
                        dlModel.inputSize,
                        LightColor.getRandomColor(),
                        height: 5,
                        isPrimaryCard: isPrimaryCard,
                      ),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 3,
                            backgroundColor: LightColor.darkseeBlue,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${dlModel.accuracy}%",
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                // color: isPrimaryCard ? Colors.white : textColor,
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
        style: const TextStyle(
          // color: isPrimaryCard ? Colors.white : textColor,
          fontSize: 12,
        ),
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
        smallContainer(primary, 20, 40),
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
        smallContainer(
          LightColor.yellow,
          35,
          70,
        )
      ],
    );
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
      body: Column(
        children: <Widget>[
          _header(context),
          const SizedBox(height: 20),
          _categoryRow(
              "Deep Learning Models", LightColor.orange, LightColor.orange),
          _featuredRowA(context),
          // const SizedBox(height: 0),
          // _categoryRow(
          //     "Recently Used Models", LightColor.purple, LightColor.darkpurple),
          // _featuredRowB(context)
        ],
      ),
    );
  }
}
