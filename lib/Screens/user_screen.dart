import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Providers/Theme-provider.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:provider/provider.dart';
class userScreen extends StatelessWidget {
  const userScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<themeProvider>(context);
    final Color color = theme.getDarktheme ? Colors.white: Colors.black;
    return Scaffold(
      body: SingleChildScrollView( //used for the scroll view
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //centering the element inside the column widget
          children:  [
                _listTiles(title: "Address", icon: IconlyLight.profile, onPressed: (){},subtile: "address",color:color,),
                _listTiles(title: "Orders", icon: IconlyLight.bag, onPressed: (){},color:color,),
                _listTiles(title: "Whislist", icon: IconlyLight.heart, onPressed: (){},color:color,),
                _listTiles(title: "Viewed", icon: IconlyLight.show, onPressed: (){},color:color,),
            SwitchListTile(onChanged: (bool value){
              theme.setDarktheme = value;
            },
              value: theme.getDarktheme,
              title : Text("Theme"),
              secondary: Icon(theme.getDarktheme ?Icons.dark_mode_outlined :Icons.light_mode_outlined),
            ),
                _listTiles(title: "Forgot password", icon: IconlyLight.unlock, onPressed: (){},color:color,),
                _listTiles(title: "Logout", icon: IconlyLight.logout, onPressed: (){},color:color,),
          ],
        ),
      ),
    );
  }
  Widget _listTiles({required String title,String? subtile,required IconData icon,required Function onPressed,required color }){
    return ListTile(
      title: TextWidget(title: title,color: color,fontweight: 21,istitle: false,),
      subtitle: TextWidget(title: subtile == null ? "":subtile,color: color,fontweight: 21,istitle: false,),
      leading: Icon(icon),
      trailing: Icon(IconlyLight.arrowRight2),
      onTap: onPressed(),
    );
  }
}