import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/textWidget.dart';

class WhislistWidget extends StatelessWidget {
  const WhislistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).Getsize;
    Color color = Utils(context).color;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        border: Border.all(color: Colors.black.withOpacity(0.5),width: 2,),
      ),
      child: Row(
        children: [
          Container(
            height: size.height * 0.2,
            width: size.width * 0.2,
            child: FancyShimmerImage(
              imageUrl: 'https://media.istockphoto.com/photos/red-apple-picture-id184276818?k=20&m=184276818&s=612x612&w=0&h=QxOcueqAUVTdiJ7DVoCu-BkNCIuwliPEgtAQhgvBA_g=',
            ),
          ),
          Column(
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Padding(padding: EdgeInsets.all(6),child: Icon(IconlyLight.wallet,color: color, size: 28,),),
                  Padding(padding: EdgeInsets.all(6),child: Icon(IconlyBold.heart,color: Colors.red,size: 28,),)
                ],

              ),
              SizedBox(height: 5,),
              TextWidget(title: "peas",color: color,fontweight: 24,istitle: true,maxlines: 1,),
              SizedBox(height: 5,),
              Flexible(
                  flex: 2,
                  child: TextWidget(title: "\$2.59",fontweight: 20,color: Colors.green,)
              )
            ],
          )
        ],
      ),
    );
  }
}
