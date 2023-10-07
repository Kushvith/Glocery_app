import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Providers/orderProvider.dart';
import 'package:flutter_proj/Screens/orders/order_widget.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:provider/provider.dart';

import '../../models/orderModel.dart';
import '../../services/empty_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);
  static const routeName = "/OrderScreen";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  @override
  Widget build(BuildContext context) {

    Size size = Utils(context).Getsize;
    Color color = Utils(context).color;
    final orderprovider = Provider.of<orderProvider>(context,listen: false);
    // final orderList = orderprovider.getProducts;
    return FutureBuilder(
      future: orderprovider.FetchOrders(),
      builder: (context,AsyncSnapshot<List<OrderModel>> snapshot) {
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data != null) {
          List<OrderModel> orderList = snapshot.data ?? [];
          return orderList.isEmpty?  EmptyScreen(
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
              itemCount: orderList.length,
              itemBuilder: (ctx,index){
                return  Padding(
                  padding: EdgeInsets.symmetric(vertical: 6,horizontal: 2),
                  child: ChangeNotifierProvider.value(
                      value: orderList[index],
                      child: OrderWidget()),
                );
              },
              separatorBuilder: (BuildContext context,int index ){
                return Divider(color: color,);
              },),
          );;
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      }
    );
  }
}
