import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Providers/Theme-provider.dart';
import 'package:provider/provider.dart';
class userScreen extends StatelessWidget {
  const userScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<themeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView( //used for the scroll view
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //centering the element inside the column widget
          children:  [
                _listTiles(title: "Address", icon: IconlyLight.profile, onPressed: (){},subtile: "address"),
                _listTiles(title: "Orders", icon: IconlyLight.bag, onPressed: (){},),
                _listTiles(title: "Whislist", icon: IconlyLight.heart, onPressed: (){},),
                _listTiles(title: "Viewed", icon: IconlyLight.show, onPressed: (){},),
            SwitchListTile(onChanged: (bool value){
              theme.setDarktheme = value;
            },
              value: theme.getDarktheme,
              title : Text("Theme"),
              secondary: Icon(theme.getDarktheme ?Icons.dark_mode_outlined :Icons.light_mode_outlined),
            ),
                _listTiles(title: "Forgot assword", icon: IconlyLight.unlock, onPressed: (){},),
                _listTiles(title: "Logout", icon: IconlyLight.logout, onPressed: (){},),
          ],
        ),
      ),
    );
  }
  Widget _listTiles({required String title,String? subtile,required IconData icon,required Function onPressed }){
    return ListTile(
      title: ,
      subtitle: Text(subtile == null ? "":subtile),
      leading: Icon(icon),
      trailing: Icon(IconlyLight.arrowRight2),
      onTap: onPressed(),
    );
  }
}