import 'package:adventure_eye/database/globals.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Firestore firestore = Firestore.instance;

class User {
  User({
    this.age,
    this.cnic,
    this.country,
    this.country_code,
    this.email,
    this.gender,
    this.is_signed_in,
    this.password,
  }) {}
  String user_ID;
  String user_name;
  String email;
  String phone_no;
  String country_code;
  String country;
  String cnic;
  String password;
  String photo_url;
  String user_club;
  bool is_signed_in;
  bool trusted_user;
  String gender;
  int age;
  double rating;
  LatLng user_Location;
  int total_trips;
  int wallet;
  
  addUser(){
    print("add user method called");
    print(firebase_user.uid);
   firestore.collection('users').document(this.user_ID).setData(
       {'name': this.user_name,
         'age':this.age,'email': this.email,
         'cnic':this.cnic,'password':this.password,
         'phone': this.phone_no,
         'gender':this.gender,
       'club': false,}
         );
  }
  
}

class Club {
  Club(
      {this.club_ID,
        this.club_contact,
        this.club_location,
        this.club_name,
        this.photo_URL,
        this.rating,
        this.total_trips,
        this.user_ID,
        this.user_name,
        this.club_rating}) {}
  String club_name;
  String club_ID;
  String user_ID;
  String user_name;
  String photo_URL;
  LatLng club_latlng;
  String club_location;
  String club_contact;
  double rating;
  int total_trips;
  double club_rating;


  resisterClub() async {
    firestore.collection('clubs').document(firebase_user.uid).setData(
        {'club name': this.club_name,
          'club location':this.club_location,
          'club contact':this.club_contact,
          'total trips':this.total_trips,
          'club rating':this.club_rating
        }
    );
    await   Firestore.instance.collection('users').document(firebase_user.uid).updateData(<String, dynamic>{
      'club': true
    });
  }

}

class Trip {
  Trip(
      {this.booked_seats,
        this.club_ID,
        this.club_name,
        this.currency,
        this.departure_date_time,
        this.departure_date,
        this.departure_latlng,
        this.departure_location,
        this.departure_time,
        this.photo_url,
        this.trip_ID,
        this.trip_fare,
        this.trip_location,
        this.trip_seats,
        this.trip_title,
        this.trip_type,
        this.user_ID,

      }) {}
  String trip_title;
  String trip_type;
  bool is_completed=false;
  String image_location;
  String trip_ID;
  String user_ID;
  String club_ID;
  int trip_seats;
  int trip_fare;
  String currency = "PKR";
  String departure_location;
  LatLng departure_latlng;
  double club_rating=5.0;
 // List<String> visiting_locations;
  String trip_location;
  DateTime departure_date_time;
  dynamic departure_date; //= departure_date_time.day;
  dynamic departure_time; // departure_date_time.hour;
  DateTime date_of_post;
  String vehicle_type;
  String club_name;
  String user_name;
  List<Map<String, dynamic>> subscribers;
  List<Map<String, dynamic>> bidders;
  // check if any error accours
  String photo_url;
  String other_details;
  int booked_seats;
  int trip_count;
  int trip_days;
  String user_contact;
  String club_contact;

 Future<QuerySnapshot> getAllTrips() async{


   QuerySnapshot querySnapshot= await  Firestore.instance.collection('trips').getDocuments();
   print(querySnapshot.documents);
   return querySnapshot;
  }



  addTrip(){
    trip_ID=Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch).millisecondsSinceEpoch.toString();
    Firestore.instance.collection('trips').document(trip_ID.toString()).setData(
        {
          "trip ID": this.trip_ID,
          "departure location": this.departure_location,
          "trip location": this.trip_location,
          "departure date": this.departure_date,
          "departure time": this.departure_time,
          "total seats": this.trip_seats,
          "vehicle type": this.vehicle_type,
          "trip fare": this.trip_fare,
          "other details": this.other_details,
          "photo url": this.photo_url,
          "trip type": this.trip_type,
          "image location":this.image_location,
          "booked seats":this.booked_seats,
          "subscribers":this.subscribers,
          "is completed":this.is_completed,
          " trip count": this.trip_count,
          "trip days": this.trip_days,
          "club rating":this.club_rating,
          "club ID": this.club_ID,
          "club name":this.club_name,
          "trip status":"posted",
          "club contact":this.club_contact,
          "rated IDs":[],
        }
    );
    Firestore.instance.collection('clubs').document(firebase_user.uid).updateData({'total trips':trip_count});
  }
  addPostRequest(){
   // trip_ID="${this.date_of_post.year}-${this.date_of_post.month}-${this.date_of_post.day} ${this.date_of_post.hour}:${this.date_of_post.minute}:${this.date_of_post.second}";
   trip_ID=Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch).millisecondsSinceEpoch.toString();

   Firestore.instance.collection('custom trips').document(trip_ID.toString()).setData(
        {
          "trip ID": this.trip_ID,
          "departure location": this.departure_location,
          "trip location": this.trip_location,
          "departure date": this.departure_date,
          "departure time": this.departure_time,
          "total seats": this.trip_seats,
          "vehicle type": this.vehicle_type,
          "expected fare": this.trip_fare,
          "other details": this.other_details,
          "trip type": this.trip_type,
          "bidders":this.bidders,
          "is completed":this.is_completed,
          "trip days": this.trip_days,
          "user ID":this.user_ID,
          "user name":this.user_name,
          "user contact":this.user_contact,

        }
    );
    Firestore.instance.collection('clubs').document(firebase_user.uid).updateData({'total trips':trip_count});
  }

}

