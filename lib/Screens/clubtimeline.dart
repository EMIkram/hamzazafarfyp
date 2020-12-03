import 'package:adventure_eye/Screens/posttrip.dart';
import 'package:adventure_eye/database/globals.dart';
import 'package:adventure_eye/widgets/my_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

DocumentSnapshot _club;
class ClubTimeline extends StatefulWidget {

  @override
  _ClubTimelineState createState() => _ClubTimelineState();
}

class _ClubTimelineState extends State<ClubTimeline> {
//  String destination_location="Hunza";
//  String departure_date="15 sep,2020";
//  String other_detail="I want to have a bed and breakfast and a room full of baloons and a locker and a swimming pool";
//  String vehicle_type="Hiace";
//  String number_of_persons="10";
//  int number_of_days=7;
//  String departure_location="Islamabad and Rawalpindi";
//  String expected_fair="PKR 120000";



  @override
  void initState()  {
    // TODO: implement initState

     SharedPreferences.getInstance().then((value) {
       value.setString('user_mode', "club");
     });
     Firestore.instance.collection("clubs").document(firebase_user.uid).get().then((club_doc) {
       _club = club_doc;

     });
     super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("User requests"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add
        ),
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PostTrip()));

        }
      ),

      body: StreamBuilder(
        stream: Firestore.instance.collection("custom trips").snapshots(),
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

TextEditingController _my_bid_controller = TextEditingController();
_buildListItem(BuildContext context ,DocumentSnapshot document)

{
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            child: Text(document["user name"][0]),
          ),
          title: Text(document["user name"]),
        ),
        GestureDetector(
          onTap: (){

            print(_club);
            showModalBottomSheet(

//              shape:Border.all(),
                context: context,
                builder: (BuildContext bottom_sheet_context){
                  return SingleChildScrollView(
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left:18.0,top: 8,right: 18.0,bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(

                                child: Text(_club["club name"][0]),
                              ),
                              Container(
                                height: 20,
                                width: 200,
                                child: TextField(
                                    keyboardType: TextInputType.number,
                                  controller: _my_bid_controller,
                                  onChanged: (text){
                                      print(text);
                                     // my_bid_controller.text=text;
                                  },
                                ),

                              ),
                              OutlineButton(

                                onPressed:(){

                                print(_my_bid_controller.text);
                                if(_my_bid_controller.text.trim()==''){
                                  //TODO implementaton of validation of bid text field on button pressed
                                  print("plese enter a bid");
                                }
                                else
                                {
                                  print(_my_bid_controller.text);
                                    Firestore.instance.collection("custom trips").document(document["trip ID"]).updateData({
                                    "bidders": FieldValue.arrayUnion([{
                                      "club name": _club["club name"],
                                      "bid":_my_bid_controller.text,
                                      "club ID":firebase_user.uid
                                    }] )
////
                                    });

                                    _my_bid_controller.clear();
                                    Navigator.pop(bottom_sheet_context);
//
                                }
                                },
                                child: Text(
                                    "Add bid"
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 250,
                          width: double.maxFinite,
                          child: document["bidders"]==null? Container(height: 40,): ListView.builder(
                              shrinkWrap: true,
                              itemCount: document["bidders"].length,
                              itemBuilder: (BuildContext context, int position) {
                                return  ListTile(

                                    leading: CircleAvatar(
                                      child: Text(document['bidders'][position]["club name"][0]),
                                    ),
                                    trailing: Text(document['bidders'][position]["bid"],style: TextStyle(
                                        color: Colors.green
                                    ),),
                                    title:  Text(document['bidders'][position]["club name"]),
                                    onTap: () => {}
                                );
                              }),
                        ),

                      ],
                    ),
                  );
                }
            );
          },
          child: Card(
            child: ListTile(
              title:Text("From: ${document['departure location']}\nTo: ${document["trip location"]}\n\nfor ${document["trip days"]} days and ${document["total seats"]} persons\nExpected fair: ${document["expected fare"]}\nOn: ${document["departure date"]}\nContact:${document['user contact']??""}"
              ),
              subtitle: Text(
                  "${document["other details"]}"
              ),

              isThreeLine: true,
            ),
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