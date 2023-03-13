import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Inner%20Screens/FeedScreen.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/feed_items.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
class EmptyScreen extends StatelessWidget {
   EmptyScreen({Key? key,
     required String this.imagepath,
    required String this.title,
    required String this.subtitle,
    required String this.ButtonText,
     required String this.maintitle
  }) : super(key: key);
  String title,imagepath,subtitle,ButtonText,maintitle;

  @override
  Widget build(BuildContext context) {
    Size size  = Utils(context).Getsize;
    Color color = Utils(context).color;
    final theme = Utils(context).theme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },

            child: Icon(IconlyLight.arrowLeft2,color: color,)),
        title: TextWidget(title: maintitle,color: color,fontweight: 20,),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Image.asset(imagepath,width: double.infinity,height: size.height* 0.4,),
            SizedBox(
              height: 30,
            ),
            TextWidget(
              title: "Whoops",
              color: Colors.cyan,
              fontweight: 24,
              istitle: true,
            ),
            SizedBox(
              height: 20,
            ),
            TextWidget(title: title, color: color, fontweight: 18),
            SizedBox(
              height: 6,
            ),
            TextWidget(title: subtitle, color: color, fontweight: 18),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                side: BorderSide(
                  color: color,
                ),
                primary: Theme.of(context).colorScheme.secondary,

              ),
              onPressed: (){
              GlobalVariable.routeTo(context: context, routeName: FeedScreen.routeName);
            }, child: TextWidget(title: ButtonText,color: color,fontweight: 20,),
            )
          ],
        ),
      ),
    );
  }
}
