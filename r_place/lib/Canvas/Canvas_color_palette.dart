import 'package:flutter/material.dart';

class ColorPalette extends StatefulWidget {
  late void Function (Color) _onColorChange;
  ColorPalette (void Function (Color) onColorChange){
    _onColorChange = onColorChange;
  }
  
  @override
  State<StatefulWidget> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      children: [

        //blue
        ElevatedButton(
          child: null,
          onPressed: (){
            widget._onColorChange(Colors.blue);
          })
      ],
    );
  }
}
