import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_proj/Screens/auth/login_page.dart';
import 'package:flutter_proj/consts/contss.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/widgets/auth_btn.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../btm_screen.dart';
import '../loadingManager.dart';
class Register_Screen extends StatefulWidget {
  const Register_Screen({Key? key}) : super(key: key);
  static const routeName = "/registerPage";

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _email = FocusNode();
  final _passfocusnode = FocusNode();
  final _address = FocusNode();
  bool _obsture = true;
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _address.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _email.dispose();
    _passfocusnode.dispose();
  }
bool _isloading = false;
  void _submitForm() async{
    final isValid = _key.currentState!.validate();
    FocusScope.of(context).unfocus();

    if(isValid){
      setState(() {
        _isloading = true;
      });
      _key.currentState!.save();
      try{
        final FirebaseAuth authInstance= FirebaseAuth.instance;
        final User? user = authInstance.currentUser;
        final uid = user!.uid;
        await   authInstance.createUserWithEmailAndPassword(
            email: _emailController.text.toLowerCase().trim(),
            password: _passwordController.text.trim());

        await FirebaseFirestore.instance.collection('users').doc(uid).set(
         {
           'id':uid,
           'name':_nameController.text,
           'email': _emailController.text,
           'shipping-address': _addressController.text,
           'userwhislist':[],
           'userCart':[],
           'CreatedAt':Timestamp.now()
         }

        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=> Btm_screeen()));
        print("Successfully registered");
      }
      on FirebaseException catch(error){
        GlobalVariable.waringDailog(title: "Auth Error", subtitle: "${error.message}", fn: (){Navigator.pop(context);}, context: context);
      }
      catch(err){
        setState(() {
          _isloading = false;
        });
      GlobalVariable.waringDailog(title: "error occured", subtitle: err.toString(), fn: (){
        Navigator.pop(context);
      }, context: context);
      }finally {
        setState(() {
          _isloading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: LoadingManager(
        isLoading:_isloading ,
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 120,),
                    TextWidget(title: "Welcome back", color: Colors.white, fontweight: 32,istitle: true,),
                    SizedBox(height: 10,),
                    TextWidget(title: "sign into to continue", color: Colors.white, fontweight: 16),
                    Form(
                        key: _key,
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete:()=> FocusScope.of(context).requestFocus(_email),
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Name field requiered";
                                }
                              },
                              style: TextStyle(
                                color: Colors.white
                              ),
                              decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: ()=> FocusScope.of(context).requestFocus(_passfocusnode),
                              controller: _emailController,
                              style: TextStyle(
                                color: Colors.white
                              ),
                              validator: (value){
                                if(value!.isEmpty || !value.contains('@')){
                                  return "Enter valid email";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)
                                ),
                                disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white
                                  )
                                )
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: ()=> FocusScope.of(context).requestFocus(_address),
                              obscureText: _obsture,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              style: TextStyle(
                                color: Colors.white
                              ),
                              validator: (value){
                                if(value!.isEmpty || value.length < 7){
                                  return "Enter valid password";
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: "password",
                                  suffix: InkWell(
                                    onTap: (){
                                      setState(() {
                                        _obsture = !_obsture;
                                      });
                                    },
                                    child:Icon(!_obsture? Icons.visibility_off :Icons.visibility,color: Colors.white,),
                                  ),
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white
                                      )
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white
                                      )
                                  )
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              onEditingComplete: ()=>_submitForm(),
                              controller: _addressController,
                              style: TextStyle(
                                  color: Colors.white
                              ),
                              validator: (value){
                                if(value!.isEmpty ){
                                  return "Enter valid address";
                                }
                              },
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                  hintText: "Shipping Address",
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white
                                      )
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white)
                                  ),
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white
                                      )
                                  )
                              ),
                            )
                          ],
                        )),
                    SizedBox(height: 10,),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(onPressed: (){}, child: Text(
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
                    SizedBox(height: 30,),
                   _isloading? Center(child: SpinKitCircle(color: Colors.white,)): Authbtn(
                       buttontext: "Register", fcn: (){
                         _submitForm();
                   }
                   ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        TextWidget(title: "have an account? ", color: Colors.white, fontweight: 18),
                        SizedBox(width: 5,),
                        InkWell(
                          onTap: (){
                            GlobalVariable.routeTo(context: context, routeName: LoginPage.routeName);
                          },
                          child: Text(
                            "Sign in",
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
            ),
          ],
        ),
      ),
    );
  }
}
