import 'package:adventure_eye/database/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyTrips extends StatefulWidget {
  @override
  _MyTripsState createState() => _MyTripsState();
}

class _MyTripsState extends State<MyTrips> {
  String destination_location="Hunza";
  String trip_location = "Hunza, northen areas";
  String departure_date="15 sep,2020";
  String other_detail="I want to have a bed and breakfast and a room full of baloons and a locker and a swimming pool";
  String vehicle_type="Hiace";
  String number_of_persons="10";
  String departure_time= "10:00 am";
  int number_of_days=7;
  String departure_location="Islamabad and Rawalpindi";
  String expected_fair="PKR 120000";




  @override
  Widget build(BuildContext context) {
    initState(){

    }
    return Scaffold(
      appBar: AppBar(title: Text(
        "My trips"
      ),
      centerTitle: true,

      ),
      body:StreamBuilder(
        stream: Firestore.instance.collection("custom trips").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          else
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                return is_club?_buildClubItem(snapshot.data.documents[index]) : _buildUserItem(snapshot.data.documents[index], context);
              });
        }
      )
    );
  }
}
_buildUserItem(DocumentSnapshot custom_trips,BuildContext context){
  if(custom_trips["user ID"]==firebase_user.uid)
 return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: <Widget>[
        ListTile(
          leading:   CircleAvatar(child: Text(custom_trips["user name"][0],style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          ),
          title: (Text(custom_trips["user name"],style: TextStyle(
            fontWeight: FontWeight.bold
          ),)),
        ),
        GestureDetector(
          //Todo handle bottom sheet code
          onTap: (){
            if(!is_club)
            {
              print(custom_trips['selected bid']);
              if(custom_trips['selected bid']==null&&custom_trips["bidders"]!=null)
               {
               return  showModalBottomSheet(
                     context: context,
                     builder: (BuildContext context){
                       return ListView.builder(
                           shrinkWrap: true,
                           itemCount: custom_trips["bidders"].length,
                           itemBuilder: (BuildContext context, int bid_index) {
                             return   ListTile(
                                 trailing: OutlineButton(
                                   onPressed: (){
                                     //TODO accept bid code
                                     Firestore.instance.collection("custom trips").document(custom_trips["trip ID"]).updateData({
                                       "selected bid":custom_trips["bidders"][bid_index]
                                     });
                                     Navigator.pop(context);
                                   },
                                   child: Text(
                                       "Accept bid"
                                   ),
                                 ) ,
                                 leading: CircleAvatar(
                                   child: Text(custom_trips["bidders"][bid_index]["club name"][0]),

                                 ),

                                 title:Text(custom_trips["bidders"][bid_index]["club name"]) ,
                                 subtitle:  Text(custom_trips["bidders"][bid_index]["bid"],style: TextStyle(
                                     color: Colors.green
                                 ),
                                 ),


                                 onTap: () => {}
                             );
                           });
                     }
                 );
               }

            }

          },
          child:Card(
            child: ListTile(

              title:Text("From: ${custom_trips["departure location"]}\nTo: ${custom_trips["trip location"]}\nOn: ${custom_trips["departure date"]}\nfor ${custom_trips["trip days"]} days and ${custom_trips["trip seats"]} persons\nExpected fair:${custom_trips["expected fair"]}\n"
              ),
              subtitle: Text(
                  "${custom_trips["other details"]}"
              ),
              isThreeLine: true,
            ),
          )

        ),
        custom_trips['selected bid']!=null?

        ListTile(
          title: Text("Selected bid:  PKR ${custom_trips['selected bid']['bid']}",style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold
          ),),
          subtitle: Text("Club: ${custom_trips['selected bid']['club name']}",style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),),
          leading: CircleAvatar(
            child: Text(custom_trips['selected bid']['club name'][0]),
          ),
        ):

        Container(height: 1,),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.black12,
          thickness: 2,
        ),

      ],
    ),
  );
  else
    return Container(height: 1,);
}
_buildClubItem(DocumentSnapshot custom_trips)
{  // List<dynamic> bidders = custom_trips["bidders"];
  if(custom_trips['selected bid']==null)
    return Container(height: 1,);
 if(custom_trips['selected bid']['club ID']==firebase_user.uid) {
  return  Padding(
     padding: const EdgeInsets.all(15.0),
     child: Column(
       children: <Widget>[
         ListTile(
           leading: CircleAvatar(
             child: Text(custom_trips["user name"][0]),
           ),
           title: Text(custom_trips["user name"]),
         ),
         Card(
           child: ListTile(
             title:Text("From: ${custom_trips['departure location']}\nTo: ${custom_trips["trip location"]}\n\nfor ${custom_trips["trip days"]} days and ${custom_trips["total seats"]} persons\nExpected fair: ${custom_trips["expected fare"]}\nOn: ${custom_trips["departure date"]}\n\nContact:${custom_trips['user contact']}\n"
             ),
             subtitle: Text(
                 "${custom_trips["other details"]}"
             ),

             isThreeLine: true,
           ),
         ),
         ListTile(
           title: Text("Bid:  PKR ${custom_trips['selected bid']['bid']}",style: TextStyle(
               color: Colors.green,
               fontWeight: FontWeight.bold
           ),),
           subtitle: Text("${custom_trips['selected bid']['club name']}",style: TextStyle(
               fontWeight: FontWeight.bold,
               color: Colors.black
           ),),
           leading: CircleAvatar(
             child: Text(custom_trips['selected bid']['club name'][0]),
           ),
         ),
         SizedBox(
           height: 10,
         ),
         Divider(
           color: Colors.black26,
         ),
       ],
     ),
   );
  }

}