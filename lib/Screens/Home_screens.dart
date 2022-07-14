import 'package:flutter/material.dart';
import 'package:flutter_proj/Providers/Theme-provider.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<themeProvider>(context);
    return Scaffold(
        body: Center(
          child: SwitchListTile(onChanged: (bool value){
            theme.setDarktheme = value;
          },
              value: theme.getDarktheme,
            title : Text("Theme"),
            secondary: Icon(theme.getDarktheme ?Icons.dark_mode_outlined :Icons.light_mode_outlined),
          ),
        ),
    );
  }
}
