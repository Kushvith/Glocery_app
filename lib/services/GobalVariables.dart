import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/widgets/textWidget.dart';

class GlobalVariable{
  static routeTo({required BuildContext context,required String routeName}){
    Navigator.pushNamed(context, routeName);
  }

  static  Future<void> waringDailog({required String title,required String subtitle,required Function fn,required BuildContext context}) async {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  "assets/images/warning-sign.png",
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(title)
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) Navigator.pop(context);
                  },
                  child: TextWidget(
                    title: "cancel",
                    color: Colors.cyan,
                    fontweight: 15,
                  )),
              TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    title: "Ok",
                    color: Colors.red,
                    fontweight: 15,
                  ))
            ],
          ));
    }


}