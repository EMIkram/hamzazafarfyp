import 'dart:math';
import 'package:adventure_eye/Screens/login.dart';
import 'package:adventure_eye/widgets/image_logo.dart';
import 'package:adventure_eye/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'NewAccount.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Screens/splashscreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // the problem is here of the type Future<bool> instance

    Random rnd = new Random();
    int r = 1 + rnd.nextInt(5);
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
//        textTheme:GoogleFonts.mcLarenTextTheme(
//          Theme.of(context).textTheme,
//        ),
        primaryColor: Colors.greenAccent,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor:  Colors.greenAccent,
          ),

          buttonColor:  Colors.greenAccent,
        backgroundColor:  Colors.greenAccent,
        scaffoldBackgroundColor: Color(0xffF7F7F7),
      ),
      home: SplashScreen(), //SplashScreen to Implement here
    );
  }
}

class MyHomePage extends StatelessWidget {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //image/logo
            ImageLogo(),
            MyButton(
              buttonHeight: 70,
              buttonWidth: 0.93,
              shapeColor: Color(0xFF2A8DEE),
              buttonText: 'Sign In with email',
              borderRadiusGeometry: BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MyButton(
                  buttonHeight: 70,
                  buttonWidth: 0.45,
                  shapeColor: Colors.indigo,
                  buttonText: 'Facebook',
                  borderRadiusGeometry: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
                MyButton(
                  buttonHeight: 70,
                  buttonWidth: 0.45,
                  shapeColor: Colors.red,
                  buttonText: 'Google',
                  borderRadiusGeometry: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                  ),
                  onPressed: () {
                    _handleSignIn();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewAccount()));
                  },
                  child: Text(
                    'Create new account',
                    style: TextStyle(
                        color: Color(0xFF2A8DEE),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
