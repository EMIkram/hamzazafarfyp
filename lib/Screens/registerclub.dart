import 'package:adventure_eye/Screens/clubtimeline.dart';
import 'package:adventure_eye/database/firestore.dart';
import 'package:adventure_eye/database/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RegisterClub extends StatelessWidget {
  Firestore firestore = Firestore.instance;
  TextEditingController club_name_controller = TextEditingController();
  TextEditingController club_location_controller = TextEditingController();
  TextEditingController club_contact_controller = TextEditingController();

  String club_name="Marquee tours";
  String club_ID;
  String user_ID;
  String user_name;
  String photo_URL;
  LatLng club_location;
  String club_contact;
  double rating;
  int total_trips;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register Club"),
          centerTitle: true,
        ),
        body:Builder(
          builder:(BuildContext scaffold_context)=>  Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[


//todo add image picker and avatar , uncomment following lines
//            Stack(alignment: Alignment.bottomRight,
//         children: [
//           CircleAvatar(
//
//             backgroundColor: Colors.black26,
//             radius: 60,
//             child:  Text(
//              club_name[0],
//               style: TextStyle(fontSize: 50.0),
//             ),
//           ),
//           CircleAvatar(
//               radius: 20,
//               child: Icon(
//                 Icons.camera_alt,
//                 color: Colors.black54,
//                 size: 20,)
//           ),
//         ],
//       ),

                  Container(
                    height: 70,
                    child: TextField(
                      maxLength: 20,
                       controller: club_name_controller,
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
                            Icons.home,
                            color: Colors.black,
                          ),
                          hintText: 'Club name',
                          hintStyle: TextStyle(fontSize: 20.0)),
                      style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: TextField(
                      maxLength: 20,
                       controller: club_location_controller,
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
                            Icons.location_on,
                            color: Colors.black,
                          ),
                          hintText: 'Club location',
                          hintStyle: TextStyle(fontSize: 20.0)),
                      style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                    ),
                  ),
                  Container(
                    height: 70,
                    child: TextField(
                      keyboardType: TextInputType.number,
                       maxLength: 11,
                       controller: club_contact_controller,
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
                            Icons.phone,
                            color: Colors.black,
                          ),
                          hintText: 'Club contact',
                          hintStyle: TextStyle(fontSize: 20.0)),
                      style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                    ),
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
                          onPressed: (){
                            if(club_contact_controller.text.toString()== "" ||
                                club_location_controller.text.toString()== ""||
                                club_name_controller.text.toString()==""
                            )
                            {
                              Scaffold.of(scaffold_context).showSnackBar(SnackBar(content: Text("Fill all fields\n ",style:
                              TextStyle(
                                  fontSize: 20
                              ),),
                                duration: Duration(milliseconds: 3200),
                                backgroundColor: Colors.black87,
                              )
                              );
                            }

                            else
                            {
                              Club club = Club(club_name: club_name_controller.text.toString(),
                              club_contact: club_contact_controller.text.toString(),
                                club_location: club_location_controller.text.toString(),total_trips: 0,
                                club_rating:5.0
                              );
                              club.resisterClub();
                              Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context)=> ClubTimeline()
                            )
                            ) ;
                            }
                                                  },
                          splashColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side:
                              BorderSide(color: Colors.greenAccent, width: 2)),
                          padding: const EdgeInsets.all(15),
                          color: Colors.greenAccent,
                          child: Text("Register",
                            style: TextStyle(
                            fontSize: 18,

                          ),)
                          //On Pressed

                        ),
                      ),
                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
