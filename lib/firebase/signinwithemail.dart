
import 'package:adventure_eye/database/globals.dart';
import 'package:adventure_eye/firebase/signInWithGoogle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseAuth auth =FirebaseAuth.instance;
Future<String> signInWithEmail( String email,String password) async{

  SharedPreferences preferences = await getSharedPref();
try{
  AuthResult result = await auth.signInWithEmailAndPassword(email: email, password: password);
  firebase_user = result.user;
  if(firebase_user!= null){
   preferences.setBool("is_signed_in", true);
   preferences.setString("firebase_user_uid",firebase_user.uid) ;
   preferences.setString("user_email", email);
   preferences.setString("user_password", password);
  }
//print(firebase_user.photoUrl);
return "User Logged in";
}

catch(e){
  print('exception caught');
  print(e.code);
  SnackBar(content: Text(e.code),);
  switch(e.code){
    case 'ERROR_INVALID_EMAIL':
      print('error invalid emaillllllllllllllllll');
  }
  return e.code;
}

}

 Future<FirebaseUser>  signUp( {String email,String password}) async{
  print("signup method entereddddd");
  try{
    AuthResult result= await auth.createUserWithEmailAndPassword(email: email, password: password);
    SharedPreferences preferences = await getSharedPref();
    firebase_user = result.user;
    if(firebase_user!= null){
      preferences.setBool("is_signed_in", true);
      is_signed_in = preferences.getBool('is_singed_in')?? true ;
      preferences.setString("firebase_user_uid", firebase_user.uid);
      print("pref"+'is_signed_in');
      preferences.setString("user_email", email);
      preferences.setString("user_password", password);
    }
    return firebase_user;
  }
  catch(e){
    print("exception caught");
    print(e.code);
    SnackBar(content: Text(e.code),);

  }

}

 Future<bool>  signOut() async{
 await auth.signOut();
 SharedPreferences preferences = await getSharedPref();
 is_signed_in = false;
 preferences.clear();
 preferences.setBool('is_signed_in', false);
 return preferences.getBool('is_signed_in')?? false;
// auth.onAuthStateChanged
//     .listen((FirebaseUser user) {
//   if (user == null) {
//     print('User is currently signed out!');
//     return true;
//   }
//   else {
//     print('User is signed in!');
//     return Future.value(false);
//   }
// }
// );
}
