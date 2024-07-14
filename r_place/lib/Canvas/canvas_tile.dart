import 'package:flutter/material.dart';

class CanvasTile extends StatelessWidget {
  late int _ID;
  late Color _color;
  late void Function (int) _onSelected;
  CanvasTile({int ID = 0, Color color = Colors.green}){
    _color = color;
    _ID = ID;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: BeveledRectangleBorder(), backgroundColor: _color),
        child: null,
        onPressed: () {
          _onSelected(_ID);
        });
  }

  //setting canvas OnSelected Funktion
  setOnSelected(void Function (int) onSelected){
    	_onSelected = onSelected;
  }
}
