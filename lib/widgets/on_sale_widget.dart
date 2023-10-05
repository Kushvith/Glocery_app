import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Inner%20Screens/product_details.dart';
import 'package:flutter_proj/Providers/cartProvider.dart';
import 'package:flutter_proj/Screens/auth/login_page.dart';
import 'package:flutter_proj/models/productModel.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/priceWidget.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:provider/provider.dart';

import '../consts/firebaseconnection.dart';
import 'Heart_btn.dart';
class OnSaleWidget extends StatelessWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    Size size = Utils(context).Getsize;
    final productModel = Provider.of<ProductModel>(context);
    final cartprovier = Provider.of<cartProvider>(context);
    final isInCart = cartprovier.getCartItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, ProductDetails.routeName,arguments: productModel.id);
            // GlobalVariable.routeTo(context: context, routeName: ProductDetails.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                        FancyShimmerImage(
                          imageUrl: productModel.imageUrl,
                          height: size.height *0.14,width: size.width*0.16,boxFit: BoxFit.fill,
                        ),

                    Container(
                      margin: EdgeInsets.only(left: 4),
                      child: Column(

                        children: [
                          SizedBox(height: 10,),

                               TextWidget(title: productModel.isPiece? "1 Pc":"1 KG", color: Colors.green, fontweight: 18,istitle: true,),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              GestureDetector(
                                onTap:isInCart? null: (){
                                  final User? user = authInstance!.currentUser;
                                  if(user == null){
                                    GlobalVariable.waringDailog(title: "Auth Error", subtitle: "Login to add to cart", fn: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));}, context: context);
                                    return;
                                  }
                                  else {
                                    cartprovier.addProductToList(
                                        productId: productModel.id,
                                        quantity: 1);
                                  }},

                                child: Icon(isInCart ? IconlyBold.bag2:IconlyLight.bag2,size: 22,color:isInCart ? Colors.green:color ,),

                              ),
                              SizedBox(width: 5,),
                              HeartBTN(productId: productModel.id,)
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 7,),
                PriceWidget(
                  isOnSale: true,
                  salePrice:productModel.salePrice,
                  sale: productModel.price ,
                  textPrice: "1",
                ),
                SizedBox(height: 2,),
                TextWidget(title: productModel.title, color: color, fontweight: 16)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
