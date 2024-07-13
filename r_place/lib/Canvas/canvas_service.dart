import 'package:flutter/material.dart';
import 'package:r_place/Canvas/canvas_display.dart';
import 'package:r_place/Canvas/canvas_tile.dart';

class CanvasService extends StatefulWidget {
  @override
  State<CanvasService> createState() => _CanvasServiceState();
}

class _CanvasServiceState extends State<CanvasService> {
  //attributes for Canvas Service
  late List<CanvasTile> _grid = List.filled(
      100, CanvasTile());

  @override
  Widget build(BuildContext context) {
    return CanvasDisplay(_grid);
  }
}
