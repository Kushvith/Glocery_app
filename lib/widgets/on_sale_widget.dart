import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Inner%20Screens/product_details.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/priceWidget.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import 'Heart_btn.dart';
class OnSaleWidget extends StatelessWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    Size size = Utils(context).Getsize;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: (){
            GlobalVariable.routeTo(context: context, routeName: ProductDetails.routeName);
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
                          imageUrl: 'https://media.istockphoto.com/photos/red-apple-picture-id184276818?k=20&m=184276818&s=612x612&w=0&h=QxOcueqAUVTdiJ7DVoCu-BkNCIuwliPEgtAQhgvBA_g=',
                          height: size.height *0.14,width: size.width*0.16,boxFit: BoxFit.fill,
                        ),

                    Container(
                      margin: EdgeInsets.only(left: 4),
                      child: Column(

                        children: [
                          SizedBox(height: 10,),
                          TextWidget(title: "1 KG", color: Colors.green, fontweight: 22,istitle: true,),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){},
                                child: Icon(IconlyLight.bag2,size: 22,),

                              ),
                              SizedBox(width: 5,),
                              HeartBTN()
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
                  salePrice: 5.9,
                  sale: 10 ,
                  textPrice: "1",
                ),
                SizedBox(height: 2,),
                TextWidget(title: "Product title", color: color, fontweight: 16)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
