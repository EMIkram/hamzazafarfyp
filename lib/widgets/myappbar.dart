
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MyAppbar extends PreferredSize{
  @override
  Widget build(BuildContext context) => PreferredSize(
      child: Padding(
        padding: const EdgeInsets.only(top:10.0,left: 8,right: 8,bottom: 10),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.blueAccent,
              offset: Offset(0, 0.0),
              blurRadius: 4.0,
            )
          ]),
          child: AppBar(
            backgroundColor: Colors.white,
            shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            elevation: 0.0,
            title: Text("Test"),
          ),
        ),
      ),
      preferredSize: Size.fromHeight(kToolbarHeight),
    );
}