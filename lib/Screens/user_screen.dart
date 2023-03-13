import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Providers/Theme-provider.dart';
import 'package:flutter_proj/Screens/orders/order_screen.dart';
import 'package:flutter_proj/Screens/viewed/viewed_screen.dart';
import 'package:flutter_proj/Screens/whislist/Whislist_screen.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:provider/provider.dart';

class userScreen extends StatefulWidget {
  const userScreen({Key? key}) : super(key: key);

  @override
  State<userScreen> createState() => _userScreenState();
}

class _userScreenState extends State<userScreen> {
  TextEditingController adressController = TextEditingController();

  @override
  void dispose() {
    adressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<themeProvider>(context);
    final Color color = theme.getDarktheme ? Colors.white : Colors.black;
    bool open = false;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          //used for the scroll view
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              //centering the element inside the column widget
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: RichText(
                      text: TextSpan(
                          text: "Hi,  ",
                          style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: "User",
                            style: TextStyle(
                                color: color,
                                fontSize: 28,
                                fontWeight: FontWeight.w600))
                      ])),
                ),
                // SizedBox(height: 5,),
                Container(
                    margin: EdgeInsets.only(left: 20, top: 10),
                    child: TextWidget(
                      color: color,
                      fontweight: 18,
                      title: "Email@gmail.com",
                    )),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 2,
                ),
                SizedBox(
                  height: 20,
                ),
               // ListTile(
               //    title: TextWidget(
               //      title: "Address",
               //      fontweight: 21,
               //      color: color,
               //      istitle: false,
               //    ),
               //    leading: Icon(IconlyLight.profile),
               //    onTap: () {
               //      showDialog(
               //          context: context,
               //          builder: (ctx) => AlertDialog(
               //                title: Text("update"),
               //                content: TextField(
               //                  onChanged: (value){
               //                    // adressController.text;
               //                  },
               //                  controller: adressController,
               //                  decoration: InputDecoration(
               //                    hintText: "Your address",
               //                  ),
               //                ),
               //                actions: [
               //                  TextButton(
               //                      onPressed: () {
               //                        Navigator.of(context).pop();
               //                      },
               //                      child: Text("h,mm"))
               //                ],
               //              ));
               //    },
               //    subtitle: TextWidget(
               //      title: "Your address",
               //      color: color,
               //      fontweight: 15,
               //      istitle: false,
               //    ),
               //    trailing: Icon(IconlyLight.arrowRight2),
               //  ),

                _listTiles(title: "Address", icon: IconlyLight.profile, onPressed: ()async{
                  await _addressModel();
                },subtile: "Your address"
        ,color: color),
                _listTiles(
                  title: "Orders",
                  icon: IconlyLight.bag,
                  onPressed: () {
                    GlobalVariable.routeTo(context: context, routeName: OrderScreen.routeName);
                  },
                  color: color,
                ),
                _listTiles(
                  title: "Whislist",
                  icon: IconlyLight.heart,
                  onPressed: () {
                    GlobalVariable.routeTo(context: context, routeName: Whislist.routeName);
                  },
                  color: color,
                ),
                _listTiles(
                  title: "Viewed",
                  icon: IconlyLight.show,
                  onPressed: () {
                    GlobalVariable.routeTo(context: context, routeName: Viewed_screen.pathname);
                  },
                  color: color,
                ),
                SwitchListTile(
                  onChanged: (bool value) {
                    theme.setDarktheme = value;
                  },
                  contentPadding: EdgeInsets.only(left: 20, bottom: 20),
                  value: theme.getDarktheme,
                  title: TextWidget(
                    title: theme.getDarktheme ? "Dark theme" : "Light theme",
                    color: color,
                    fontweight: 20,
                  ),
                  secondary: Icon(theme.getDarktheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                ),
                _listTiles(
                  title: "Forgot password",
                  icon: IconlyLight.unlock,
                  onPressed: () {},
                  color: color,
                ),
                _listTiles(
                  title: "Logout",
                  icon: IconlyLight.logout,
                  onPressed: () async {
                    await GlobalVariable.waringDailog(title: "Sign out", subtitle: "Do you wana Logout", fn: (){}, context: context);
                  },
                  color: color,
                ),
                // ListTile(title: Text("testing"),onTap: (){
                //   open = true;
                //   showDialog(context: context, builder: (ctx)=> AlertDialog(title: Text("hello"),content: Text("okay"),actions: [
                //     TextButton(onPressed: (){
                //
                //     }, child: Text("h,mm"))
                //   ],));
                // },subtitle: Text("lets watch"),),
                // ElevatedButton(onPressed: (){
                //   showDialog(context: context, builder: (ctx)=> AlertDialog(title: Text("hello"),content: Text("okay"),actions: [
                //     TextButton(onPressed: (){
                //       Navigator.of(context).pop();
                //     }, child: Text("h,mm"))
                //   ],));
                // }, child: Text("text button"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listTiles(
      {required String title,
      String? subtile,
      required IconData icon,
      required Function onPressed,
      required color}) {
    return ListTile(
      title: TextWidget(
        title: title,
        color: color,
        fontweight: 21,
        istitle: false,
      ),
      subtitle: TextWidget(
        title: subtile == null ? "" : subtile,
        color: color,
        fontweight: 21,
        istitle: false,
      ),
      leading: Icon(icon),
      trailing: Icon(IconlyLight.arrowRight2),
      onTap:(){onPressed();} ,
    );
  }
  Future <void> _addressModel() async{
    await
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("update"),
            content: TextField(
              onChanged: (value){
                // adressController.text;
              },
              controller: adressController,
              decoration: InputDecoration(
                hintText: "Your address",
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Update"))
            ],
          )
      );
    }


}

