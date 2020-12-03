import 'package:adventure_eye/Screens/usertimeline.dart';
import 'package:adventure_eye/database/firestore.dart';
import 'package:adventure_eye/database/globals.dart';
import 'package:adventure_eye/widgets/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

final _post_request_formKey = GlobalKey<FormState>();



class RequestTrips extends StatefulWidget {

  @override
  _RequestTripsState createState() => _RequestTripsState();
}

class _RequestTripsState extends State<RequestTrips> {
  TextEditingController departure_location_cntrlr = TextEditingController();//assigned
  TextEditingController departure_date_time_cntrlr= TextEditingController();
  TextEditingController trip_location_cntrlr = TextEditingController();//assigned
  TextEditingController number_of_persons_cntrlr = TextEditingController();//assigned
  TextEditingController vehicle_type_cntrlr = TextEditingController();//assigned
  TextEditingController expected_fair_cntrlr = TextEditingController();//assigned
  TextEditingController other_details_cntrlr = TextEditingController();//assigned
  TextEditingController departure_date_cntrlr = TextEditingController();//assigned
  TextEditingController departure_time_cntrlr = TextEditingController();//assigned
  TextEditingController trip_days_cntrlr = TextEditingController();//assigned
  TextEditingController user_contact_cntrlr = TextEditingController();//assigned
  Trip post_request = Trip();

  @override
  void initState() {
    // TODO: implement initState
    Firestore.instance.collection("users").document(firebase_user.uid).get().then((user) {
      post_request.user_name= user["name"];
      post_request.user_contact=user["phone"];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("Request custom trip"),
      ),
      body: Builder(
        builder:(BuildContext scafold_context)=> SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:12.0,left: 25,right: 25,bottom: 12),
            child: Form(
              autovalidate: true,
              key: _post_request_formKey,

              child: Column(
                children: [
                  SizedBox(
                  height: 20,
                ),
                  Container(
                    height: 70,
                    child: TextFormField(
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
                            Icons.not_listed_location,
                            color: Colors.black,
                          ),

                          hintText: 'Departure Location',
                          hintStyle: TextStyle(fontSize: 18.0)),
                      style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      maxLength: 25,
                      controller: departure_location_cntrlr,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: 70,
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
                            Icons.not_listed_location,
                            color: Colors.black,
                          ),
                          hintText: 'Trip Location',
                          hintStyle: TextStyle(fontSize: 18.0)),
                      style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      maxLength: 25,
                      controller: trip_location_cntrlr,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: 50,
                    child: TextFormField(
                      readOnly: true,
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

                     // enabled: false,

                      controller: departure_date_cntrlr,
                      onTap:  (){
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime.now(),
                            onChanged: (date) {
                              print('change $date');
                            }, onConfirm: (date) {
                              print('confirm $date');
                              departure_date_cntrlr.text= "${date.year}-${date.month}-${date.day}";
                            }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 22,
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
                      controller: departure_time_cntrlr,

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
                                     departure_time_cntrlr.text="${(time.hour)-12}:${time.minute} PM";
                                   }
                                 else if(time.hour<12)
                                   {
                                     departure_time_cntrlr.text="${time.hour}:${time.minute} AM";
                                   }
                                 else if(time.hour==12)
                                   {
                                     departure_time_cntrlr.text="${time.hour}:${time.minute} PM";
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
                    height: 22,
                  ),
                  Container(
                    height: 70,
                    child: TextFormField(
                      onEditingComplete: (){
                        if(number_of_persons_cntrlr.text.trim()=="0"||number_of_persons_cntrlr.text.trim()=="00"
                            ||number_of_persons_cntrlr.text.trim()==""||number_of_persons_cntrlr.text.trim().contains("-")
                            ||number_of_persons_cntrlr.text.trim().contains(".")||number_of_persons_cntrlr.text.trim().contains(",")
                            ||number_of_persons_cntrlr.text.trim().contains(" "))
                        {
                          Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("Enter number of persons\n ",style:
                          TextStyle(
                              fontSize: 20
                          ),),
                            duration: Duration(milliseconds: 3200),
                            backgroundColor: Colors.black87,
                          )
                          );
                        }

                      },
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
                          hintText: 'Number of persons',
                          hintStyle: TextStyle(fontSize: 18.0)),
                      style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      controller: number_of_persons_cntrlr,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: 70,
                    child: TextFormField(
                      maxLength: 15,
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
                            Icons.train,
                            color: Colors.black,
                          ),
                          hintText: 'Vehicle type',
                          hintStyle: TextStyle(fontSize: 18.0)),
                      style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      controller: vehicle_type_cntrlr,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: 70,
                    child: TextFormField(
                      onEditingComplete: (){
                        if(trip_days_cntrlr.text.trim()=="0"||trip_days_cntrlr.text.trim()=="00"
                            ||trip_days_cntrlr.text.trim()==""||trip_days_cntrlr.text.trim().contains("-")
                            ||trip_days_cntrlr.text.trim().contains(".")||trip_days_cntrlr.text.trim().contains(",")
                            ||trip_days_cntrlr.text.trim().contains(" "))
                          {
                            Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("Enter valid trip days\n ",style:
                            TextStyle(
                                fontSize: 20
                            ),),
                              duration: Duration(milliseconds: 3200),
                              backgroundColor: Colors.black87,
                            )
                            );
                          }
                      },
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
                            Icons.calendar_today,
                            color: Colors.black,
                          ),
                          hintText: 'Trip days',
                          hintStyle: TextStyle(fontSize: 18.0)),
                      style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      maxLength: 2,
                      controller: trip_days_cntrlr,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: 70,
                    child: TextField(

                      maxLength: 6,
                      keyboardType: TextInputType.number,
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
                            Icons.monetization_on,
                            color: Colors.black,
                          ),
                          hintText: 'Expected Fair (optional)',
                          hintStyle: TextStyle(fontSize: 18.0)),
                      style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                      controller: expected_fair_cntrlr,
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
                        if((user_contact_cntrlr.text.trim().length!=11)||user_contact_cntrlr.text.contains("-")||user_contact_cntrlr.text.contains(".")||user_contact_cntrlr.text.contains(",")||user_contact_cntrlr.text.contains(" ")){
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
                      controller: user_contact_cntrlr,
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
                    height: 80 ,
                    child: TextField(
                      minLines: 1,
                      maxLines: 15,
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
                      controller: other_details_cntrlr,
                    ),
                  ),
                  SizedBox(
                    height: 2,
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
                            "Post request",style: TextStyle(
                            fontSize: 18
                          ),
                          ),
                          //On Pressed
                          onPressed: () {
                            if
                            (departure_location_cntrlr.text.trim()=="" || trip_location_cntrlr.text.trim()==""||
                            departure_date_cntrlr.text==""||departure_time_cntrlr.text==""||
                                number_of_persons_cntrlr.text.trim()==""||vehicle_type_cntrlr.text==""||
                            trip_days_cntrlr.text.trim()==""||expected_fair_cntrlr.text.trim()==""||other_details_cntrlr.text=="")
                              {
                                print("time stamp: ${Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch).millisecondsSinceEpoch.toString()}");
                                 int timestamp = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch).millisecondsSinceEpoch;
                                 print(DateTime.fromMillisecondsSinceEpoch(timestamp));
                                Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("Fill all fields\n ",style:
                                TextStyle(
                                    fontSize: 20
                                ),),
                                  duration: Duration(milliseconds: 3200),
                                  backgroundColor: Colors.black87,
                                )
                                );
                              }
                            else if(number_of_persons_cntrlr.text.trim()=="0"||number_of_persons_cntrlr.text.trim()=="00"
                                ||number_of_persons_cntrlr.text.trim()==""||number_of_persons_cntrlr.text.trim().contains("-")
                                ||number_of_persons_cntrlr.text.trim().contains(".")||number_of_persons_cntrlr.text.trim().contains(",")
                                ||number_of_persons_cntrlr.text.trim().contains(" "))
                            {
                              Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("Enter number of persons\n ",style:
                              TextStyle(
                                  fontSize: 20
                              ),),
                                duration: Duration(milliseconds: 3200),
                                backgroundColor: Colors.black87,
                              )
                              );
                            }
                            else if(trip_days_cntrlr.text.trim()=="0"||trip_days_cntrlr.text.trim()=="00"
                                ||trip_days_cntrlr.text.trim()==""||trip_days_cntrlr.text.trim().contains("-")
                                ||trip_days_cntrlr.text.trim().contains(".")||trip_days_cntrlr.text.trim().contains(",")
                                ||trip_days_cntrlr.text.trim().contains(" "))
                            {
                              Scaffold.of(scafold_context).showSnackBar(SnackBar(content: Text("Enter valid trip days\n ",style:
                              TextStyle(
                                  fontSize: 20
                              ),),
                                duration: Duration(milliseconds: 3200),
                                backgroundColor: Colors.black87,
                              )
                              );
                            }
                            else  if((user_contact_cntrlr.text.trim().length!=11)||user_contact_cntrlr.text.contains("-")||user_contact_cntrlr.text.contains(".")||user_contact_cntrlr.text.contains(",")||user_contact_cntrlr.text.contains(" ")){
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
                            else
                            {
                              post_request.departure_location =
                                  departure_location_cntrlr.text.toString()
                                      .trim();
                              post_request.trip_location =
                                  trip_location_cntrlr.text.toString().trim();
                              post_request.departure_date =
                                  departure_date_cntrlr.text.toString().trim();
                              post_request.departure_time =
                                  departure_time_cntrlr.text.toString().trim();
                              post_request.trip_seats = int.parse(
                                  number_of_persons_cntrlr.text.toString()
                                      .trim());
                              post_request.vehicle_type =
                                  vehicle_type_cntrlr.text.toString().trim();
                              post_request.trip_fare = int.parse(
                                  expected_fair_cntrlr.text.toString().trim());
                              post_request.other_details =
                                  other_details_cntrlr.text.toString().trim();
                              post_request.trip_days = int.parse(
                                  trip_days_cntrlr.text.toString().trim());
                              post_request.trip_type = "user request";
                              // post_request.booked_seats=0;
                              post_request.date_of_post = DateTime.now();
                              post_request.user_ID = firebase_user.uid;
                              post_request.user_contact=user_contact_cntrlr.text;

                              post_request.addPostRequest();

                              user_contact_cntrlr.clear();
                              departure_location_cntrlr.clear();
                              trip_location_cntrlr.clear();
                              departure_date_cntrlr.clear();
                              departure_time_cntrlr.clear();
                              number_of_persons_cntrlr.clear();
                              vehicle_type_cntrlr.clear();
                              trip_days_cntrlr.clear();
                              expected_fair_cntrlr.clear();
                              other_details_cntrlr.clear();

                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => UserTimeline()
                              ));
                              //----------------------------------------------------------Login  button--------------------------------
                              //to do code og login button
                              // print(name_controller);
                            }
                          },
                        ),
                      ),
                    ],
                  ),






                ],
              ),

            ),
          ),
        ),
      )
    );
  }
}














