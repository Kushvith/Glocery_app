import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/on_sale_widget.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
class OnsaleScreen extends StatelessWidget {
  const OnsaleScreen({Key? key}) : super(key: key);
    static  const routeName = '/OnsaleScreen';

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = false;
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
        elevation: 1,
        title: Center(child: TextWidget(title: "On Sale Widget",color: color,fontweight: 18,istitle: true,)),
      ),
      body: _isEmpty ? Center(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset('assets/images/box.png',width: 250,),
            ),
            Center(child: Text("No products \n need to be added",style: TextStyle(color: color,fontSize: 20,fontWeight: FontWeight.w700),textAlign: TextAlign.center, )),
          ],
        ),
      ): GridView.count(crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: size.width/(size.height*0.6),
        children : List.generate(16, (index) => OnSaleWidget()),
      ),
    );
  }
}
