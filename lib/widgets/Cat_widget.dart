


import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_proj/Inner%20Screens/product_details.dart';
import 'package:flutter_proj/Providers/whislistProvider.dart';
import 'package:flutter_proj/models/productModel.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/Heart_btn.dart';
import 'package:flutter_proj/widgets/priceWidget.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:provider/provider.dart';

import '../Providers/cartProvider.dart';
import '../Screens/auth/login_page.dart';
import '../consts/firebaseconnection.dart';
class CatWidget extends StatefulWidget {
  const CatWidget({Key? key}) : super(key: key);

  @override
  State<CatWidget> createState() => _CatWidgetState();
}

class _CatWidgetState extends State<CatWidget> {
  TextEditingController Kg_size = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Kg_size.text= '1';
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    Kg_size.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    final cartprovier = Provider.of<cartProvider>(context);
    final isInCart = cartprovier.getCartItems.containsKey(productModel.id);

    Color color = Utils(context).color;
    Size size = Utils(context).Getsize;
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, ProductDetails.routeName,arguments: productModel.id);
          // GlobalVariable.routeTo(context: context, routeName: ProductDetails.routeName);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: productModel.imageUrl,
                height: size.height *0.09,width: size.width*0.15,boxFit: BoxFit.fill,
              ),
              Padding(padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(title: productModel.title, color: color, fontweight: 18),
                    HeartBTN(productId: productModel.id,),
                  ],
                ),
              ),
              Row(
                children: [
                  PriceWidget(
                    textPrice: Kg_size.text !=  "" ? Kg_size.text :   '1' ,
                    salePrice: productModel.salePrice,
                    sale: productModel.price,
                    isOnSale: productModel.isOnSale ,
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    flex: 3,
                    child: FittedBox(
                        child: TextWidget(title: productModel.isPiece ? "peice" :"KG", color: color, fontweight: 18,istitle: true,)),
                  ),
                  SizedBox(width: 5,),
                  Flexible(child: TextFormField(
                    controller: Kg_size,
                    onChanged: (value){
                      setState(() {
                      });
                    },
                    key: ValueKey('10'),
                    style: TextStyle(color: color,fontSize: 18),
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    enabled: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                    ],
                  ))
                ],
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: TextButton(onPressed:
                  isInCart? null: () async {
                    final User? user = authInstance!.currentUser;
                    if(user == null){
                      GlobalVariable.waringDailog(title: "Auth Error", subtitle: "Login to add to cart", fn: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));}, context: context);
                      return;
                    }
                    else {
                    await  cartprovier.addToCart(
                          productId: productModel.id,
                          quantity: 1,context: context);
                    await cartprovier.fetchCart();
                    }},
              child:
                TextWidget(title: isInCart ?"In cart":"Add to cart",color: color,fontweight: 18,maxlines: 1,),
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12),),),
                      )
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
