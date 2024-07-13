import 'package:flutter/material.dart';
import 'package:r_place/Canvas/canvas_display.dart';

class CanvasService {
  //attributes for Canvas Service
  late List <Container> _grid = List.filled(100, Container(decoration: BoxDecoration(color: Colors.green)));
  final int _size = 100;

  //Attributes for CanvasDisplay
  late CanvasDisplay _cDisp;


//Canvas Service Contructor
  CanvasService (){
    _initiateGrid();
  }

  _initiateGrid () async{
    await _createGrid();
  }
  
  _createGrid() {
      for (int x = 0; x < _size; x++){
        _grid.add(Container(decoration: BoxDecoration(color: Colors.green)));
      }
  }

  //Getter for Canvas Display
  Widget getCanvas(){
    _cDisp = new CanvasDisplay(_grid);
    return _cDisp;
  }

  //changing Color of Pixel
  changeColor (int index, Color color){
    _grid[index] = Container(decoration: BoxDecoration(color: color));
  }

}