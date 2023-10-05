import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_proj/Screens/auth/login_page.dart';
import 'package:flutter_proj/consts/contss.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/widgets/auth_btn.dart';

import '../../consts/firebaseconnection.dart';
import '../loadingManager.dart';
class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({Key? key}) : super(key: key);
static const routeName = '/forgotpass';
  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final email = TextEditingController();
  bool _isloading = false;
  void _validate() async{
    print("btn clicked");
    if(!email.text.isEmpty && email.text.contains('@')){
      setState(() {
        _isloading = true;
      });
      try{
        await authInstance.sendPasswordResetEmail(email:
        email.text.toLowerCase());
        _isloading = false;
        GlobalVariable.waringDailog(title: 'Mail sent',
            subtitle: "Reset mail sent to your mail address",
            fn: (){
              Navigator.of(context).pop();
            }, context: context);
      }on FirebaseException catch (error){
        GlobalVariable.waringDailog(title: '${error.message}',
            subtitle: "error occured",
            fn: (){}, context: context);
        _isloading = false;
      }
      catch(error){
        GlobalVariable.waringDailog(title: '$error',
            subtitle: "error occured", fn: (){}
            , context: context);
        _isloading=false;
      }
    }else{
      GlobalVariable.waringDailog(title: "Incorrect Email address",
          subtitle: "please enter the valid email address",
          fn: (){}, context: context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: LoadingManager(
          isLoading:_isloading,
          child: Stack(
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
                    Authbtn(buttontext: "Change password", fcn: (){_validate();})
                  ],
                ),
              ),
            )
  ]
    ),
        ),
    );
  }
}
