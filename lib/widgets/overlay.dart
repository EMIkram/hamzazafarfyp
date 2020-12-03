import 'dart:ffi';

import 'package:flutter/material.dart';





double width = 1700;

class OverLayContainer extends StatefulWidget {
  List  litems;
  int selected_Index;
  bool show = true;
  String selected_Item ;
  VoidCallback onSelected;
  Pointer<dynamic> city  ;
  OverLayContainer({
    this.litems,
    this.onSelected

  }
      ){

  }



  @override
  _OverLayContainerState createState() => _OverLayContainerState();
}

class _OverLayContainerState extends State<OverLayContainer> {

  @override
  Widget build(BuildContext context) {
    if(widget.show){
      width=1700;
    }
    else {
      width=0;
    }
    if(widget.litems.length!=null){
      return Padding(
        padding: const EdgeInsets.only(left:12.0,right:12,top: 60 ),
        child: Container(

            height:width,
            width:width,
            child: new ListView.builder
              (
                itemCount: widget.litems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      color: Colors.greenAccent,
                      child: FlatButton(
                        onPressed: (){

                          setState(() {
                            widget.show= false;

                          });

                          return widget.onSelected();
                        },

                        child: Text( widget.litems[index],
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                          ),),
                      )


                  );
                }
            )
        ),
      );
    }
    else
      return Container(
        height: 0,
        width: 0,
      );

  }
}



