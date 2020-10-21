import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final String text;
  final double width;
  final Alignment alignment;
  CustomContainer({
    @required this.text,
    @required this.width,
    this.alignment = Alignment.topLeft,
  });
  @override
  _CustomContainerState createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment,
      child: Container(
          margin: EdgeInsets.all(10),
          height: 30,
          width: widget.width,
          child: Center(
              child: Text(
            "${widget.text}",
            style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 0.5),
          )),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }
}
