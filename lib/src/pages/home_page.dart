import 'package:flutter/material.dart';
import 'package:hvc_app/src/helper/dl_model.dart';
import 'package:hvc_app/src/helper/models_database_helper.dart';
import 'package:hvc_app/src/pages/model_detail_page.dart';
import 'package:hvc_app/src/pages/saved_page.dart';
import 'package:hvc_app/src/theme/color/light_color.dart';
import 'package:hvc_app/src/widgets/bottom_navigation_bar.dart';
import 'package:hvc_app/src/widgets/decoration_container.dart';
import 'package:hvc_app/src/widgets/header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  List<DLModel> _allModels = [];
  List<DLModel> _filteredModels = [];

  @override
  void initState() {
    _searchController.addListener(() {
      filterModels(_searchController.text);
    });
    _fetchModels();
    super.initState();
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
      child: _filteredModels.isEmpty
          ? const Text(
              "There is no model",
              style: TextStyle(
                  color: LightColor.titleTextColor,
                  fontWeight: FontWeight.bold),
            )
          : GridView(
              // scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 10, // Space between columns
                mainAxisSpacing: 10, // Space between rows
                childAspectRatio: 0.8, // Width / Height ratio of each item
              ),
              children: <Widget>[
                ..._filteredModels.map(
                  (e) => InkWell(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModelDetailPage(model: e),),),
                    child: _card(
                      context,
                      dlModel: e,
                      backWidget: decorationContainer(),
                      chipColor: LightColor.getRandomColor(),
                      isPrimaryCard: true,
                      primary: LightColor.getRandomColor(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _card(BuildContext context,
      {required Color primary,
      required DLModel dlModel,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dlModel.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          dlModel.isSaved
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: dlModel.isSaved ? Colors.red : Colors.grey,
                        ),
                        onPressed: () async {
                          dlModel.isSaved = !dlModel.isSaved;
                          await ModelsDatabaseHelper.instance.update(dlModel);
                          setState(() {}); // Update UI
                        },
                      ),
                    ],
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

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), label: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          bottomNavigationBar(context, LightColor.purple, 0, (index) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SavedPage()));
      }),
      body: Column(
        children: <Widget>[
          header(
            context,
            175,
            LightColor.purple,
            LightColor.lightpurple,
            LightColor.darkpurple,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Search models",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    )
                  ],
                ),
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
            ),
          ),
          const SizedBox(height: 20),
          _categoryRow(
              "Deep Learning Models", LightColor.orange, LightColor.orange),
          _featuredRowA(context),
        ],
      ),
    );
  }

  void _fetchModels() async {
    _allModels = await ModelsDatabaseHelper.instance.queryAllRows();
    _filteredModels = _allModels;
    setState(() {});
  }
}
