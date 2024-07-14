import 'package:flutter/material.dart';

class CanvasTile extends StatelessWidget {
  late String ID;
  late Color color;
  late void Function (int) _onSelected;
  CanvasTile({ String ID = "0", Color color = Colors.green}){
    color = color;
    ID = ID;
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color.value,
    };
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: BeveledRectangleBorder(), backgroundColor: color),
        child: null,
        onPressed: () {
          _onSelected(ID as int);
        });
  }

  //setting canvas OnSelected Funktion
  setOnSelected(void Function (int) onSelected){
    	_onSelected = onSelected;
  }
}
