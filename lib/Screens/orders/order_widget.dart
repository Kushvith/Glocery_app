import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/Inner%20Screens/product_details.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/textWidget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).Getsize;

    return ListTile(
      onTap: () {
        GlobalVariable.routeTo(
            context: context, routeName: ProductDetails.routeName);
      },
      subtitle: const Text('paid: \$ 12.9'),
      leading: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: FancyShimmerImage(
          width: size.width * 0.2,
          imageUrl:
              'https://media.istockphoto.com/photos/red-apple-picture-id184276818?k=20&m=184276818&s=612x612&w=0&h=QxOcueqAUVTdiJ7DVoCu-BkNCIuwliPEgtAQhgvBA_g=',
        ),
      ),
      title: TextWidget(title: "Title", color: color,fontweight: 18,istitle: true,),
      trailing: TextWidget(title: "03/12/23",color: color,fontweight: 18,istitle: true),
    );
  }
}
