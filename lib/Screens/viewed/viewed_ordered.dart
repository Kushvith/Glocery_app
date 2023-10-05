import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Inner%20Screens/product_details.dart';
import 'package:flutter_proj/Providers/ProductProvider.dart';
import 'package:flutter_proj/Providers/Viewed_prod.dart';
import 'package:flutter_proj/Providers/cartProvider.dart';
import 'package:flutter_proj/models/productModel.dart';
import 'package:flutter_proj/models/viewed_model.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/services/empty_screen.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:provider/provider.dart';

class viewedWidget extends StatefulWidget {
  const viewedWidget({Key? key}) : super(key: key);

  @override
  State<viewedWidget> createState() => _viewedWidgetState();
}

class _viewedWidgetState extends State<viewedWidget> {

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    Size size = Utils(context).Getsize;

    final ViewedProductModel = Provider.of<ViewedProdModel>(context);
    final productprovider = Provider.of<productProvider>(context);
   final productModel =  productprovider.findById(ViewedProductModel.prodId);
    final cartprovider = Provider.of<cartProvider>(context);
    bool? _IsInCart = cartprovider.getCartItems.containsKey(productModel.id);

    double usedPrice = productModel.isOnSale? productModel.salePrice :
    productModel.price;
    return ListTile(
      title: TextWidget(
        title: productModel.title,
        color: color,
        fontweight: 18,
      ),
      subtitle: TextWidget(
        title:"\$${usedPrice.toStringAsFixed(2)}",
        color: color ,
          fontweight: 12,
      ),
      leading: FancyShimmerImage(
         imageUrl:   productModel.imageUrl,
          width: size.width * 0.2,
      ),
      trailing: Material(
        color: Colors.green,
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context,
                ProductDetails.routeName,
                arguments: productModel.id);
          },
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
               _IsInCart? Icons.check: IconlyBold.plus,
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
