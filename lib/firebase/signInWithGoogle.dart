




import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();
FirebaseUser user;

Future<FirebaseUser> gSignIn() async {
  GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
 // final AuthResult authResult = await _auth.signInWithCredential(credential);
 // user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);
  //FirebaseUser user = await _auth.currentUser();
  print(user.displayName);
  return user;
  //  await _auth.signInWithGoogle(idToken: null, accessToken: null);
}


void signOutGoogle() async {
  await _googleSignIn.signOut();

  print("User Sign Out");
}

Future<bool> isSignedIn() async {
  // if (await FirebaseAuth.instance.currentUser() != null) {
  //   return true;
  // } else {
  //   return false;
  // }
  if (await _googleSignIn.isSignedIn()) {
    print("user signed in");
    return true;
  } else {
    print("user is not signed in");
    return false;
  }
}
Future<bool> signout() async {
  if(isSignedIn()== true){
     _googleSignIn.signOut();
     print("sign out done");
  _auth.signOut();
  return true;}
  else
  if(isSignedIn()==false)
    return true;
  }

