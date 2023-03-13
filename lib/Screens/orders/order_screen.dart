import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Screens/orders/order_widget.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/textWidget.dart';

import '../../services/empty_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routeName = "/OrderScreen";
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).Getsize;
    Color color = Utils(context).color;
    bool _isempty = true;
    return _isempty?  EmptyScreen(
      title: "empty orders",
      subtitle: "No orders has created",
      ButtonText: "browse products",
      imagepath: "assets/images/history.png",
      maintitle: "orders",
    ) : Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(IconlyLight.arrowLeft2,color: color,),

        ),
        title: TextWidget(title: "Orders",istitle:true,color: color,fontweight: 20,),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (ctx,index){
            return const Padding(
            padding: EdgeInsets.symmetric(vertical: 6,horizontal: 2),
              child: OrderWidget(),
          );
          },
          separatorBuilder: (BuildContext context,int index ){
            return Divider(color: color,);
          },
          itemCount: 10),
    );
  }
}
