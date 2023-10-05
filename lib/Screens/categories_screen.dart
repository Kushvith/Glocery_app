import 'package:flutter/material.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/Category_widget.dart';
import 'package:flutter_proj/widgets/textWidget.dart';

class categoriesScreen extends StatelessWidget {
  categoriesScreen({Key? key}) : super(key: key);
  List<Color> colors = [
    Color(0x35EA0CD4),
    Color(0xA41BDEFF),
    Color(0xA4DE610E),
    Color(0xA413FF0C),
    Color(0xA4D7CE25),
    Color(0xA4B8041F),
  ];
  List<Map<String, dynamic>> CatInfo = [
    {"CatNam": "fruits", "Path": "assets/images/cat/fruits.png"},
    {"CatNam": "Vegetables", "Path": "assets/images/cat/veg.png"},
    {"CatNam": "Herbs", "Path": "assets/images/cat/Spinach.png"},
    {"CatNam": "Species", "Path": "assets/images/cat/spices.png"},
    {"CatNam": "Grains", "Path": "assets/images/cat/grains.png"},
    {"CatNam": "Nuts", "Path": "assets/images/cat/nuts.png"}
  ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: TextWidget(
          title: "Category",
          fontweight: 29,
          color: color,
          istitle: true,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Center(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (w / (h / 1.8)),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: List.generate(6, (index) {
                return CategoryWidget(
                  catname: CatInfo[index]['CatNam'],
                  passedColor: colors[index],
                  path: CatInfo[index]['Path'],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
