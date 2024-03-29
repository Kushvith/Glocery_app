import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Providers/ProductProvider.dart';
import 'package:flutter_proj/models/productModel.dart';

import 'package:flutter_proj/services/Utils.dart';
import 'package:flutter_proj/widgets/feed_items.dart';

import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:provider/provider.dart';

import '../Providers/ProductProvider.dart';
import '../Providers/ProductProvider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  static  const routeName = '/FeedScreen';

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  TextEditingController _searchController = TextEditingController();

  FocusNode _searchFocused = FocusNode();
  List<ProductModel> listProductSearch = [];
  @override
  void initState() {
    final productprovider = Provider.of<productProvider>(context,listen: false);
    productprovider.fetch_products();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final productprovider = Provider.of<productProvider>(context);
    List<ProductModel> getProducts = productprovider.getProduct;

    @override
    void dispose() {
      // TODO: implement dispose
      _searchController.dispose();
      _searchFocused.dispose();
      super.dispose();
    }
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
        title: TextWidget(title: "Our Products",color: color,fontweight: 18,istitle: true,),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocused,
                onChanged: (valuee){
                print(valuee);
                setState(() {
                  listProductSearch = productprovider.SearchQuery(valuee);
                  print(listProductSearch);
                });
              },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.green
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Colors.green
                      ),
                  ),
                    hintText: "what is there in your mind",
                    prefixIcon: Icon(IconlyLight.search),
                    suffix: IconButton(
                      onPressed: (){
                        _searchController.clear();
                        _searchFocused.unfocus();
                      },
                      icon: Icon(Icons.close,color: Colors.red,),
                    ),
                ),
              ),
            ),
          ),
          _searchController.text.isNotEmpty &&
              listProductSearch.isEmpty? Center(
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
          ):  Flexible(
            child:  GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: size.width / (size.height * 0.55),
              children: List.generate(
                  _searchController.text.isNotEmpty
                      ? listProductSearch.length
                      : getProducts.length,
                      (index) => ChangeNotifierProvider.value(
                    value: _searchController.text.isNotEmpty
                        ? listProductSearch[index]
                        : getProducts[index],
                    child: FeedItems(),
                  )),
            ),
          ),
        ],
      ),
    );
  }


}
