import 'dart:io';
import 'package:adventure_eye/Screens/clubtimeline.dart';
import 'package:adventure_eye/Screens/requestoftrip.dart';
import 'package:adventure_eye/database/firestore.dart';
import 'package:adventure_eye/database/globals.dart';
import 'package:adventure_eye/firebase/signinwithemail.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostTrip extends StatefulWidget {
  @override
  _PostTripState createState() => _PostTripState();
}

class _PostTripState extends State<PostTrip> {
 // String trip_title = "";
 // int trip_seats ;
 // int trip_fair ;
 // String currency = "PKR";
 // String departure_location = "";
 // String trip_location = "";
 // DateTime departure_date_time = DateTime.now();
 // dynamic departure_date = "11 Sep, 2020";
//// departure_date_time.day;
 // dynamic departure_time = "10:00 pm";
//// departure_date_time.hour;
 // String club_name = "";
 // String photo_url ="";
  Trip post_trip = Trip();
  var  imageFile ;
  TextEditingController trip_other_details_ctrl =TextEditingController();
  TextEditingController trip_seats_ctrl=TextEditingController();
  TextEditingController trip_fare_ctrl=TextEditingController();
  TextEditingController departure_location_ctrl=TextEditingController();
  TextEditingController trip_location_ctrl=TextEditingController();
  TextEditingController departure_date_ctrl=TextEditingController();
  TextEditingController departure_time_ctrl=TextEditingController();
  TextEditingController trip_vehicle_ctrl=TextEditingController();
  TextEditingController trip_days_ctrl=TextEditingController();
  TextEditingController club_contact_ctrl=TextEditingController();

  @override
  void initState() {
    SharedPreferences.getInstance().then((cradentials)  {
      String email = cradentials.getString("user_email");
      String password= cradentials.getString("user_password");
      signInWithEmail(email, password);
    });
    Firestore.instance.collection('clubs').document(firebase_user.uid).get().then((club) {
      print("inint state ${firebase_user.uid}");
      print(club['total trips']);
      post_trip.club_name = club['club name'];
      post_trip.club_rating = club['club rating'];
      post_trip.trip_count = (club['total trips'])+1;
      post_trip.club_contact = club['club contact'];
      post_trip.image_location= "trips/${post_trip.club_name}/trip image${post_trip.trip_count}";
      print(post_trip.image_location);
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  Builder(
        builder:(BuildContext scafold_context)=> SingleChildScrollView(

          child:Column(
            children: [
             Stack(alignment: Alignment.bottomRight,
               children: [
                 Container(
                   color: Colors.greenAccent,
                   width: double.maxFinite,
                   height: 250,
                   child: imageFile ==null ? null: Image.file(File(imageFile.path),fit: BoxFit.cover,),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(bottom:10.0,right: 18),
                   child: CircleAvatar(
                     child: IconButton(
                       onPressed: ()  async{


                       ImagePicker().getImage(source: ImageSource.gallery).then((img) {
                           setState(() {
                             imageFile = img;

                           });



                             StorageReference storage_ref = FirebaseStorage().ref().child(post_trip.image_location);
                             StorageUploadTask upload_task = storage_ref.putFile(File(imageFile.path));
                             upload_task.onComplete.then((value) {
                               storage_ref.getDownloadURL().then((url) {
                                 post_trip.photo_url =url;
                                 print(post_trip.photo_url);
                               });
                             });

                             // location pattren is trips/clubname/trip_image+totaltripcount+1.jpg
                           //  String image_location = "trips/MarqueeTours/image1.jpg";

                         });

                       },
                       icon: Icon(Icons.camera_alt),
                     ),
                   ),
                 )
               ],
             ),
              Padding(
                padding: const EdgeInsets.only(top:12.0,left: 25,right: 25,bottom: 12),
                child: Column(
                  children: [

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 70,
                      child: TextField(
                        maxLength: 25,
                          //todo
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
                              Icons.not_listed_location,
                              color: Colors.black,
                            ),
                            hintText: 'Departure Location',
                            hintStyle: TextStyle(fontSize: 18.0)),
                        style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                        controller: departure_location_ctrl,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: 70,
                      child: TextFormField(
                        maxLength: 25,
                        validator: (value) {
                          if (value.isEmpty) {
                            //code here
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
                              Icons.not_listed_location,
                              color: Colors.black,
                            ),
                            hintText: 'Trip Location',
                            hintStyle: TextStyle(fontSize: 18.0)),
                        style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                        controller: trip_location_ctrl,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: 50,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            //code here
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
                              Icons.calendar_today,
                              color: Colors.black,
                            ),
                            hintText: 'Date ',
                            hintStyle: TextStyle(fontSize: 18.0)),
                        style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                        controller: departure_date_ctrl,
                        onTap:  (){
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime.now(),
                               onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                print('confirm $date');
                                departure_date_ctrl.text= "${date.year}-${date.month}-${date.day}";
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            //code here
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
                              Icons.access_time,
                              color: Colors.black,
                            ),
                            hintText: 'Time',
                            hintStyle: TextStyle(fontSize: 18.0)),
                        style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                        controller: departure_time_ctrl,

                        onTap: (){
                          showModalBottomSheet(context: context, builder: (BuildContext bottom_sheet_context){
                            var time;
                            return Container(
                              height: 290,
                              child: Column(
                                children: [
                                  Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children:[
                                        FlatButton(
                                          child: Text("cancel",style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 16
                                          ),),
                                          onPressed: (){
                                            Navigator.pop(bottom_sheet_context);
                                          },
                                        ),
                                        FlatButton(
                                          child:Text("Done",style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16
                                          ),),
                                          onPressed: (){
                                            if(time.hour>12)
                                            {
                                              departure_time_ctrl.text="${(time.hour)-12}:${time.minute} PM";
                                            }
                                            else if(time.hour<12)
                                            {
                                              departure_time_ctrl.text="${time.hour}:${time.minute} AM";
                                            }
                                            else if(time.hour==12)
                                            {
                                              departure_time_ctrl.text="${time.hour}:${time.minute} PM";
                                            }
                                            Navigator.pop(bottom_sheet_context);
                                          },
                                        )
                                      ]
                                  ),
                                  TimePickerSpinner(
                                    is24HourMode: false,
                                    normalTextStyle: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black54
                                    ),
                                    highlightedTextStyle: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black
                                    ),
                                    spacing: 50,
                                    itemHeight: 80,
                                    isForce2Digits: true,
                                    onTimeChange: (my_time) {
                                      time = my_time;
                                    },
                                  ),
                                ],
                              ),
                            );

                          });
//                        DatePicker.showTimePicker(context,
//                            showTitleActions: true,
//
//                            showSecondsColumn: false,
//                            onChanged: (time) {
//                              print('change $time');
//                            }, onConfirm: (time) {
//                              print('confirm $time');
//
//                              departure_time_cntrlr.text = "${time.hour}:${time.minute}";
//
//                            });
                        },
                        readOnly: true,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 70,
                      child: TextFormField(
                        maxLength: 2,
                        keyboardType: TextInputType.number,
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
                              Icons.airline_seat_recline_extra,
                              color: Colors.black,
                            ),
                            hintText: 'Total seats',
                            hintStyle: TextStyle(fontSize: 18.0)),
                        style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                        controller: trip_seats_ctrl,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: 70,
                      child: TextFormField(
                        maxLength: 25,
                       // keyboardType: TextInputType.number,
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
                              CupertinoIcons.bus,
                              color: Colors.black,
                            ),
                            hintText: 'Vehicle type',
                            hintStyle: TextStyle(fontSize: 18.0)),
                        style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                        controller: trip_vehicle_ctrl,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: 70,
                      child: TextFormField(
                        maxLength: 3,
                        keyboardType: TextInputType.number,
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
                              Icons.view_day,
                              color: Colors.black,
                            ),
                            hintText: 'Trip days',
                            hintStyle: TextStyle(fontSize: 18.0)),
                        style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                        controller: trip_days_ctrl,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: 70,
                      child: TextFormField(
                        maxLength: 5,
                        keyboardType: TextInputType.number,
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
                              Icons.attach_money,
                              color: Colors.black,
                            ),
                            hintText: 'Fare per seat',
                            hintStyle: TextStyle(fontSize: 18.0)),
                        style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                        controller: trip_fare_ctrl,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: 70,

                      child: TextField(
                        onEditingComplete: (){
                          print("on editing complete");
                          if((club_contact_ctrl.text.trim().length!=11)||club_contact_ctrl.text.contains("-")||club_contact_ctrl.text.contains(".")||club_contact_ctrl.text.contains(",")||club_contact_ctrl.text.contains(" ")){
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
                        controller: club_contact_ctrl,
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
                            hintText: 'Contact',
                            hintStyle: TextStyle(fontSize: 20.0)),
                        style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      child: TextField(
                        minLines: 1,
                        maxLines: 1,
                        maxLength: 300,

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
                              Icons.description,
                              color: Colors.black,
                            ),

                            hintText: 'Other details',
                            hintStyle: TextStyle(fontSize: 18.0)),
                        style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                        controller: trip_other_details_ctrl,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
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
                            child: Text(
                              "Post",style: TextStyle(
                                fontSize: 18
                            ),
                            ),
                            //On Pressed

                            onPressed: (){
                            if(departure_location_ctrl.text==""||trip_location_ctrl.text==""||departure_date_ctrl.text==""||departure_time_ctrl.text==""
                            ||trip_seats_ctrl.text==""||trip_vehicle_ctrl.text==""||trip_days_ctrl.text==""||trip_fare_ctrl.text==""
                            ||club_contact_ctrl.text==""||trip_other_details_ctrl.text=="")
                            {
                              Scaffold.of(scafold_context
                              ).showSnackBar(SnackBar(content: Text(
                                "Please fill all fields\n ", style:
                              TextStyle(
                                  fontSize: 20
                              ),),
                                duration: Duration(milliseconds: 3200),
                                backgroundColor: Colors.black87,
                              )
                              );

                            }
                            else   if((club_contact_ctrl.text.trim().length!=11)||club_contact_ctrl.text.contains("-")||club_contact_ctrl.text.contains(".")||club_contact_ctrl.text.contains(",")||club_contact_ctrl.text.contains(" ")) {
                              print("under if statement");
                              Scaffold.of(scafold_context
                              ).showSnackBar(SnackBar(content: Text(
                                "Please enter a valid phone number\n ", style:
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
                              print("checking post trip fiels");
                              post_trip.departure_location = departure_location_ctrl.text.toString().trim();
                              post_trip.trip_location = trip_location_ctrl.text.toString().trim();
                              post_trip.departure_date = departure_date_ctrl.text.toString().trim();
                              post_trip.departure_time = departure_time_ctrl.text.toString().trim();
                              post_trip.trip_seats =int.parse( trip_seats_ctrl.text.toString().trim());
                              post_trip.vehicle_type = trip_vehicle_ctrl.text.toString().trim();
                              post_trip.trip_fare = int.parse(trip_fare_ctrl.text.toString().trim());
                              post_trip.other_details = trip_other_details_ctrl.text.toString().trim();
                              post_trip.trip_days = int.parse(trip_days_ctrl.text.toString().trim());
                              post_trip.trip_type = "club";
                              post_trip.club_contact=club_contact_ctrl.text;
                              post_trip.booked_seats=0;
                              post_trip.date_of_post=DateTime.now();
                              post_trip.club_ID=firebase_user.uid;



                              print("about to call post trip ");
                              post_trip.addTrip();
                              //
                              //
                              print(post_trip.image_location);
                               post_trip= null;
                               trip_other_details_ctrl =null;
                               trip_seats_ctrl=null;
                               trip_fare_ctrl=null;
                               departure_location_ctrl=null;
                               trip_location_ctrl=null;
                               departure_date_ctrl=null;
                               departure_time_ctrl=null;
                               trip_vehicle_ctrl=null;
                               trip_days_ctrl=null;
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ClubTimeline()));
                            }}
                          ),
                        ),
                      ],
                    ),






                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
