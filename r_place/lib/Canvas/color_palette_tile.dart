import 'package:flutter/material.dart';

class ColorPaletteTile extends StatefulWidget {
  late Color _color;
  Color _borderColor = Colors.white;
  late void Function (bool) _changeColor;
  late void Function (Color) _onColorChange;

  ColorPaletteTile(Color color){
    _color = color;
  }
  @override
  State<StatefulWidget> createState() => _ColorPaletteTileState();

  //setting funktions for tiles
  setFunctions(void Function (Color) onColorChange){
    _onColorChange = onColorChange;
  }
}

class _ColorPaletteTileState extends State <ColorPaletteTile>{

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                side: BorderSide(width: 3, color: widget._borderColor),
                backgroundColor: widget._color),
            child: null,
            onPressed: () {
              widget._onColorChange(widget._color);
            });
  }
}