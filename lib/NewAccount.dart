import 'package:flutter/material.dart';

class NewAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomRight,
          widthFactor: 1,
          heightFactor: 1.7,
          child: Container(
            height: 600,
            alignment: Alignment(-100, 100),
            margin: const EdgeInsets.only(right: 200),
            decoration: BoxDecoration(
                color: Color(0xFFB7ECE8),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(500),
                    bottomRight: Radius.circular(100))),
          ),
        ),
        Container(
          height: 400,
          width: 400,
          decoration: BoxDecoration(
              color: Color(0xFF8CBEEF),
              borderRadius: BorderRadius.circular(400.0)),
        ),
      ],
    ));
  }
}
