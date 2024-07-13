import 'package:flutter/material.dart';
import 'package:r_place/Canvas/canvas_display.dart';
import 'package:r_place/Canvas/canvas_service.dart';

void main() {
  runApp(r_place());
}

class r_place extends StatelessWidget{
  CanvasService service = new CanvasService();
  late Widget home = service.getCanvas();
 
 
  
  @override 
  Widget build (BuildContext context){
    return MaterialApp(
      home:home
    );
  }
}