import 'package:flutter/material.dart';
import 'package:r_place/Canvas/canvas_service.dart';

class CanvasDisplay extends StatefulWidget {
  @override
  State<CanvasDisplay> createState() => _CanvasDisplayState();
}

class _CanvasDisplayState extends State <CanvasDisplay> {
  late CanvasService cService;
  late List <Container> grid;

  @override 
  initState(){
    super.initState();
    cService = new CanvasService();
    grid = cService.getList();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
      itemBuilder: (context, index){
        return grid[index];
      });
  }
}