import 'package:flutter/material.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
class PriceWidget extends StatelessWidget {
  PriceWidget({Key? key,required this.sale,required this.salePrice,required this.textPrice,required this.isOnSale}) : super(key: key);
  final double sale,salePrice;
  final String textPrice;
  final bool isOnSale;
  
  @override
  Widget build(BuildContext context) {
    double userPrice = isOnSale ? salePrice : sale;
    Color theme = Utils(context).color;

    return Flexible(
      flex: 4,
      child: FittedBox(
        child: Row(
          children: [
            TextWidget(title: "\$${(userPrice * (int.parse(textPrice))).toStringAsFixed(2)}", color: Colors.green, fontweight: 22,),
            SizedBox(width: 5,),
            Visibility(
              visible: isOnSale ? true : false,
              child: Text("\$${(sale * (int.parse(textPrice))).toStringAsFixed(2)}",style: TextStyle(
                color: theme,
                fontSize: 15,
                decoration: TextDecoration.lineThrough,
              ),),
            )
          ],
        ),
      ),
    );
  }
}
