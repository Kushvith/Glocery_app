import 'package:flutter/material.dart';
class TextWidget extends StatelessWidget {
   TextWidget({Key? key,required this.title,required this.color,required this.fontweight,this.istitle = false, this.maxlines = 10}) : super(key: key);
  final String title;
  final Color color;
  final double fontweight;
  bool istitle = false;
  int maxlines = 10;
  @override
  Widget build(BuildContext context) {

    return Text(title,style: TextStyle(color: color,fontSize: fontweight,fontWeight:istitle? FontWeight.bold: FontWeight.normal),);
  }
}
