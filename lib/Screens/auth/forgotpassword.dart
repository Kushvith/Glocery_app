import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_proj/consts/contss.dart';
import 'package:flutter_proj/widgets/auth_btn.dart';
class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);
static const routeName = '/forgotpass';
  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final email = TextEditingController();
  void _validate(){}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
        children: [

        Swiper(itemCount: constss.LoginpageImages.length,
        duration: 800,
        autoplayDelay: 5000,
        itemBuilder: (ctx,index){
      return Image.asset(
        constss.LoginpageImages[index],
        fit: BoxFit.fill,
      );
    },
    autoplay: true,),
    Container(
    color: Colors.black.withOpacity(0.7),
    ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  BackButton(onPressed: (){
                    Navigator.pop(context);
                  },color: Colors.white,),
                  SizedBox(height: 30,),
                  TextField(
                    controller: email,
                    maxLines: 1,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      hintStyle: TextStyle(
                        color: Colors.white
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                      )
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Authbtn(buttontext: "Change password", fcn: _validate)
                ],
              ),
            ),
          )
  ]
    ),
    );
  }
}
