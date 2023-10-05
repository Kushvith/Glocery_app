import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Providers/cartProvider.dart';
import 'package:flutter_proj/Screens/cart/cartWidget.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/services/empty_screen.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).Getsize;
    Color color = Utils(context).color;
    final cartprovider = Provider.of<cartProvider>(context);
    final cartValues = cartprovider.getCartItems.values.toList().reversed.toList();

    return cartValues.isEmpty  ? EmptyScreen(imagepath: "assets/images/cart.png", title: "empty cart", subtitle: "Add items to cart", ButtonText: "browse items", maintitle: "cart"): Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: TextWidget(title: "Cart( ${cartValues.length } )",color: color, fontweight: 20,istitle: true,maxlines: 1,),
        actions: [
          Padding(padding: EdgeInsets.only(right: 15),
          child:  InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () async{
              await GlobalVariable.waringDailog(title: "Delete", subtitle: "Are you sure clear Cart", fn: (){
                cartprovider.clearCart();

              }, context: context);

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
                    itemCount: cartValues.length,
                    itemBuilder: (context,index)=> ChangeNotifierProvider.value(
                        value: cartValues[index],
                        child: cartWidget(q: cartValues[index].quantity,)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
