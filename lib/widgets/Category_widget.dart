import 'package:flutter/material.dart';
import 'package:flutter_proj/Inner%20Screens/cartScreen.dart';
import 'package:flutter_proj/Providers/Theme-provider.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget(
      {Key? key,
      required this.catname,
      required this.path,
      required this.passedColor})
      : super(key: key);
  final String catname, path;
  final Color passedColor;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.width;
    double w = MediaQuery.of(context).size.height;

    final themestate = Provider.of<themeProvider>(context);
    bool state = themestate.getDarktheme;
    Color color = state ? Colors.white : Colors.black;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CatScreen.routeName,arguments: catname);
      },
      child: Container(
        decoration: BoxDecoration(
          color: passedColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: passedColor.withOpacity(0.5), width: 2),
        ),
        child: Column(
          children: [
            Container(
              height: h * 0.3,
              width: h * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(path), fit: BoxFit.fill)),
            ),
            TextWidget(
              title: catname,
              color: color,
              fontweight: 20,
              istitle: true,
            )
          ],
        ),
      ),
    );
  }
}
