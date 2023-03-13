import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Screens/viewed/viewed_ordered.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/services/empty_screen.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
class Viewed_screen extends StatelessWidget {
  const Viewed_screen({Key? key}) : super(key: key);
  static const pathname = "/viewed";
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).Getsize;
    bool _isempty = true;
    return _isempty ? EmptyScreen(imagepath: "assets/images/basket.png", title: "empty viewed", subtitle: "No recently viewed items", ButtonText: "browse items", maintitle: "viewed")
        :Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
           IconlyLight.arrowLeft2,
            color: color,
          ),
        ),
        title: TextWidget(title:"viewed",color: color,fontweight: 18,istitle: true,),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (ctx,index){
          return Padding(padding: EdgeInsets.symmetric(horizontal: 2,vertical: 6),
          child: viewedWidget(),
          );
        },
      itemCount: 10,),
    );
  }
}
