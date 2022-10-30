import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/textWidget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routeName = "/OrderScreen";
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).Getsize;
    Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leading: InkWell(
          onTap: (){},
          child: Icon(IconlyLight.arrowLeft2,color: color,),

        ),
        title: TextWidget(title: "Orders",istitle:true,color: color,fontweight: 20,),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
    );
  }
}
