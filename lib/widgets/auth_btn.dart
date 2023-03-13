import 'package:flutter/material.dart';
class Authbtn extends StatelessWidget {
    Authbtn({Key? key,required String this.buttontext,required Function this.fcn,Color this.primaryColor = Colors.white38}) : super(key: key);
  final String buttontext;
  final Function fcn;
  final Color primaryColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style:ElevatedButton.styleFrom(
            primary: primaryColor,
          ),
          onPressed: (){
        fcn();
      },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
        buttontext,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16,
        ),
      ),
          )),
    );
  }
}
