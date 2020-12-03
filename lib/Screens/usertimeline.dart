import 'package:adventure_eye/Screens/requestoftrip.dart';
import 'package:adventure_eye/Screens/tripsdetails.dart';
import 'package:adventure_eye/database/globals.dart';
import 'package:adventure_eye/widgets/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
bool _is_club=true;
class UserTimeline extends StatefulWidget {


  @override
  _UserTimelineState createState() => _UserTimelineState();
}

class _UserTimelineState extends State<UserTimeline> {



  @override
  void initState() {

    if(firebase_user!= null){
      Firestore.instance.collection('users').document(firebase_user.uid).get().then((value) {
      is_club=value['club'];
        setState(() {
          _is_club=value['club'];
        });
        SharedPreferences.getInstance().then((pref) {
          pref.setBool("is_club", _is_club);
        });
      });
    }
    SharedPreferences.getInstance().then((value) {
      value.setString('user_mode', "user");
    });
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _is_club? null :  FloatingActionButton(
        onPressed: (){
          Navigator.push(context,  MaterialPageRoute(builder: (context) => RequestTrips()),);
        },
        child: Icon(Icons.add,color: Colors.black,),
        elevation: 10.0,
      ),
      appBar: AppBar(
        title: Text("Available trips"),
        centerTitle: true,

      ),

      drawer: MyDrawer(),
      body:StreamBuilder(
        stream: Firestore.instance.collection("trips").snapshots(),

        builder: (context,snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

            return
              ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    print ("$index ");
                    print("indexes in user timeline are ${snapshot.data.documents.length}");

                    return  _buildListItem(context ,snapshot.data.documents[index]);
                  }
                    ,

                  );
        }
      ),
    );

  }
}

_buildListItem(BuildContext context ,DocumentSnapshot document){
 return document['trip status']=="posted"? Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: <Widget>[
        ListTile(title: Text(document["club name"],
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
          trailing: RatingBarIndicator(
            rating: document["club rating"],
            itemBuilder: (context, index) =>
                Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
          leading: CircleAvatar(
            child: Text(document["club name"][0],
            style: TextStyle(
              fontSize: 25,
           //   fontWeight: FontWeight.bold
            ),),

          ),
        ),
        GestureDetector(
          onTap: () {
            print("tripp days");
            print(document['trip days']);
           _is_club? null: Navigator.push(context, MaterialPageRoute(
                builder: (context) => TripDetail(document)),);
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
            style: TextStyle(
                color: Colors.black87, fontSize: 18),
          ),
          subtitle: Text(
            "Departure date: ${document["departure date"]}\nDeparture time: ${document["departure time"]}",
            style: TextStyle(
                color: Colors.black, fontSize: 15),
          ),
          trailing: Text(
            "${document["trip fare"]} PKR",
            style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        Divider(
          color: Colors.black54,
        ),
      ],
    ),
  ):Container(height: 1,);
}