import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_proj/Screens/btm_screen.dart';
import 'package:flutter_proj/consts/firebaseconnection.dart';
import 'package:flutter_proj/services/GobalVariables.dart';
import 'package:flutter_proj/widgets/textWidget.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Googlebtn extends StatelessWidget {
  const Googlebtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _googleSignin() async {
      final googleSignin = GoogleSignIn();
      final googleAccount = await googleSignin.signIn();
      if (googleAccount != null) {
        final googleAuth = await googleAccount.authentication;
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          try {
            await authInstance.signInWithCredential(
                GoogleAuthProvider.credential(idToken: googleAuth.idToken,
                    accessToken: googleAuth.accessToken)
            );
            Navigator.of(context).push(MaterialPageRoute(builder:
                (context) => Btm_screeen()));
          }

          on FirebaseException catch (error) {
            GlobalVariable.waringDailog(title: "error occured",
                subtitle: '${error.message}', fn: () {}, context: context);
          }
          catch (error) {
            GlobalVariable.waringDailog(title: "error occured",
                subtitle: error.toString(), fn: () {}, context: context);
          }
          finally {

          }
        }
      }
    }
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: (){
          _googleSignin();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                color: Colors.white,
                child: Image.asset("assets/images/google.png",width: 40,)),
            SizedBox(width: 15,),
            TextWidget(title: "Sign with google", color: Colors.white, fontweight: 18)
          ],
        ),
      ),
    );
  }
}
