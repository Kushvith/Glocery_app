import 'dart:ffi';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_proj/Inner%20Screens/product_details.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/Heart_btn.dart';
import 'package:flutter_proj/widgets/priceWidget.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
class FeedItems extends StatefulWidget {
  const FeedItems({Key? key}) : super(key: key);
  @override
  State<FeedItems> createState() => _FeedItemsState();
}

class _FeedItemsState extends State<FeedItems> {
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
    Color color = Utils(context).color;
    Size size = Utils(context).Getsize;
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: (){
          GlobalVariable.routeTo(context: context, routeName: ProductDetails.routeName);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              FancyShimmerImage(
                imageUrl: 'https://media.istockphoto.com/photos/red-apple-picture-id184276818?k=20&m=184276818&s=612x612&w=0&h=QxOcueqAUVTdiJ7DVoCu-BkNCIuwliPEgtAQhgvBA_g=',
                height: size.height *0.11,width: size.width*0.15,boxFit: BoxFit.fill,
              ),
              Padding(padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    TextWidget(title: "Title", color: color, fontweight: 18),
                    HeartBTN(),
                ],
              ),
              ),
              Row(
                children: [
                    PriceWidget(
                      textPrice: Kg_size.text !=  "" ? Kg_size.text :   '1' ,
                      salePrice: 5.9,
                      sale: 10,
                      isOnSale: false ,
                    ),
                  SizedBox(width: 10,),
                  TextWidget(title: "KG", color: color, fontweight: 18,istitle: true,),
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
                child: TextButton(onPressed: (){},  child:
                    TextWidget(title: "Add to cart",color: color,fontweight: 18,maxlines: 1,),
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
