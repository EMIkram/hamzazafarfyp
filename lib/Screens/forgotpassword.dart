import 'package:adventure_eye/firebase/signinwithemail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



TextEditingController _email_verification=TextEditingController();
class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password"
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              CircleAvatar(

                radius: 100,
                backgroundColor: Colors.black38,

                child: Icon(
                  Icons.lock_outline,
                  size: 150,
                ),
              ),SizedBox(
                height: 10,
              ),

              Text("Forgot password?",
                style: TextStyle(
                fontSize: 20,
                  fontWeight: FontWeight.w900
              ),
              ),
        SizedBox(
        height: 10,
    ),
              Text("Enter your email for verification?",
                style: TextStyle(
                fontSize: 15
              ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(


                controller: _email_verification,
              //  controller: numb_persons,
                validator: (value) {
                  if (value.isEmpty) {

                  }
                  return null;
                },
                // controller: name_controller,
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
                        Radius.circular(45.0),

                      ),
                    ),
                    filled: true,
                    fillColor: Color.fromRGBO(150, 150, 150, 100.0),
                    prefixIcon: Icon(
                      Icons.phonelink_lock,
                      color: Colors.black,
                    ),
                    hintText: 'enter your email',
                    hintStyle: TextStyle(fontSize: 18.0)),
                style:
                TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 120.0,
                    height: 50.0,

                    child: FlatButton(
                        splashColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),

                            side:
                            BorderSide(color: Colors.white, width: 0)),
                        padding: const EdgeInsets.all(15),
                        color: Color(0xFF50C788),
                        child: Text(
                          "Send",style: TextStyle(
                            fontSize: 18
                        ),
                        ),
                        //On Pressed
                        onPressed: () {
                          print(_email_verification.text.toString().trim());
                           auth.sendPasswordResetEmail(email: _email_verification.text.toString().trim())
                               .then((value) {
                                 print('Success Response!!!');
                           })
                               .catchError((error) {
                             print('Catch ERROR::: $error');
                           });

                        }
                    ),
                  ),

                ],
              ),
            ],

          ),
        ),
      ),
    );
  }
}
