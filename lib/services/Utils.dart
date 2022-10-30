import 'package:flutter/cupertino.dart';
import 'package:flutter_proj/Providers/Theme-provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get theme => Provider.of<themeProvider>(context).getDarktheme;
  Color get color => theme ? Colors.white : Colors.black;
  Size get Getsize => MediaQuery.of(context).size;
}
