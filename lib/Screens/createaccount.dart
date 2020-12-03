import 'package:adventure_eye/Screens/first_screen.dart';
import 'package:adventure_eye/Screens/usertimeline.dart';
import 'package:adventure_eye/database/firestore.dart';
import 'package:adventure_eye/database/globals.dart';
import 'package:adventure_eye/firebase/signinwithemail.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:developer';

import 'package:flutter/rendering.dart';
TextEditingController name_controller  = TextEditingController();
TextEditingController email_controller = TextEditingController();
TextEditingController phone_controller = TextEditingController();
TextEditingController CNIC_controller = TextEditingController();
TextEditingController password_controller = TextEditingController();
TextEditingController confirm_password_controller = TextEditingController();

TextEditingController gender_controller = TextEditingController();

User user = User();



class SignupScreen extends StatefulWidget {


  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Color TFbordercolor= Color(0xFF50C788);
  Color border_color(){
    setState(() {
      print(password_controller.text);
      print(confirm_password_controller.text);
if(password_controller.text== confirm_password_controller.text) {
  TFbordercolor = Color(0xFF50C788);
}
else
  TFbordercolor = Colors.red;
    }
        );
}

  @override
  Widget build(BuildContext context) {
    double screen_width = (MediaQuery.of(context).size.width);
    double screen_height = (MediaQuery.of(context).size.height);
    print("width: $screen_width");
    print("height: $screen_height");

    return Scaffold(
      appBar: AppBar(
        title: Text("Create new account"),
        centerTitle: true,
      ),
      body: Builder(
        builder:(BuildContext scafold_context)=> Stack(
          children: [
            Container(
              height: screen_height,
              width: screen_width,
                child:Image.asset("assets/images/bg11.jpg",fit: BoxFit.cover,),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left:20.0,right: 20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 70,
                        child: TextField(
                          maxLength: 25,
                          controller: name_controller,
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
                                Icons.perm_identity,
                                color: Colors.black,
                              ),
                              hintText: 'Full name',
                              hintStyle: TextStyle(fontSize: 20.0)),
                          style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                        ),
                      ),
                      Container(
                        height: 75,
                        child: TextField(
                         // maxLines: 1,

                          minLines: 1,
                          maxLength: 25,

                          controller: email_controller,
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
                      Container(
                        height: 75,

                        child: TextField(
                          onEditingComplete: (){
                            print("on editing complete");
                            if((phone_controller.text.trim().length!=11)||phone_controller.text.contains("-")||phone_controller.text.contains(".")||phone_controller.text.contains(",")||phone_controller.text.contains(" ")){
                              print("under if statement");
                              Scaffold.of(scafold_context
                              ).showSnackBar(SnackBar(content: Text("Please enter a valid phone number\n ",style:
                              TextStyle(
                                  fontSize: 20
                              ),),
                                duration: Duration(milliseconds: 3200),
                                backgroundColor: Colors.black87,
                              )
                              );
                            }
                          },
                          maxLength: 11,
                          keyboardType: TextInputType.number,
                          controller: phone_controller,
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
                                Icons.phone_android,
                                color: Colors.black,
                              ),
                              hintText: 'Phone',
                              hintStyle: TextStyle(fontSize: 20.0)),
                          style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                        ),
                      ),

                      Container(
                        height: 75,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onEditingComplete: (){
                            if((CNIC_controller.text.trim().length!=11)||CNIC_controller.text.contains("-")||CNIC_controller.text.contains(" ")||CNIC_controller.text.contains(".")||CNIC_controller.text.contains(",")){
                              Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("Please enter a valid CNIC\n ",style:
                              TextStyle(
                                  fontSize: 20
                              ),),
                                duration: Duration(milliseconds: 3200),
                                backgroundColor: Colors.black87,
                              )
                              );
                            }
                          },
                          maxLength: 13,
                        controller: CNIC_controller,
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
                                Icons.attach_file,
                                color: Colors.black,
                              ),
                              hintText: 'CNIC without dashes',

                              hintStyle: TextStyle(fontSize: 20.0)),
                          style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                        ),
                      ),
                      Container(
                        height: 75,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onEditingComplete: (){
                            if(!gender_controller.text.contains("Male")||!gender_controller.text.contains("Female")||!gender_controller.text.contains("male")||!gender_controller.text.contains("female")||!gender_controller.text.contains("other")||!gender_controller.text.contains("Other")){
                              Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("Please enter Male,Female or Other\n ",style:
                              TextStyle(
                                  fontSize: 20
                              ),),
                                duration: Duration(milliseconds: 3200),
                                backgroundColor: Colors.black87,
                              )
                              );
                            }
                          },
                          maxLength: 13,
                          controller: gender_controller,
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
                                Icons.wc,
                                color: Colors.black,
                              ),
                              hintText: 'Gender',

                              hintStyle: TextStyle(fontSize: 20.0)),
                          style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                        ),
                      ),
                      Container(
                        height: 75,
                        child: TextField(
                          maxLength: 25,
                          onChanged: (mypassword){
                            print(mypassword);
                            border_color();
                          },
                          controller: password_controller,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: TFbordercolor, width: 3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: TFbordercolor, width: 3),
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
                      Container(
                        height: 75,
                        child: TextField(
                          maxLength: 25,
                          onChanged: (mypassword){
                            print(mypassword);
                            border_color();
                          },
                          controller: confirm_password_controller,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: TFbordercolor, width: 3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40.0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: TFbordercolor, width: 3),
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
                              hintText: 'Confirm password',
                              hintStyle: TextStyle(fontSize: 20.0)),
                          style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, right: 10.0, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 120.0,
                              height: 50.0,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    side:
                                    BorderSide(color: Colors.white, width: 0)),
                                padding: const EdgeInsets.all(15),
                                color: Color(0xFF50C788),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black87,
                                ),
                                //On Pressed
                                onPressed: () async{
                                  //debugger();

                                  if(name_controller.text.trim()==""||
                                  email_controller.text.trim()==""||
                                  phone_controller.text.trim()==""||
                                  CNIC_controller.text.trim()==""||
                                  password_controller.text.trim()==""||
                                  confirm_password_controller.text.trim()==""
                                  ){
                                    //todo display snack bar
                                    Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("Fill all fields\n ",style:
                                    TextStyle(
                                        fontSize: 20
                                    ),),
                                      duration: Duration(milliseconds: 3200),
                                      backgroundColor: Colors.black87,
                                    )
                                    );
                                  }
                                  else if(!(email_controller.text.trim().contains("@")&& email_controller.text.trim().contains(".") ))
                                    {
                                      //todo display snackbar of email validator
                                      Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("Invalid email\n ",style: TextStyle(
                                          fontSize: 20
                                      ),),
                                        duration: Duration(milliseconds: 3200),
                                        backgroundColor: Colors.black87,
                                      )
                                      );
                                    }
                                  else if(password_controller.text.trim()!=confirm_password_controller.text.trim())
                                  {
                                    Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("enter same password in both fields\n ",style: TextStyle(
                                        fontSize: 20
                                    ),),
                                      duration: Duration(milliseconds: 3200),
                                      backgroundColor: Colors.black87,
                                    )
                                    );
                                  }
                                 else if((phone_controller.text.trim().length!=11)||phone_controller.text.contains("-")||phone_controller.text.contains(".")||phone_controller.text.contains(" ")||phone_controller.text.contains(",")){
                                    Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("Please enter a valid phone number\n ",style:
                                    TextStyle(
                                        fontSize: 20
                                    ),),
                                      duration: Duration(milliseconds: 3200),
                                      backgroundColor: Colors.black87,
                                    )
                                    );
                                  }
                                 else  if((CNIC_controller.text.trim().length!=13)||CNIC_controller.text.contains("-")||CNIC_controller.text.contains(" ")||CNIC_controller.text.contains(".")||CNIC_controller.text.contains(",")){
                                    Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("Please enter a valid CNIC\n ",style:
                                    TextStyle(
                                        fontSize: 20
                                    ),),
                                      duration: Duration(milliseconds: 3200),
                                      backgroundColor: Colors.black87,
                                    )
                                    );
                                  }
                                 else  if(!gender_controller.text.contains("Male")&&!gender_controller.text.contains("Female")&&!gender_controller.text.contains("male")&&!gender_controller.text.contains("female")&&!gender_controller.text.contains("other")&&!gender_controller.text.contains("Other")){
                                    Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("Please enter Male,Female or Other as gender\n ",style:
                                    TextStyle(
                                        fontSize: 20
                                    ),),
                                      duration: Duration(milliseconds: 3200),
                                      backgroundColor: Colors.black87,
                                    )
                                    );
                                  }
                                 else {
                                    user.user_name= name_controller.text;
                                    user.email=email_controller.text;
                                    user.phone_no=phone_controller.text;
                                    user.cnic=CNIC_controller.text;
                                    user.gender=gender_controller.text;
                                    user.password=password_controller.text;
                                    print("signup calleddddddd");
                                    signUp(email: email_controller.text.toString().trim(), password:password_controller.text.toString().trim()).then((Value) {
                                      print('signup completed  '+Value.uid);
                                      user.user_ID = firebase_user.uid;
                                      user.addUser();

                                    });
                                    //to do code og login button
                                    print(name_controller.text);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=> UserTimeline()
                                    ));
                                 }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
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
// background selector function

