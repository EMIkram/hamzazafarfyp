import 'package:adventure_eye/Screens/clubtimeline.dart';
import 'package:adventure_eye/Screens/first_screen.dart';
import 'package:adventure_eye/Screens/mapscreen.dart';
import 'package:adventure_eye/Screens/registerclub.dart';
import 'package:adventure_eye/Screens/trips.dart';
import 'package:adventure_eye/Screens/userprofilemanagement.dart';
import 'package:adventure_eye/Screens/usertimeline.dart';
import 'package:adventure_eye/database/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adventure_eye/firebase/signinwithemail.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String switch_mode = "...";
  Text name =Text(' ');
@override
  void initState() {

setState(() {
  name = Text(user_name,
      style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold));
});


    bool is_registered =false ;
      getUserDoc().then((user) {
        is_registered= user['club'];
        setState(() {
          user_name=user["name"];
          user_email=user["email"];
        });
        setState(() {
          if(!is_registered){
            switch_mode = "Register club";
          }
          else
            SharedPreferences.getInstance().then((value){
              setState(() {
                mode = value.getString('user_mode');
                if(mode == "club"){switch_mode= "Switch as user";}
                if(mode == "user"){switch_mode= "Switch as club";}
              });

            });

      });
    }
    );
 super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.8),
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              arrowColor: Colors.white,
              accountName: Text(user_name,style: TextStyle(
                  fontSize: 25.0,
              ),
              ),

              //name==null? "...": name,
              accountEmail: Text(user_email,
              //  user_document_snapshot['email'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.black45,
                //Implement avatar photo ternary operator here
                child: Text(
               user_name[0],
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder:  (context) => UserProfile()
              ));
            },
              leading: Icon(
                Icons.account_circle,
                color: Color(0xFF50C788),
                size: 35.0,
              ),
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 18.0, color: Colors.greenAccent),
              ),
            ),
            Divider(
              color: Color(0xFF50C788),
              height: 2,
              endIndent: 20.0,
              indent: 20.0,
            ),
            ListTile(onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=>TripScreen(

              )));
            },
              leading: Icon(
                Icons.airplanemode_active,
                color: Color(0xFF50C788),
                size: 35.0,
              ),
              title: Text(
                "Trips",
                style: TextStyle(fontSize: 18.0, color: Colors.greenAccent),
              ),
            ),
            Divider(
              color: Color(0xFF50C788),
              height: 2,
              endIndent: 20.0,
              indent: 20.0,
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> MapScreen()
                ));
              },
              leading: Icon(
                Icons.map,
                color: Color(0xFF50C788),
                size: 35.0,
              ),
              title: Text(
                "Explore",
                style: TextStyle(fontSize: 18.0, color: Colors.greenAccent),
              ),
            ),
            Divider(
              color: Color(0xFF50C788),
              height: 2,
              endIndent: 20.0,
              indent: 20.0,
            ),
            ListTile(onTap: () async{




              if(mode== "user")
              {
                DocumentSnapshot user_doc;
                getUserDoc().then((value) {
                  user_doc = value;
                  if(user_doc['club']==true){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>ClubTimeline()
                    ));
                  }
                  if(user_doc['club']==false){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>RegisterClub()
                    ));
                  }
                }

                );}
             if(mode== "club")
               {
                 Navigator.pop(context);
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>UserTimeline()));
               }

            },
              leading: Icon(
                Icons.swap_horiz,
                color: Color(0xFF50C788),
                size: 35.0,
              ),
              title: Text(
                "$switch_mode",
                style: TextStyle(fontSize: 18.0, color: Colors.greenAccent),
              ),
            ),
            Divider(
              color: Color(0xFF50C788),
              height: 2,
              endIndent: 20.0,
              indent: 20.0,
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Color(0xFF50C788),
                size: 35.0,
              ),
              title: Text(
                "Sign out",
                style: TextStyle(fontSize: 18.0, color: Colors.greenAccent),
              ),
              onTap: ()   async{

              bool is_signedin =  await  signOut();

              if(is_signedin==false){
              Navigator.popUntil(context, (route) =>Navigator == null);
             Navigator.push(context, MaterialPageRoute(
                       builder:  (context) => FirstScreen()
                   )
                   );}
              else
                print("not signed in ");
           //
           //
           //     bool is_signed_out;
//
           //     is_signed_out = await signOut();
           //
           //
           //
           //   if(is_signed_out){
           //     print("if condition in sign out button ");
//
           //     print(is_signed_out);
           //     //  Navigator.popUntil(context, (route) =>Navigator == null);
//
           //     Navigator.push(context, MaterialPageRoute(
           //         builder:  (context) => FirstScreen()
           //     )
           //     );
           //   }
           //   else
           //     print("there is some error");

              },
            ),
            Divider(
              color: Color(0xFF50C788),
              height: 2,
              endIndent: 20.0,
              indent: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
