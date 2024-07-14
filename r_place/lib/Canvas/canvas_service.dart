import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:r_place/Canvas/Canvas_color_palette.dart';
import 'package:r_place/Canvas/canvas_display.dart';
import 'package:r_place/Canvas/canvas_tile.dart';

class CanvasService extends StatefulWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  State<CanvasService> createState() => _CanvasServiceState();
}

class _CanvasServiceState extends State<CanvasService> {
  //attributes for Canvas Service
  final List <CanvasTile> _grid = List.generate(100, (index) => CanvasTile(ID: index));
  Color _currentColor = Colors.white;

  @override
  void initState() {
    super.initState();
    fillCanvasTiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text("Canvas", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          CanvasDisplay(_grid, upDateTile),
          Expanded(child: ColorPalette(updateColor))
        ],
      ),
    );
  }

  //changing color of spesific tile
  upDateTile(int index){
    setState(() {
      _grid[index] = CanvasTile(ID: index, color: _currentColor);
      _grid[index].setOnSelected(upDateTile);
    });
  }

  //changing the Color of one pixel
  updateColor(Color color) {
    setState(() {
      _currentColor = color;
    });
  }

  //giving onColorChange to every CanvasTile
  void fillCanvasTiles(){
    setState(() {
      for (int i = 0; i < _grid.length; i++){
        _grid[i].setOnSelected(upDateTile); 
      }
    });
  }
}
