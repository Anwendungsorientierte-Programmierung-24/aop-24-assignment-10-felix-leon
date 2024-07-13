import 'package:flutter/material.dart';

class CanvasDisplay extends StatefulWidget {
  @override
  State<CanvasDisplay> createState() => _CanvasDisplayState();
}

class _CanvasDisplayState extends State <CanvasDisplay> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 10,
      children:[
        Container(
          decoration: BoxDecoration( color: Colors.green),
        )
      ]
    );
  }
}