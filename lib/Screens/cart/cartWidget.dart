import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Inner%20Screens/product_details.dart';
import 'package:flutter_proj/Providers/ProductProvider.dart';
import 'package:flutter_proj/Providers/cartProvider.dart';
import 'package:flutter_proj/models/cartModel.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/Heart_btn.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:provider/provider.dart';

class cartWidget extends StatefulWidget {
  const cartWidget({Key? key,required  this.q}) : super(key: key);
final int q;
  @override
  State<cartWidget> createState() => _cartWidgetState();
}

class _cartWidgetState extends State<cartWidget> {
  TextEditingController _quantitiyValue = TextEditingController();
  @override
  void initState() {
    _quantitiyValue.text = widget.q.toString();
    // TODO: implement initState
    super.initState();
  }
@override
  void dispose() {
  _quantitiyValue.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  final productprovider = Provider.of<productProvider>(context);
  final cartmodel = Provider.of<cartModel>(context);
  final cartprovider = Provider.of<cartProvider>(context);
  final productModel = productprovider.findById(cartmodel.prodid);
  double usedPrice = productModel.isOnSale? productModel.salePrice : productModel.price;

    Size size = Utils(context).Getsize;
    Color color = Utils(context).color;
    return GestureDetector(
      onTap: (){
        // GlobalVariable.routeTo(context: context, routeName: ProductDetails.routeName);
        Navigator.pushNamed(context, ProductDetails.routeName,arguments: productModel.id);
      },

      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
           decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(12),
           color: Theme.of(context).cardColor.withOpacity(0.2),
           ),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).cardColor.withOpacity(0.6),

                    ),
                    height: size.width*0.15,
                    width: size.width*0.25,

                    child:
                    FancyShimmerImage(
                      imageUrl: productModel.imageUrl,
                    ),
                  ),

              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(title: productModel.title, color: color, fontweight: 20,istitle: true,),
                  SizedBox(
                    width: size.width*0.4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                              _quantityButton(color: Colors.red, icon: CupertinoIcons.minus ,fn: (){
                                  if(_quantitiyValue.text == '1'){
                                    return;
                                  }
                                  else{
                                    cartprovider.ReduceQuantityByOne(productModel.id);
                                    _quantitiyValue.text = (int.parse(_quantitiyValue.text) - 1).toString();
                                  }
                              }),
                          Flexible(
                            flex: 2,
                            child: TextField(
                              controller: _quantitiyValue,
                                onTap: (){},
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(),
                                  )
                                ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                              ],
                            ),
                          ),
                          _quantityButton(color: Colors.green, icon: CupertinoIcons.plus ,fn: (){
                            cartprovider.IncreaseQuantityByOne(productModel.id);
                            _quantitiyValue.text = (int.parse(_quantitiyValue.text) + 1).toString();
                          }),

                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        cartprovider.removeOneItem(productModel.id);
                      },
                      child: Icon(CupertinoIcons.cart_badge_minus,color: Colors.red,size: 20,),
                    ),
                    SizedBox(height: 8,),

                    HeartBTN(productId: productModel.id,),
                    SizedBox(height: 8,),
                    TextWidget(title: "\$ ${usedPrice}", color: color, fontweight: 20,maxlines: 1,istitle: true,)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _quantityButton({required Color color,required IconData icon,required Function fn}){
    return   Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: (){
              fn();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon,color: Colors.white,),
            ),
          ),
        ),
      ),
    );
  }
}
