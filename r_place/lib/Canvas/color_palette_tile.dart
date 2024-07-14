import 'package:flutter/material.dart';

class ColorPaletteTile extends StatefulWidget {
  late Color _color;
  Color _borderColor = Colors.white;
  late void Function (bool) _changeColor;
  late void Function (Color) _onColorChange;

  ColorPaletteTile(Color color, void Function (bool) changeColor, void Function (Color) onColorChange){
    _color = color;
    _changeColor = changeColor;
    _onColorChange = onColorChange;
  }
  @override
  State<StatefulWidget> createState() => _ColorPaletteTileState();
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
              widget._onColorChange(Colors.white);
            });
  }
}