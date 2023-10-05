import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Providers/Theme-provider.dart';
import 'package:flutter_proj/Providers/cartProvider.dart';
import 'package:flutter_proj/Screens/Home_screens.dart';
import 'package:flutter_proj/Screens/cart/cart_screen.dart';
import 'package:flutter_proj/Screens/categories_screen.dart';
import 'package:flutter_proj/Screens/user_screen.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class Btm_screeen extends StatefulWidget {
  const Btm_screeen({Key? key}) : super(key: key);
  @override
  _Btm_screeenState createState() => _Btm_screeenState();
}

class _Btm_screeenState extends State<Btm_screeen> {
  int _bottomIndex = 0;
  final List _page = [
    const HomeScreen(),
    categoriesScreen(),
    const CartScreen(),
    const userScreen()
  ];
  void _selectedPage(int value) {
    setState(() {
      _bottomIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themestate = Provider.of<themeProvider>(context);
    bool state = themestate.getDarktheme;
    final cartprovider = Provider.of<cartProvider>(context);
    return Scaffold(
      body: _page[_bottomIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: state ? Theme.of(context).canvasColor : Colors.white,
        type: BottomNavigationBarType.fixed, //doesnot moves top and bottom
        showSelectedLabels: false, //this hides the name from the selected tab
        showUnselectedLabels:
            false, //this hides the name from the unselected tab
        selectedItemColor: state ? Colors.lightBlue.shade200 : Colors.black87,
        unselectedItemColor: state ? Colors.white38 : Colors.black38,
        currentIndex: _bottomIndex,
        onTap: _selectedPage,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                _bottomIndex == 0 ? IconlyBold.home : IconlyLight.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                _bottomIndex == 1 ? IconlyBold.category : IconlyLight.category,
              ),
              label: "Category"),
          BottomNavigationBarItem(
              icon:Consumer<cartProvider>(
                builder: (_,mycart,ch) {
                  return FittedBox(
                  // child: Badge(
                  //   // badgeColor: Colors.blue,
                  //   padding: EdgeInsets.all(5),
                  //   badgeContent: Text(mycart.getCartItems.length.toString()),
                  //   // elevation: 0,
                    child: Icon(
                      _bottomIndex == 2 ? IconlyBold.buy : IconlyLight.buy,
                    ),
                  // ),
                  );
                }
              ),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(
                _bottomIndex == 3 ? IconlyBold.user2 : IconlyLight.user2,
              ),
              label: "User"),
        ],
      ),
    );
  }
}
