import 'package:flutter/material.dart';
import 'package:r_place/Canvas/color_palette_tile.dart';

class ColorPalette extends StatefulWidget {
  late void Function(Color) _onColorChange;
  ColorPalette(void Function(Color) onColorChange) {
    _onColorChange = onColorChange;
  }

  @override
  State<StatefulWidget> createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
final List <ColorPaletteTile> _tiles = [
  ColorPaletteTile(Colors.white),
  ColorPaletteTile(Colors.red),
  ColorPaletteTile(Colors.green),
  ColorPaletteTile(Colors.blue),
  ColorPaletteTile(Colors.yellow),
  ColorPaletteTile(Colors.brown),
  ColorPaletteTile(Colors.black),
  ColorPaletteTile(Colors.orange),
  ColorPaletteTile(Colors.pink),
  ColorPaletteTile(Colors.purple),
  ColorPaletteTile(Colors.lightBlue),
  ColorPaletteTile(Colors.grey)
];

@override
  void initState() {
    super.initState();
    _fillList();
  }

  //filling the tile list with funtions
  _fillList(){
    setState(() {
      for (int i = 0; i < _tiles.length; i++){
      _tiles[i].setFunctions(widget._onColorChange);
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemCount: _tiles.length,
      itemBuilder: (BuildContext context, int index) {
        return _tiles[index];
      },
    );
  }
}
