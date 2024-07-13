import 'package:flutter/material.dart';
import 'package:r_place/Canvas/canvas_tile.dart';

class CanvasDisplay extends StatefulWidget {
  late void Function (int) _onSelected;
  late List<CanvasTile> _grid;

  CanvasDisplay(List<CanvasTile> grid, void Function (int) onSelected) {
    _grid = grid;
    _onSelected = onSelected;
  }

  @override
  State<CanvasDisplay> createState() => _CanvasDisplayState();
}

class _CanvasDisplayState extends State<CanvasDisplay> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
            itemCount: widget._grid.length,
            itemBuilder: (context, index) {
              return widget._grid[index];
            }));
  }
}
