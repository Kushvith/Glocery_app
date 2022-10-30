import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Screens/whislist/Whislist_widget.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/textWidget.dart';

class Whislist extends StatelessWidget {
  const Whislist({Key? key}) : super(key: key);
  static const routeName = '/ProductDetails';
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).Getsize;
    Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(IconlyLight.arrowLeft2,color: color,),
        ),
        title: TextWidget(title: "Whilist",color: color,fontweight: 20,istitle: true,),
        elevation: 0.5,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () async{
                await GlobalVariable.waringDailog(title: "Delete", subtitle: "Are you sure clear whislist", fn: (){}, context: context);
              },
              child: Icon(IconlyLight.delete,color: color,),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (size.width / (size.height / 2.8)),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10, 
          children: List.generate(6, (index) => WhislistWidget()),
        ),
        
      ),
    );
  }
}
