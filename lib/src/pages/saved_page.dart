import 'package:flutter/material.dart';
import 'package:hvc_app/src/helper/dl_model.dart';
import 'package:hvc_app/src/helper/models_database_helper.dart';
import 'package:hvc_app/src/pages/home_page.dart';
import 'package:hvc_app/src/pages/model_detail_page.dart';
import 'package:hvc_app/src/theme/color/light_color.dart';
import 'package:hvc_app/src/theme/theme.dart';
import 'package:hvc_app/src/widgets/bottom_navigation_bar.dart';
import 'package:hvc_app/src/widgets/decoration_container.dart';
import 'package:hvc_app/src/widgets/header.dart';

class SavedPage extends StatefulWidget {
  const SavedPage() : super();

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  late List<DLModel> _savedModels = [];

  @override
  void initState() {
    _fetchModels();
    super.initState();
  }

  Widget _modelList(BuildContext context) {
    return _savedModels.isEmpty
        ? const Text(
            "There is no model",
            style: TextStyle(
                color: LightColor.titleTextColor, fontWeight: FontWeight.bold),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _savedModels.asMap().entries.expand((entry) {
                int i = entry.key;
                var e = entry.value;
                return [
                  InkWell(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModelDetailPage(model: e))),
                    child: _modelCard(context, e, decorationContainer(),
                        background: LightColor.getRandomColor()),
                  ),
                  if (i != _savedModels.length - 1)
                    const Divider(thickness: 1, endIndent: 20, indent: 20),
                ];
              }).toList(),
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

  Widget _modelCard(BuildContext context, DLModel model, Widget decoration,
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
                    IconButton(
                      icon: Icon(
                        model.isSaved ? Icons.favorite : Icons.favorite_border,
                        color: model.isSaved ? Colors.red : Colors.grey,
                      ),
                      onPressed: () async {
                        model.isSaved = !model.isSaved;
                        await ModelsDatabaseHelper.instance.update(model);
                        setState(() {
                          _savedModels.remove(model);
                        });
                      },
                    ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(
        context,
        LightColor.orange, 1,
        (index) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            header(
              context,
              120,
              LightColor.orange,
              LightColor.lightOrange2,
              LightColor.darkOrange,
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Saved Models",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _modelList(context)
          ],
        ),
      ),
    );
  }

  void _fetchModels() async {
    _savedModels = await ModelsDatabaseHelper.instance.querySavedModels();
    setState(() {});
  }
}
