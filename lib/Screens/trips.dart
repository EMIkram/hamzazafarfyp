import 'package:adventure_eye/Screens/mytrips.dart';
import 'package:adventure_eye/Screens/pasttrips.dart';
import 'package:adventure_eye/Screens/upcomingtrips.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adventure_eye/database/globals.dart';
class TripScreen extends StatefulWidget {
  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  int _selectedIndex = 0;
    IconData bottom_bar_icon1 ;

  @override
  Widget build(BuildContext context) {

      List<Widget> _widgetOptions = <Widget>[
     MyTrips(),
     UpcomingTrips(),
      PastTrips(),
    ];
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      }
      );
    }
    return Scaffold(

      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check ),
            title: Text("Bidding"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            title:Text('Upcoming Trips'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.restart),
            title: Text('Past trips'),
          ),
        ],
       currentIndex: _selectedIndex,
        selectedItemColor: Colors.greenAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}


