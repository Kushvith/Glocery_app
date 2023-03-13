import 'package:flutter/material.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
class Googlebtn extends StatelessWidget {
  const Googlebtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              color: Colors.white,
              child: Image.asset("assets/images/google.png",width: 40,)),
          SizedBox(width: 15,),
          TextWidget(title: "Sign with google", color: Colors.white, fontweight: 18)
        ],
      ),
    );
  }
}
