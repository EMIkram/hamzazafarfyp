import 'package:flutter/material.dart';

class ImageLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 90,top: 40),
          child: Container(
            alignment: Alignment.center,
            height: 200,
            width: 200,
            color: Color(0xFF2A8DEE),
            child: Text('Image/logo'),
          ),
        )
      ],
    );
  }
}
