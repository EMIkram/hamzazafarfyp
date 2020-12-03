import 'package:adventure_eye/Screens/usertimeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//
//final GoogleSignIn googleSignIn = GoogleSignIn();
//final FirebaseAuth auth = FirebaseAuth.instance;
//
//
//Future<User> _handleSignIn() async {
//  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//  final GoogleSignInAuthentication gsa =
//  await googleSignInAccount.authentication;
//
//  final AuthCredential credential = GoogleAuthProvider.credential(
//    idToken: gsa.idToken,
//    accessToken: gsa.accessToken,
//  );
//  final UserCredential authResult = await auth.signInWithCredential(credential);
//  final User firebaseUser = authResult.user;
// // name = firebaseUser.displayName;
// // email = firebaseUser.email;
// // imageUrl = firebaseUser.photoURL;
//  final User currentUser = await auth.currentUser;
//  assert(firebaseUser.uid == currentUser.uid);
//  return firebaseUser;
//}
//
//
//void onGoogleSignIn(BuildContext context) async {
//  User user = await _handleSignIn();
//  _handleSignIn().whenComplete(() {
//    Navigator.push(
//        context,
//        MaterialPageRoute(
//            builder: (context) =>
//                UserTimeline(user:user, googleSignIn: googleSignIn,)));
//  });}
//
//