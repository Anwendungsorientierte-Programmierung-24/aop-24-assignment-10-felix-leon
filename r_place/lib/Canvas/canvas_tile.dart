import 'package:flutter/material.dart';

class CanvasTile extends StatelessWidget {
  Color _color = Colors.green;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: BeveledRectangleBorder(), backgroundColor: _color),
        child: null,
        onPressed: () {
          print("Pressed");
        });
  }
}
