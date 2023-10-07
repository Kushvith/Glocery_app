import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/Inner%20Screens/product_details.dart';
import 'package:flutter_proj/Providers/ProductProvider.dart';
import 'package:flutter_proj/models/orderModel.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:provider/provider.dart';

import '../../models/cartModel.dart';

class OrderWidget extends StatefulWidget {
   OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;
  @override
  void didChangeDependencies() {
    final ordermodel = Provider.of<OrderModel>(context);
    var orderDate = ordermodel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).Getsize;
    final ordermodel = Provider.of<OrderModel>(context);
    final productprovider = Provider.of<productProvider>(context);
    final currprov = productprovider.findById(ordermodel.productId);
    return ListTile(
      onTap: () {
        GlobalVariable.routeTo(
            context: context, routeName: ProductDetails.routeName);
      },
      subtitle:  Text('paid: \$ ${double.parse(ordermodel.price)} '),
      leading: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: FancyShimmerImage(
          width: size.width * 0.2,
          imageUrl:
              ordermodel.imageUrl,
        ),
      ),
      title: TextWidget(title: '${currprov.title}', color: color,fontweight: 18,istitle: true,),
      trailing: TextWidget(title: "$orderDateToShow",color: color,fontweight: 18,istitle: true),
    );
  }
}
