import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/services/empty_screen.dart';
import 'package:flutter_proj/widgets/textWidget.dart';

class viewedWidget extends StatefulWidget {
  const viewedWidget({Key? key}) : super(key: key);

  @override
  State<viewedWidget> createState() => _viewedWidgetState();
}

class _viewedWidgetState extends State<viewedWidget> {
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    Size size = Utils(context).Getsize;

    return ListTile(
      title: TextWidget(
        title: "title",
        color: color,
        fontweight: 18,
      ),
      subtitle: TextWidget(
        title:"paid \$ 12",
        color: color ,
          fontweight: 12,
      ),
      leading: FancyShimmerImage(
         imageUrl:   'https://media.istockphoto.com/photos/red-apple-picture-id184276818?k=20&m=184276818&s=612x612&w=0&h=QxOcueqAUVTdiJ7DVoCu-BkNCIuwliPEgtAQhgvBA_g=',
          width: size.width * 0.2,
      ),
      trailing: Material(
        color: Colors.green,
        child: InkWell(
          onTap: (){},
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
                CupertinoIcons.plus,
                color: Colors.white,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
