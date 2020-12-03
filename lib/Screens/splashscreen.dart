import 'package:adventure_eye/Screens/usertimeline.dart';
import 'package:adventure_eye/database/globals.dart';
import 'package:adventure_eye/firebase/signinwithemail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'first_screen.dart';
//bool club ;

Future<bool> isSignedIn() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  is_signed_in = preferences.getBool('is_signed_in'??false);
  if(is_signed_in)
    return true;
  else
    return false;
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {



    bool is_signed_in=false;
    print("checking is signed in ");
    isSignedIn().then((value) {
      print("user is signed in ? $value");
      is_signed_in=value;
      if(is_signed_in){
        SharedPreferences.getInstance().then((pref) {
          String email=pref.getString("user_email");
          String password=pref.getString("user_password");
          print("signing in with email $email and password $password");
          signInWithEmail(email, password).then((value) {
            print("user logged in with ID ${firebase_user.uid}");
            Firestore.instance.collection('users').document(firebase_user.uid).get().then((user_docsnp) {
              user_document_snapshot= user_docsnp;
              is_club = user_docsnp['club'];
              assert(user_document_snapshot!= null);
            });
          });
        });
      }
    });

    Future.delayed(
        Duration(
          milliseconds: 2000,
        ), () {
      Widget first_screen = null;

    //  Future<bool> is_sigend_in = firebase_user
    //  print("val:$is_sigend_in");

       !is_signed_in
            ? first_screen = FirstScreen()
            : first_screen = UserTimeline();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => first_screen),
        );


    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build of splash screen");

    return Scaffold(
      body: Container(
        color: Colors.black12,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                  "assets/Adventure_Eye_Logo.png",
                height: 220,
                width: 220,
              )
            ],
          ),
        ),
      ),
    );
  }
}