import 'package:flutter/material.dart';

class ColorPaletteTile extends StatefulWidget {
  int _id = -1;
  late Color _color;
  Color _borderColor = Colors.white;
  late void Function(Color) _onColorChange;
  late void Function (int) _changeBorderColor;

  ColorPaletteTile(Color color) {
    _color = color;
  }
  @override
  State<StatefulWidget> createState() => _ColorPaletteTileState();

  //setting funktions for tiles
  setFunctions(void Function(Color) onColorChange, void Function (int) changeBorderColor) {
    _onColorChange = onColorChange;
    _changeBorderColor = changeBorderColor;
  }

  //setting id
  setID(int id){
    _id = id;
  }

  //changing the bordercolor to show witch color is selected
  setBorderColor(Color borderColor){
      _borderColor = borderColor;
}
}


class _ColorPaletteTileState extends State<ColorPaletteTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                side: BorderSide(width: 3, color: widget._borderColor),
                backgroundColor: widget._color),
            child: null,
            onPressed: () {
              widget._onColorChange(widget._color);
              widget._changeBorderColor(widget._id);
            }));
  }
}
