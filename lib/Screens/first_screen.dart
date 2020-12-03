import 'dart:math';
import 'package:adventure_eye/Screens/createaccount.dart';
import 'package:adventure_eye/Screens/forgotpassword.dart';
import 'package:adventure_eye/Screens/usertimeline.dart';
import 'package:adventure_eye/firebase/signInWithGoogle.dart';
import 'package:adventure_eye/firebase/signinwithemail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
TextEditingController _email_cntrlr= TextEditingController() ;
TextEditingController _password_cntrlr =TextEditingController() ;


forgotPassword(){
}


class FirstScreen extends StatefulWidget {

  // int r;
  @override
  _FirstScreenState createState() => _FirstScreenState();
}
String _error_text="";
class _FirstScreenState extends State<FirstScreen> {
  Image img = bgselector();

  @override
  Widget build(BuildContext context) {
    double screen_width = (MediaQuery.of(context).size.width);
    double screen_height = (MediaQuery.of(context).size.height);
    print("width: $screen_width");
    print("height: $screen_height");


    return Scaffold(

      body: Builder(
        builder: (scaffold_context) => Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: screen_height,
                width: screen_width,
                child: img,

              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                    ),
//                    Container(
//                      height: 250,
//                      width: 250,
//                      child:Image.asset("assets/Adventure_Eye_Logo.png")),
                    SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, bottom: 10),
                      child: Container(
                        height: 55,
                        child: TextFormField(
//                        validator: (emailtxt){
//                          // ignore: missing_return
//                          EmailValidator.validate(emailtxt);
//                          if(EmailValidator.validate(emailtxt)==true)
//                            {}
//                        },
                          controller: _email_cntrlr,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (emailtxt){
                            print(emailtxt);
                            print(_email_cntrlr.text);
                          },
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF50C788), width: 3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40.0),
                                ),
                              ),
                              focusColor: Color(0xFF50C788),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.greenAccent, width: 3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40.0),
                                ),
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(150, 150, 150, 100.0),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.black,
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(fontSize: 20.0)),
                          style:
                              TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 10),
                      child: Container(
                        height: 55,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                        // obscuringCharacter: "-",
                          controller: _password_cntrlr,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF50C788), width: 3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.greenAccent, width: 3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40.0),
                                ),
                              ),
                              filled: true,
                              fillColor: Color.fromRGBO(150, 150, 150, 100.0),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(fontSize: 20.0)),
                          style:
                              TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, right: 40.0, bottom: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 120.0,
                            height: 45.0,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side:
                                      BorderSide(color: Colors.greenAccent, width: 0)),
                              padding: const EdgeInsets.all(15),
                              color: Colors.greenAccent,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.black87,
                              ),
                              //On Pressed
                              onPressed: ()  {
                                print(_email_cntrlr.text);
                               if(_password_cntrlr.text.trim()==""|| _email_cntrlr.text.trim()=="")
                                 {

                                   setState(() {
                                     _error_text= "Fill both fields";
                                     Scaffold.of(scaffold_context).showSnackBar(SnackBar(content: Text("Fill both fields\n ",style: TextStyle(
                                         fontSize: 20
                                     ),),
                                       duration: Duration(milliseconds: 3200),
                                       backgroundColor: Colors.black87,
                                     )
                                     );
                                   });
                                 }
                               else if((!_email_cntrlr.text.toString().trim().contains("@"))||(!_email_cntrlr.text.toString().trim().contains(".")))
                                 {
                                   Scaffold.of(scaffold_context).showSnackBar(SnackBar(content: Text("Invalid email\n ",style: TextStyle(
                                       fontSize: 20
                                   ),),
                                     duration: Duration(milliseconds: 3200),
                                     backgroundColor: Colors.black54,
                                   )
                                   );
                                 }
                              else
                                {
                                  print(_email_cntrlr.text);
                                  print(_password_cntrlr.text);
                                  signInWithEmail(_email_cntrlr.text,_password_cntrlr.text).then((value) async {
                                    if(value=="User Logged in")
                                      { SharedPreferences preferences = await SharedPreferences.getInstance();

                                        preferences.setString("user_email", _email_cntrlr.text.trim());
                                        preferences.setString("user_password", _password_cntrlr.text.toString().trim());
                                        print("preferances stored email: ${preferences.getString("user_email")} and password: ${preferences.getString("user_password")}");
                                        _email_cntrlr.clear();
                                      _password_cntrlr.clear();
                                      Navigator.pop(context);
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context){
                                            return UserTimeline();
                                          }
                                      ));}
                                    else
                                      {
                                        Scaffold.of(scaffold_context).showSnackBar(SnackBar(content: Text("$value\n ",style: TextStyle(
                                            fontSize: 20
                                        ),),
                                          duration: Duration(milliseconds: 3200),
                                          backgroundColor: Colors.black54,
                                        )
                                        );
                                      }

                                  });

                                }

                                //----------------------------------------------------------Login  button--------------------------------
                                //to do code og login button
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      children: <Widget>[
//
//                        Container(
//                          //color: Colors.white,
//                          child: FlatButton(
//                            //highlightColor: Colors.white,
//                            onPressed: () {
//
//                            Future<FirebaseUser> user = gSignIn();
//                            gSignIn().whenComplete(() {
//                              print(user);
//                              Navigator.of(context).push(
//                                MaterialPageRoute(
//                                  builder: (context) {
//                                    return UserTimeline();
//                                  },
//                                ),
//                              );
//                            });
//                            },
//                            child: Container(
//                              width: 50,
//                              height: 50,
//                              child: Image.asset(
//                                'assets/icons/google.png',
//                                //height: double.maxFinite,
//                              ),
//                            ),
//                          ),
//                        ),
//
//                      ],
//                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>SignupScreen()));
                        },
                        color:Color(0xFF50C788),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                            ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () {
                          forgotPassword();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>ForgotPassword()));
                        },
                        color: Color(0xFF50C788),
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              ),
                        ),
                      ),
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

//----------------------------background image selector----------------------
Image bgselector() {
  Random rnd = new Random();
  int r = 1 + rnd.nextInt(8);

  if (r == 1)
    return Image.asset(
      'assets/h bg/nouman-younas-TM4522xcNRs-unsplash1.jpg',
      //height: double.maxFinite,
      fit: BoxFit.cover,
    );if (r == 2)
    return Image.asset(
      'assets/h bg/nouman-younas-TM4522xcNRs-unsplash2.jpg',
      //height: double.maxFinite,
      fit: BoxFit.cover,
    );
  if (r == 3)
    return Image.asset(
      'assets/h bg/shuttergames-JanrPdFFXso-unsplash.jpg',
      //height: double.maxFinite,
      fit: BoxFit.cover,
    );
  if (r == 4)
    return Image.asset(
      'assets/h bg/gayatri-malhotra-CqpuJml_Fzo-unsplash.jpg',
      //height: double.maxFinite,
      fit: BoxFit.cover,
    );
  if (r == 5)
    return Image.asset(
      'assets/h bg/andrey-bond-t8fEOfpVfck-unsplash.jpg',
      //height: double.maxFinite,
      fit: BoxFit.cover,
    );
  if (r == 6)
    return Image.asset(
      'assets/h bg/leanncaptures-hQtfriKFMVw-unsplash.jpg',
      //height: double.maxFinite,
      fit: BoxFit.cover,
    );
  if (r == 7)
    return Image.asset(
      'assets/h bg/emily-liang-hpZdBhkUClk-unsplash1.jpg',
      //height: double.maxFinite,
      fit: BoxFit.cover,
    );
  if (r == 8)
    return Image.asset(
      'assets/images/bg11.jpg',
      //height: double.maxFinite,
      fit: BoxFit.cover,
    );
}

