import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  double buttonWidth;
  double buttonHeight;
  Color shapeColor;
  Function onPressed;
  String buttonText;
  BorderRadiusGeometry borderRadiusGeometry;

  MyButton(
      {this.buttonWidth = 0.45,
      this.buttonHeight = 70,
      this.shapeColor = const Color(0xFF2A8DEE),
      @required this.onPressed,
      this.buttonText,
      this.borderRadiusGeometry});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width * this.buttonWidth,
      height: this.buttonHeight,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: this.borderRadiusGeometry,
            side: BorderSide(color: this.shapeColor)),
        padding: const EdgeInsets.all(15),
        color: this.shapeColor,
        child: Text(
          this.buttonText,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: this.onPressed,
      ),
    );
  }
}
