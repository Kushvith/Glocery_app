import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Screens/cart/cartWidget.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).Getsize;
    Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: TextWidget(title: "Cart( 2 )",color: color, fontweight: 20,istitle: true,maxlines: 1,),
        actions: [
          Padding(padding: EdgeInsets.only(right: 15),
          child:  InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () async{
              await GlobalVariable.waringDailog(title: "Delete", subtitle: "Are you sure clear Cart", fn: (){}, context: context);

            },
            child: Icon(IconlyBroken.delete),
          ),
          ),

        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.height *0.1,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.green,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextWidget(color: Colors.white,title: "Order now",fontweight: 18,istitle: true,maxlines: 1,),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FittedBox(
                        child: TextWidget(
                          title: "\$2.59",
                          color: color,
                          fontweight: 20,
                          maxlines: 1,
                          istitle: true,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height*0.7,
                child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context,index)=> cartWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
