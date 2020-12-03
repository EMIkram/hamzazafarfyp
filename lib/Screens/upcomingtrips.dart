import 'package:adventure_eye/database/firestore.dart';
import 'package:adventure_eye/database/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UpcomingTrips extends StatefulWidget {
  @override
  _UpcomingTripsState createState() => _UpcomingTripsState();
}

class _UpcomingTripsState extends State<UpcomingTrips> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming trips"),
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

_buildClubItem(BuildContext context, DocumentSnapshot document) {
  if (document['club ID'] == firebase_user.uid &&
      (document['trip status'] == "posted" ||
          document['trip status'] == "running")) {
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
        GestureDetector(
          onTap: () {
            //todo bottom sheet code

            showModalBottomSheet(

//              shape:Border.all(),
                context: context,
                builder: (BuildContext bottom_sheet_context) {
                  //  TabController tabcontroller = TabController();

                  return DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            Navigator.pop(bottom_sheet_context);
                          },
                        ),
                        title: TabBar(
                          indicatorColor: Colors.black38,

                          //  controller: tabcontroller,
                          tabs: [
                            Tab(
                              icon: Icon(Icons.playlist_add),
                            ),
                            Tab(icon: Icon(Icons.playlist_add_check)),
                          ],
                        ),
                      ),
                      body: TabBarView(
                        // controller: tabcontroller,
                        children: [
                          document['requests'] == null ||
                                  document['requests'].length == 0
                              ? Container(
                                  height: 100,
                                  child: Center(
                                      child: Text(
                                    "no requests",
                                    style: TextStyle(fontSize: 18),
                                  )),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: document['requests'].length,
                                  itemBuilder:
                                      (BuildContext context, int position) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                              child: Text(
                                                document['requests'][position]
                                                    ['user name'][0],
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            ),
                                            title: Text(
                                              document['requests'][position]
                                                  ['user name'],
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            trailing: Text(
                                              "seats: ${document['requests'][position]['booked seats'].toString()}",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: OutlineButton(

                                                  onPressed: () {
                                                    //todo reject request

                                                    print(position);
                                                    print(
                                                        "about to remove $position");
                                                    print(document['requests']
                                                        [position]);
                                                    Firestore.instance
                                                        .collection("trips")
                                                        .document(
                                                            document['trip ID'])
                                                        .updateData({
                                                      'total seats': document[
                                                              'total seats'] +
                                                          document['requests']
                                                                  [position]
                                                              ['booked seats'],
                                                      'booked seats': document[
                                                              'booked seats'] -
                                                          document['requests']
                                                                  [position]
                                                              ['booked seats'],
                                                      'requests': FieldValue
                                                          .arrayRemove([
                                                        document['requests']
                                                            [position]
                                                      ]),
                                                    });
                                                  },
                                                  borderSide: BorderSide(
                                                      color: Colors.red),
                                                  highlightedBorderColor:
                                                      Colors.white60,
                                                  highlightColor: Colors.red,
                                                  child: Text("Reject"),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8.0),
                                                child: OutlineButton(
                                                  onPressed: () {
                                                    Firestore.instance
                                                        .collection("trips")
                                                        .document(
                                                            document['trip ID'])
                                                        .updateData({
                                                      'subscribers': FieldValue
                                                          .arrayUnion([
                                                        document['requests']
                                                            [position]
                                                      ]),
                                                      'requests': FieldValue
                                                          .arrayRemove([
                                                        document['requests']
                                                            [position]
                                                      ]),
                                                    });
                                                    //todo accept bid
                                                  },
                                                  borderSide: BorderSide(
                                                      color: Colors.green),
                                                  highlightColor: Colors.green,
                                                  highlightedBorderColor:
                                                      Colors.white60,
                                                  child: Text("Accept"),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black38,
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                          document['subscribers'] == null ||
                                  document['subscribers'].length == 0
                              ? Container(
                                  height: 100,
                                  child: Center(
                                      child: Text(
                                    "no requests",
                                    style: TextStyle(fontSize: 18),
                                  )),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: document['subscribers'].length,
                                  itemBuilder:
                                      (BuildContext context, int position) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                              child: Text(
                                                document['subscribers']
                                                    [position]['user name'][0],
                                                style: TextStyle(fontSize: 25),
                                              ),
                                            ),
                                            title: Text(
                                              document['subscribers'][position]
                                                  ['user name'],
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            trailing: Text(
                                              "seats: ${document['subscribers'][position]['booked seats'].toString()}",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.black38,
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                        ],
                      ),
                    ),
                  );
                });
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
            "${document["trip fare"]} PKR",
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        ListTile(
          title: Text("Trip status: ${document["trip status"]}"),
          subtitle: Text("Remaining seats: ${document["total seats"]}",style: TextStyle(
            color:Colors.black87
          ),),
          trailing: document['trip status'] == "posted"
              ?

              //Start trip button
              OutlineButton(
                  borderSide: BorderSide(color:Colors.greenAccent),
                  highlightColor: Colors.greenAccent,
                  highlightedBorderColor: Colors.white60,
                  onPressed: () {
                    BuildContext showdialog_context;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Are you sure?"),
                          content: Text(
                              "If you start trip than it will no longer be available to users for booking"),
                          actions: [
                            FlatButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            FlatButton(
                              child: Text("Continue"),
                              onPressed: () {
                                Firestore.instance
                                    .collection("trips")
                                    .document(document['trip ID'])
                                    .updateData({
                                  "trip status": "running",
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Start trip"))
              :
              //End trip button
              OutlineButton(
                  borderSide: BorderSide(color:Colors.greenAccent),
                  highlightColor: Colors.greenAccent,
                  highlightedBorderColor: Colors.white60,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Is you trip ended?"),
                          content:
                              Text("You can view this trip in the past trips"),
                          actions: [
                            FlatButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            FlatButton(
                              child: Text("Ok"),
                              onPressed: () {
                                Firestore.instance
                                    .collection("trips")
                                    .document(document['trip ID'])
                                    .updateData({
                                  "trip status": "ended",
                                  "rated IDs":[]
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("End trip")),
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
  print("subscriber are ${document["subscribers"]}");
  print("before loop");
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
      if (user['user ID'] == firebase_user.uid && document['trip status']!="ended") {
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

                  //todo bottom sheet code

//                  showModalBottomSheet(
//
////              shape:Border.all(),
//                      context: context,
//                      builder: (BuildContext bottom_sheet_context) {
//                        //  TabController tabcontroller = TabController();
//
//                        return DefaultTabController(
//                          length: 2,
//                          child: Scaffold(
//                            appBar: AppBar(
//                              leading: IconButton(
//                                icon: Icon(Icons.clear),
//                                onPressed: () {
//                                  Navigator.pop(bottom_sheet_context);
//                                },
//                              ),
//                              title: TabBar(
//                                indicatorColor: Colors.black38,
//
//                                //  controller: tabcontroller,
//                                tabs: [
//                                  Tab(
//                                    icon: Icon(Icons.playlist_add),
//                                  ),
//                                  Tab(icon: Icon(Icons.playlist_add_check)),
//                                ],
//                              ),
//                            ),
//                            body: TabBarView(
//                              // controller: tabcontroller,
//                              children: [
//                                document['requests'] == null ||
//                                        document['requests'].length == 0
//                                    ? Container(
//                                        height: 100,
//                                        child: Center(
//                                            child: Text(
//                                          "no requests",
//                                          style: TextStyle(fontSize: 18),
//                                        )),
//                                      )
//                                    : ListView.builder(
//                                        shrinkWrap: true,
//                                        itemCount: document['requests'].length,
//                                        itemBuilder: (BuildContext context,
//                                            int position) {
//                                          return Padding(
//                                            padding: const EdgeInsets.all(10.0),
//                                            child: Column(
//                                              children: [
//                                                ListTile(
//                                                  leading: CircleAvatar(
//                                                    child: Text(
//                                                      document['requests']
//                                                              [position]
//                                                          ['user name'][0],
//                                                      style: TextStyle(
//                                                          fontSize: 25),
//                                                    ),
//                                                  ),
//                                                  title: Text(
//                                                    document['requests']
//                                                        [position]['user name'],
//                                                    style:
//                                                        TextStyle(fontSize: 20),
//                                                  ),
//                                                  trailing: Text(
//                                                    "seats: ${document['requests'][position]['booked seats'].toString()}",
//                                                    style: TextStyle(
//                                                      fontSize: 20,
//                                                    ),
//                                                  ),
//                                                ),
//                                                Row(
//                                                  mainAxisAlignment:
//                                                      MainAxisAlignment.end,
//                                                  children: [
//                                                    Padding(
//                                                      padding:
//                                                          const EdgeInsets.only(
//                                                              right: 8.0),
//                                                      child: OutlineButton(
//                                                        onPressed: () {
//                                                          //todo reject request
//
//                                                          print(position);
//                                                          print(
//                                                              "about to remove $position");
//                                                          print(document[
//                                                                  'requests']
//                                                              [position]);
//                                                          Firestore.instance
//                                                              .collection(
//                                                                  "trips")
//                                                              .document(document[
//                                                                  'trip ID'])
//                                                              .updateData({
//                                                            'total seats': document[
//                                                                    'total seats'] +
//                                                                document['requests']
//                                                                        [
//                                                                        position]
//                                                                    [
//                                                                    'booked seats'],
//                                                            'booked seats': document[
//                                                                    'booked seats'] -
//                                                                document['requests']
//                                                                        [
//                                                                        position]
//                                                                    [
//                                                                    'booked seats'],
//                                                            'requests': FieldValue
//                                                                .arrayRemove([
//                                                              document[
//                                                                      'requests']
//                                                                  [position]
//                                                            ]),
//                                                          });
//                                                        },
//                                                        borderSide: BorderSide(
//                                                            color: Colors.red),
//                                                        highlightedBorderColor:
//                                                            Colors.white60,
//                                                        highlightColor:
//                                                            Colors.red,
//                                                        child: Text("Reject"),
//                                                      ),
//                                                    ),
//                                                    Padding(
//                                                      padding:
//                                                          const EdgeInsets.only(
//                                                              right: 8.0),
//                                                      child: OutlineButton(
//                                                        onPressed: () {
//                                                          Firestore.instance
//                                                              .collection(
//                                                                  "trips")
//                                                              .document(document[
//                                                                  'trip ID'])
//                                                              .updateData({
//                                                            'subscribers':
//                                                                FieldValue
//                                                                    .arrayUnion([
//                                                              document[
//                                                                      'requests']
//                                                                  [position]
//                                                            ]),
//                                                            'requests': FieldValue
//                                                                .arrayRemove([
//                                                              document[
//                                                                      'requests']
//                                                                  [position]
//                                                            ]),
//                                                          });
//                                                          //todo accept bid
//                                                        },
//                                                        borderSide: BorderSide(
//                                                            color:
//                                                                Colors.green),
//                                                        highlightColor:
//                                                            Colors.green,
//                                                        highlightedBorderColor:
//                                                            Colors.white60,
//                                                        child: Text("Accept"),
//                                                      ),
//                                                    ),
//                                                  ],
//                                                ),
//                                                Divider(
//                                                  color: Colors.black38,
//                                                )
//                                              ],
//                                            ),
//                                          );
//                                        }),
//                                document['subscribers'] == null ||
//                                        document['subscribers'].length == 0
//                                    ? Container(
//                                        height: 100,
//                                        child: Center(
//                                            child: Text(
//                                          "no requests",
//                                          style: TextStyle(fontSize: 18),
//                                        )),
//                                      )
//                                    : ListView.builder(
//                                        shrinkWrap: true,
//                                        itemCount:
//                                            document['subscribers'].length,
//                                        itemBuilder: (BuildContext context,
//                                            int position) {
//                                          return Padding(
//                                            padding: const EdgeInsets.all(10.0),
//                                            child: Column(
//                                              children: [
//                                                ListTile(
//                                                  leading: CircleAvatar(
//                                                    child: Text(
//                                                      document['subscribers']
//                                                              [position]
//                                                          ['user name'][0],
//                                                      style: TextStyle(
//                                                          fontSize: 25),
//                                                    ),
//                                                  ),
//                                                  title: Text(
//                                                    document['subscribers']
//                                                        [position]['user name'],
//                                                    style:
//                                                        TextStyle(fontSize: 20),
//                                                  ),
//                                                  trailing: Text(
//                                                    "seats: ${document['subscribers'][position]['booked seats'].toString()}",
//                                                    style: TextStyle(
//                                                      fontSize: 20,
//                                                    ),
//                                                  ),
//                                                ),
//                                                Divider(
//                                                  color: Colors.black38,
//                                                )
//                                              ],
//                                            ),
//                                          );
//                                        }),
//                              ],
//                            ),
//                          ),
//                        );
//                      });
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
                trailing:                //End trip button
                    OutlineButton(
                        borderSide: BorderSide(color:Colors.greenAccent),
                        highlightColor: Colors.red,
                        highlightedBorderColor: Colors.white60,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Cancel booking?"),
                                content: Text(
                                    "Concern your club for your cash back if any"),
                                actions: [
                                  FlatButton(
                                    child: Text("No"),
                                    onPressed: () {
                                      //todo cancel booking

                                      Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text("Yes"),
                                    onPressed: () {
                                      Firestore.instance
                                          .collection("trips")
                                          .document(document['trip ID'])
                                          .updateData({
                                        'total seats': document['total seats'] +
                                            document['subscribers'][index]['booked seats'],
                                        'booked seats': document['booked seats'] -
                                            document['subscribers'][index]['booked seats'],
                                        'subscribers': FieldValue
                                            .arrayRemove([
                                          document['subscribers'][index]
                                        ]),
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text("Cancel")),
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

