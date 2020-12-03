import 'package:adventure_eye/Screens/usertimeline.dart';
import 'package:adventure_eye/database/firestore.dart';
import 'package:adventure_eye/database/globals.dart';
import 'package:adventure_eye/widgets/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

DocumentSnapshot _document;
String _hint_txt ='Number of seats';
Color _txtf_color=Colors.greenAccent;
class TripDetail extends StatefulWidget {
  TripDetail(this.document){
    _document= document;
  }

  DocumentSnapshot document;

  @override
  _TripDetailState createState() => _TripDetailState();
}

class _TripDetailState extends State<TripDetail> {
  String Trip_title = "${_document['trip days']} day trip to ${_document['trip location']}";

  int trip_seats = _document['total seats'];

  int trip_fair = _document['trip fare'];

  String currency = "PKR";

  String departure_location = _document['departure location'];

  String trip_location = _document['trip location'];

  DateTime departure_date_time = DateTime.now();

  dynamic departure_date = _document['departure date'];

  dynamic departure_time = _document['departure time'];
  String club_contact= _document['club contact']??"";


  String club_name = _document['club name'];
  DocumentSnapshot user_doc;

  TextEditingController numb_persons =TextEditingController() ;

  void bookButtonPressed() {
    String trip_ID = _document['trip ID'];
   int booked_seats = _document['booked seats'];
   int total_seats = _document['total seats'];
  int my_seats = int.parse(numb_persons.text.toString().trim());

    print(_document['booked seats']);
    print(trip_ID);
    Firestore.instance.collection('trips').document(trip_ID).updateData({
      "booked seats" : booked_seats+my_seats,
      "total seats":total_seats-my_seats,

      "requests": FieldValue.arrayUnion( [{
        "user ID": firebase_user.uid,
        "user name": user_doc['name'],
        "booked seats":my_seats
      }] )
    });

  }

  @override
  void initState() {
    // TODO: implement initState

    Firestore.instance.collection('users').document(firebase_user.uid).get().then((user) {
      user_doc = user;
      print(user['name']);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(_document["club name"]),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundColor: Colors.black54,
            child: Text(_document['club name'][0]),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Scrollbar(
        child: SingleChildScrollView(
          reverse: false,
          child: Container(

              //  color: Colors.white30,
              child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: screen_width + 1,
                height: screen_width*2/3,
                child: Image.network(
                  _document['photo url'],
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "$Trip_title",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,right: 8.0),
                      child: Column(
                       // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Available Seats: ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "$trip_seats",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              )
                            ],
                          ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               "Fare: ",
                               style: TextStyle(
                                   fontSize: 20, fontWeight: FontWeight.bold),
                             ),
                             Text(
                             "$currency $trip_fair",
                             style: TextStyle(
                                 fontSize: 21,
                                 fontWeight: FontWeight.bold,
                                 color: Colors.green),
                           )],
                         ),
                          Divider(
                            color: Colors.black87,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Departure:  ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$departure_location",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Destination:  ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$trip_location",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$departure_date",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Time",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$departure_time",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Contact:",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "$club_contact",
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Divider(
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 75,
                      child: TextFormField(
                        onChanged: (text){
                          if( int.parse(text)>trip_seats)
                            {
                              setState(() {
                                _txtf_color=Colors.red;
                                _hint_txt="Number of seats";
                              });
                            }
                          else if(int.parse(text)<=trip_seats)
                            {
                              setState(() {
                                _txtf_color=Colors.greenAccent;
                              });
                            }
                        },
                        keyboardType: TextInputType.number,
                        controller: numb_persons,
                        maxLength: 2,
                        validator: (value) {
                          if (value.isEmpty) {}
                          return null;
                        },
                        // controller: name_controller,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _txtf_color, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(40.0),
                              ),
                            ),
                            focusColor: _txtf_color,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _txtf_color, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(45.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Color.fromRGBO(150, 150, 150, 100.0),
                            prefixIcon: Icon(
                              Icons.person_add,
                              color: Colors.black,
                            ),
                            hintText: _hint_txt,
                            hintStyle: TextStyle(fontSize: 18.0)),
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 18),
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

                              splashColor: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                      color: Colors.black12, width: 1)),
                              padding: const EdgeInsets.all(15),
                              color: Color(0xFF50C788),
                              child: Text(
                                "Request Booking",
                                style: TextStyle(fontSize: 18),
                              ),
                              //On Pressed
                              onPressed: (){
                               if(
                                   numb_persons.text.contains("-")||
                                   numb_persons.text.contains(" ")||
                                       numb_persons.text.contains(".") ||
                                       numb_persons.text.contains(",")||
                                       numb_persons.text.contains("0")||
                                       numb_persons.text.contains("00")
                               )
                                {

                                  setState(() {
                                    numb_persons.text="";
                                    _txtf_color=Colors.red;
                                    _hint_txt="Enter number of seats";
                                  });
                                }
                               else if(numb_persons.text=="")
                                 {
                                   setState(() {
                                     _txtf_color=Colors.red;
                                     _hint_txt="Enter number of seats";
                                   });
                                 }
                               else if(trip_seats<int.parse(numb_persons.text))

                                 {
                                   numb_persons.text="";
                                   setState(() {
                                     _txtf_color=Colors.red;
                                     _hint_txt="Avaialable seats: $trip_seats";
                                   });
                                 }
                                else
                                {
                                  bookButtonPressed();
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>UserTimeline()
                                  ));
                                }
                              }



                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
