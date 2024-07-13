import 'package:flutter/material.dart';
import 'package:r_place/Canvas/canvas_display.dart';

void main() {
  runApp(r_place());
}

class r_place extends StatelessWidget{
  @override 
  Widget build (BuildContext context){
    return MaterialApp(
      home:CanvasDisplay()
    );
  }
}