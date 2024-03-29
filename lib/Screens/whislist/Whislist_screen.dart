import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Providers/whislistProvider.dart';
import 'package:flutter_proj/Screens/whislist/Whislist_widget.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/services/empty_screen.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:provider/provider.dart';

class Whislist extends StatelessWidget {
  const Whislist({Key? key}) : super(key: key);
  static const routeName = '/Whislist';
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).Getsize;
    Color color = Utils(context).color;
    final whisprovider = Provider.of<WhilistProvider>(context);
    final whisItem = whisprovider.getWhislistItems.values.toList().reversed.toList();

    return whisItem.isEmpty ? EmptyScreen(maintitle: "whislist",imagepath: "assets/images/wishlist.png", title: "Empty whislist", subtitle: "add items to whislist", ButtonText: "Browse items")
        :Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(IconlyLight.arrowLeft2,color: color,),
        ),
        title: TextWidget(title: "Whilist",color: color,fontweight: 20,istitle: true,),
        elevation: 0.5,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () async{
                await GlobalVariable.waringDailog(title: "Delete", subtitle: "Are you sure clear whislist", fn: (){
                  whisprovider.clearCart();
                }, context: context);
              },
              child: Icon(IconlyLight.delete,color: color,),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: (size.width / (size.height / 2.8)),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10, 
          children: List.generate(whisItem.length, (index) => ChangeNotifierProvider.value(
              value: whisItem[index],
              child: WhislistWidget())),
        ),
        
      ),
    );
  }
}
