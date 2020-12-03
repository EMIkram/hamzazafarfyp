import 'package:adventure_eye/NewAccount.dart';
import 'package:adventure_eye/main.dart';
import 'package:adventure_eye/widgets/image_logo.dart';
import 'package:adventure_eye/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../NewAccount.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'mapscreen.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF2A8DEE)),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //image/logo
            ImageLogo(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextField(
                decoration: InputDecoration(labelText: "Email:"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: "Password:"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: MyButton(
                    buttonHeight: 70,
                    buttonWidth: 0.45,
                    buttonText: 'login',
                    borderRadiusGeometry: BorderRadius.all(Radius.circular(15)),
                    onPressed: () {
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: 'testing123@gmail.com', password: 'test123');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MapScreen()));
                    },
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 20),
                  child: Container(
                    alignment: Alignment.center,
                    height: 70,
                    width: 184,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewAccount()));
                    },
                    child: Text(
                      'Create new account',
                      style: TextStyle(
                          color: Color(0xFF2A8DEE),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
