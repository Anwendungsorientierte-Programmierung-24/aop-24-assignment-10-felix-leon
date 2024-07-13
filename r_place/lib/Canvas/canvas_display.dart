import 'package:flutter/material.dart';
import 'package:r_place/Canvas/canvas_service.dart';

class CanvasDisplay extends StatefulWidget {
  late List <Container> _grid;

  CanvasDisplay (List <Container> grid){
    _grid = grid;
  }


  @override
  State<CanvasDisplay> createState() => _CanvasDisplayState();
}

class _CanvasDisplayState extends State <CanvasDisplay> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
      itemCount: widget._grid.length,
      itemBuilder: (context, index){
        return widget._grid[index];
      });
  }
}