import 'package:flutter/material.dart';
import 'package:r_place/Canvas/Canvas_color_palette.dart';
import 'package:r_place/Canvas/canvas_display.dart';
import 'package:r_place/Canvas/canvas_tile.dart';

class CanvasService extends StatefulWidget {
  @override
  State<CanvasService> createState() => _CanvasServiceState();
}

class _CanvasServiceState extends State<CanvasService> {
  //attributes for Canvas Service
  //late List<CanvasTile> _grid = List.filled(100, CanvasTile());
  final List <CanvasTile> _grid = List.generate(100, (index) => CanvasTile(ID: index, onSelected: upDateTile));
  Color _currentColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      _grid[index] = CanvasTile(onSelected: upDateTile, ID: index, color: _currentColor);
    });
  }

  //changing the Color of one pixel
  updateColor(Color color) {
    setState(() {
      _currentColor = color;
    });
  }
}
