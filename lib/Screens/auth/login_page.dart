import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/Screens/auth/forgotpassword.dart';
import 'package:flutter_proj/Screens/auth/register.dart';
import 'package:flutter_proj/consts/contss.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/widgets/auth_btn.dart';
import 'package:flutter_proj/widgets/google_btn.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const routeName = "/loginpage";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passfocusnode = FocusNode();
  var _obsture = true;
  var _formkey = GlobalKey<FormState>();
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _passfocusnode.dispose();
  }
  void _submitLoginOnSubmit(){
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      print("form submited");
    }
  }
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 120,),
                  TextWidget(title: "Welcome back", color: Colors.white, fontweight: 32,istitle: true,),
                  SizedBox(height: 10,),
                  TextWidget(title: "sign into to continue", color: Colors.white, fontweight: 16),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete:() => FocusScope.of(context).requestFocus(_passfocusnode),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.isEmpty || !value.contains('@')){
                              return "please enter the valid email";
                            }

                          },
                          style: TextStyle(
                            color: Colors.white
                          ),
                          decoration: const InputDecoration(
                            hintText: "email",
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                            )
                          )
                          ),
                       SizedBox(height: 20,),
                        TextFormField(
                            textInputAction: TextInputAction.done,
                            onEditingComplete:() => _submitLoginOnSubmit(),
                            controller: _passwordController,
                            obscureText: _obsture,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value){
                              if(value!.isEmpty || value.length >7){
                                return "please enter the valid password";
                              }

                            },
                            style: TextStyle(
                                color: Colors.white
                            ),
                            decoration:  InputDecoration(
                                hintText: "password",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                suffix: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _obsture = !_obsture;
                                    });
                                  },
                                  child:Icon(!_obsture? Icons.visibility_off :Icons.visibility,color: Colors.white,),
                                ),

                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                )
                            )
                        ),

                      ],
                    ),

                  ),
                  SizedBox(height: 10,),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(onPressed: (){
                      GlobalVariable.routeTo(context: context, routeName: ForgotPassPage.routeName);
                    }, child: Text(
                      "forgot password",
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        fontStyle: FontStyle.italic,
                      ),
                    )),
                  ),
                  Authbtn(buttontext: "Login ", fcn: (){}),
                  SizedBox(height: 20,),
                  Googlebtn(),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      )),
                      SizedBox(width: 5,),
                      TextWidget(title: "OR", color: Colors.white, fontweight: 18),
                      SizedBox(width: 5,),
                      Expanded(child: Divider(
                        color: Colors.white,
                        thickness: 2,
                      )),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Authbtn(buttontext: "Login as Guest", fcn: (){},primaryColor: Colors.black,),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      TextWidget(title: "don\'t have account? ", color: Colors.white, fontweight: 18),
                      SizedBox(width: 5,),
                      InkWell(
                        onTap: (){
                          GlobalVariable.routeTo(context: context, routeName: Register_Screen.routeName);
                        },
                        child: Text(
                          "create new account",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
