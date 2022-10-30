import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Inner%20Screens/product_details.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/Heart_btn.dart';
import 'package:flutter_proj/widgets/textWidget.dart';

class cartWidget extends StatefulWidget {
  const cartWidget({Key? key}) : super(key: key);

  @override
  State<cartWidget> createState() => _cartWidgetState();
}

class _cartWidgetState extends State<cartWidget> {
  TextEditingController _quantitiyValue = TextEditingController();
  @override
  void initState() {
    _quantitiyValue.text = '1';
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

    Size size = Utils(context).Getsize;
    Color color = Utils(context).color;
    return GestureDetector(
      onTap: (){
        GlobalVariable.routeTo(context: context, routeName: ProductDetails.routeName);
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
                      imageUrl: 'https://media.istockphoto.com/photos/red-apple-picture-id184276818?k=20&m=184276818&s=612x612&w=0&h=QxOcueqAUVTdiJ7DVoCu-BkNCIuwliPEgtAQhgvBA_g=',
                    ),
                  ),

              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(title: "Title", color: color, fontweight: 20,istitle: true,),
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
                      onTap: (){},
                      child: Icon(CupertinoIcons.cart_badge_minus,color: Colors.red,size: 20,),
                    ),
                    SizedBox(height: 8,),

                    HeartBTN(),
                    SizedBox(height: 8,),
                    TextWidget(title: "\$ 0.29", color: color, fontweight: 20,maxlines: 1,istitle: true,)
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
