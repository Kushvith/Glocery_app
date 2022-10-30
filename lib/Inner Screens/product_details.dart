import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/Heart_btn.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);
  static const routeName = '/ProductDetails';
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(IconlyLight.arrowLeft2,color: color,),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child:   FancyShimmerImage(
              imageUrl: 'https://media.istockphoto.com/photos/red-apple-picture-id184276818?k=20&m=184276818&s=612x612&w=0&h=QxOcueqAUVTdiJ7DVoCu-BkNCIuwliPEgtAQhgvBA_g=',
              height: size.height *0.4,width: size.width,boxFit: BoxFit.fill,
            ),
          ),
          Flexible(
            child: Container(
              width: size.height,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5),topRight: Radius.circular(5),),

              ),

              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        TextWidget(title: "title", color: color, fontweight: 24,istitle: true,),
                        Spacer(),
                        HeartBTN(),
                      ],
                    ),
                  ),

                     Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30,right: 30,top:20),
                        child: Row(
                        children: [
                          TextWidget(title: "\$25", color: Colors.green,istitle: true, fontweight: 25),
                          TextWidget(title: " /Kg", color: color, fontweight: 18,istitle: false,),
                          SizedBox(width: 7,),
                          Visibility(child: Text("\$30",style: TextStyle(color: color,decoration:TextDecoration.lineThrough,fontSize: 22),),
                          visible: true,
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextWidget(color: Colors.white,title: "Free delivery",fontweight: 18,istitle: true,maxlines: 1,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 60,),
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
                              setState(() {
                                _quantitiyValue.text = (int.parse(_quantitiyValue.text) - 1).toString();
                              });
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
                           setState(() {
                             _quantitiyValue.text = (int.parse(_quantitiyValue.text) +1).toString();
                           });
                          }),

                        ],
                      ),
                    ),
                  ),
                    Spacer(flex: 8,),
                  Container(

                      width: size.width,
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(title: "Total", color: Colors.red.shade300, fontweight: 20,istitle:true,),
                                 Row(

                                   children: [
                                     TextWidget(title: "\$2.59",color: color,fontweight: 20,istitle:true,),
                                     SizedBox(width: 2,),
                                     TextWidget(title: '${_quantitiyValue.text}/Kg', color: color, fontweight: 20,),
                                   ],
                                 )

                                ],
                              ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: (){},
                            child: Material(
                              color: Colors.green,
                              borderRadius:  BorderRadius.circular(12),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: TextWidget(title: "Add to cart",color: color,fontweight: 20,istitle: true,maxlines: 1,),
                              ),
                            ),
                          )
                        ],
                      ),
                  ),
                ],
              ),
            ),
          flex: 3,
          ),
        ],
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
