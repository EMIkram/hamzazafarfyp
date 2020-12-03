import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool  is_club=false;
String mode = 'user';
bool is_signed_in;
FirebaseUser firebase_user ;
DocumentSnapshot user_document_snapshot;
String user_name=' ';
String user_email=' ';




Future<SharedPreferences>  getSharedPref()  async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}


