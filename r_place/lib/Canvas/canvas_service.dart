import 'package:flutter/material.dart';

class CanvasService {
  late List <Container> _grid;
  final int _size = 10;

  CanvasService (){
    _createGrid();
  }

  _createGrid(){
    for (int y = 0; y < _size; y++){
      for (int x = 0; x < _size; x++){
        _grid.add(Container(decoration: BoxDecoration(color: Colors.green)));
      }
    }
  }

  List <Container> getList (){
    return _grid;
  }
}