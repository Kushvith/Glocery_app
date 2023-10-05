import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Inner%20Screens/FeedScreen.dart';
import 'package:flutter_proj/Inner%20Screens/OnSaleScreens.dart';
import 'package:flutter_proj/Providers/ProductProvider.dart';
import 'package:flutter_proj/Providers/Theme-provider.dart';
import 'package:flutter_proj/models/productModel.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/consts/contss.dart';
import 'package:flutter_proj/widgets/feed_items.dart';
import 'package:flutter_proj/widgets/on_sale_widget.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<themeProvider>(context);
    Size size = Utils(context).Getsize;
    final productprovider = Provider.of<productProvider>(context);
    List<ProductModel> getProducts = productprovider.getProduct;
    List<ProductModel> getOnSale = productprovider.getOnSale;
    Color color = Utils(context).color;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.3,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {

                  return Image.asset(
                    constss.OfferImages[index],
                    fit: BoxFit.fill,
                  );
                },
                itemCount: constss.OfferImages.length,
                autoplay: true,
                pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.white, activeColor: Colors.orangeAccent)),
                // control: SwiperControl(),
              ),
            ),
           SizedBox(height: 5,),
            TextButton(onPressed: (){
              GlobalVariable.routeTo(context: context, routeName: OnsaleScreen.routeName);
            }, child: Text("View All",style: TextStyle(fontSize: 20,color: Colors.blue),)),
           Row(

             children: [
               RotatedBox(
                 quarterTurns: -1,
               child : Row(
                 children: [
                    SizedBox(height: 5,),
                   TextWidget(title: "on sale", color: Colors.red, fontweight: 25),
                   SizedBox(width: 5,),
                   Icon(IconlyLight.discount)
                 ],
               ),
               ),
               Flexible(
                 child: Container(
                   height: size.height*0.24,
                   child: ListView.builder(
                     itemCount: getOnSale.length<10 ?getOnSale.length:10,
                       scrollDirection: Axis.horizontal,
                       itemBuilder: (ctx,index){
                         return ChangeNotifierProvider.value(
                             value: getOnSale[index],
                             child: OnSaleWidget());
                       }),
                 ),
               ),
             ],
           ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(height: 5,),
                  TextWidget(title: "Our products", color: color, fontweight: 22,istitle:true),
                  Spacer(),
                  TextButton(onPressed: (){
                    GlobalVariable.routeTo(context: context, routeName: FeedScreen.routeName);
                  }, child: TextWidget(title: "Browse All",color: Colors.blue,fontweight: 22,)),
                ],
              ),
            ),
            GridView.count(crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: size.width/(size.height*0.6),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children : List.generate(getProducts.length < 4 ? getProducts.length: 4, (index) => ChangeNotifierProvider.value(
              value: getProducts[index],
              child: FeedItems(


              ),
            )),
            )
          ],
        ),
      ),
    );
  }
}
