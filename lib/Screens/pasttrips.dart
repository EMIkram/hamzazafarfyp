import 'package:flutter/material.dart';
import 'package:adventure_eye/database/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quick_feedback/quick_feedback.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class PastTrips extends StatefulWidget {
  @override
  _PastTripsState createState() => _PastTripsState();
}

class _PastTripsState extends State<PastTrips> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Past trips"),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection("trips").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  // print(snapshot.data.documents.length);
                  print("index $index");
                  return is_club
                      ? _buildClubItem(context, snapshot.data.documents[index])
                      : _buildUserItem(context, snapshot.data.documents[index]);
                });
          }),
    );
  }
}
//{
//  String destination_location="Hunza";
//  String trip_location = "Hunza, northen areas";
//  String departure_date="15 sep,2020";
//  String other_detail="I want to have a bed and breakfast and a room full of baloons and a locker and a swimming pool";
//  String vehicle_type="Hiace";
//  String number_of_persons="10";
//  String departure_time= "10:00 am";
//  int number_of_days=7;
//  String departure_location="Islamabad and Rawalpindi";
//  String expected_fair="PKR 120000";
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Past trips"),
//        centerTitle: true,
//      ),
//      body: ListView.builder(
//          itemCount: 5,
//          itemBuilder: (BuildContext context, int position) {
//            return Padding(
//              padding: const EdgeInsets.all(15.0),
//              child: Column(
//                children: <Widget>[
//                  Card(
//                    child: ListTile(
//                      leading: CircleAvatar(child: Text("user"),
//                      ),
//                      title:Text("From: $departure_location\nTo: $destination_location\nOn: $departure_date\nfor $number_of_days days and $number_of_persons persons\nExpected fair:$expected_fair\n"
//                      ),
//
//
//                     // isThreeLine: true,
//                    ),
//                  ),
//                  SizedBox(
//                    height: 30,
//                  ),
//                  Divider(
//                    color: Colors.black26,
//                  ),
//                ],
//              ),
//            );
//          }),
//    );
//  }
//}






_buildClubItem(BuildContext context, DocumentSnapshot document) {
  if (document['club ID'] == firebase_user.uid &&
      (document['trip status'] == "ended" )) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            document["club name"],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: RatingBarIndicator(
            rating: document["club rating"],
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
          leading: CircleAvatar(
            child: Text(
              document["club name"][0],
              style: TextStyle(
                fontSize: 25,
                //   fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),
          child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width,
            // color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                document["photo url"],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        ListTile(
          title: Text(
            "From: ${document["departure location"]}\nTo: ${document["trip location"]}\n",
            style: TextStyle(color: Colors.black87, fontSize: 18),
          ),
          subtitle: Text(
            "Departure date: ${document["departure date"]}\nDeparture time: ${document["departure time"]}",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          trailing: Text(
            "${document["trip fare"]} PKR",
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        ListTile(
          title: Text("Trip status: ${document["trip status"]}"),

        ),
        Divider(
          color: Colors.black54,
        ),
      ],
    );
  } else
    return Container(
      height: 1,
    );
}

_buildUserItem(BuildContext context, DocumentSnapshot document) {
  List<dynamic> subscribers = document["subscribers"];
//  print("subscriber are ${document["subscribers"]}");
//  print("before loop");
  List<dynamic> rated_IDs = document["rated IDs"];
  if (document["subscribers"] == null) {
    print("null subscribers ");
    return Container(
      height: 1,
    );
  } else if (document["subscribers"].length == 0) {
    print("null length subscribers ");
    return Container(
      height: 1,
    );
  }

  else {
    int index;
    //initialized index to access corresponding element in "subscribers" of every "trips" document
    for (var user in subscribers) {
      index=0;
      if (user['user ID'] == firebase_user.uid && document['trip status']=="ended") {
        int booked_seats=0 ;
        for(var user in subscribers){
          if(user['user ID']==firebase_user.uid)
          {
            booked_seats+=user['booked seats'];
          }
        }
        // String user_name= user['user name'];
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  document["club name"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: RatingBarIndicator(
                 // unratedColor: Colors.redAccent,
                  rating: document["club rating"],
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
                leading: CircleAvatar(
                  child: Text(
                    document["club name"][0],
                    style: TextStyle(
                      fontSize: 25,
                      //   fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {

                 //todo on tap of image
                },
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        document["photo url"],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "From: ${document["departure location"]}\nTo: ${document["trip location"]}\n",
                  style: TextStyle(color: Colors.black87, fontSize: 18),
                ),
                subtitle: Text(
                  "Departure date: ${document["departure date"]}\nDeparture time: ${document["departure time"]}",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                trailing: Text(
                  "${document["trip fare"]} PKR \n Seats:$booked_seats",
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              ListTile(
                title: Text("Trip status: ${document["trip status"]}"),
                    trailing: rated_IDs.contains(firebase_user.uid)? null:OutlineButton(
                    highlightColor: Colors.greenAccent,
                    highlightedBorderColor: Colors.white60,
                    borderSide: BorderSide(color:Colors.greenAccent),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          //todo feedback code 
                          return
                            QuickFeedback(
                           // defaultRating: 5,
                            title: 'How was your trip?', // Title of dialog
                            showTextBox: true, // default false

                            textBoxHint:
                            'Give your feedback', // Feedback text field hint text default: Tell us more
                            submitText: 'Submit', // submit button text default: SUBMIT
                            onSubmitCallback: (feedback) {
                              print('$feedback'); // map { rating: 2, feedback: 'some feedback' }
                              double club_rating;
                              int total_ratings;
                              Firestore.instance.collection("clubs").document(document['club ID']).get().then((club) {
                              club_rating=  club["club rating"];
                              total_ratings=club["total ratings"]??1;
                              print(club_rating);
                              print(total_ratings);
                              double my_rating = ((club_rating*total_ratings)+feedback["rating"])/++total_ratings;
                              print(my_rating);
                              print("user name is "+document["subscribers"][index]["user name"]);
                              Firestore.instance.collection("clubs").document(document['club ID']).updateData({
                                "club rating":my_rating,
                                "total rating":total_ratings+1,
                                "ratings":FieldValue.arrayUnion([{
                                  "user name":document["subscribers"][index]["user name"],
                                  "user ID":firebase_user.uid,
                                  "rating":feedback["rating"],
                                  "feedback":feedback["feedback"]
                                }])
                              });
                              Firestore.instance.collection("trips").document(document["trip ID"]).updateData({
                              "rated IDs":FieldValue.arrayUnion([
                                firebase_user.uid
                              ]),
                              });
                              });
                              Navigator.of(context).pop();
                            },
                            askLaterText: 'Cancel',
                          );

                          //
                          //
//                            RatingDialog(
//                            icon: CircleAvatar(
//                              child: Text(document['club name'][0]),
//                            ) ,// set your own image/icon widget
//                            title: document['club name'],
//                            description:
//                            "Tell us how was your experience on this trip?",
//                            submitButton: "SUBMIT",
//
//                           // alternativeButton: "Contact us instead?", // optional
//                            positiveComment: "We are so happy to hear :)", // optional
//                            negativeComment: "We're sad to hear :(", // optional
//                            accentColor: Colors.red, // optional
//                            onSubmitPressed: (int rating) {
//                              print("onSubmitPressed: rating = $rating");
//                              // TODO: open the app's page on Google Play / Apple App Store
//                            },
//                            onAlternativePressed: () {
//                              print("onAlternativePressed: do something");
//                              // TODO: maybe you want the user to contact you instead of rating a bad review
//                            },
//                          );
                        },
                      );
                    },
                    child: Text("Feedback",style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                    ),)),
              ),
              Divider(
                color: Colors.black54,
              ),
            ],
          ),

        );
      }

      else {
        return Container(
          height: 1,
        );
      }
    }
  }
}


