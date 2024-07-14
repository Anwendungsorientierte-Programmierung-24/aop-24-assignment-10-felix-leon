import 'package:flutter/material.dart';

class ColorPalette extends StatefulWidget {
  late void Function(Color) _onColorChange;
  ColorPalette(void Function(Color) onColorChange) {
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
        //white
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                side: BorderSide(width: 3, color: Colors.white),
                backgroundColor: Colors.white),
            child: null,
            onPressed: () {
              widget._onColorChange(Colors.white);
            }),
        //yellow
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                side: BorderSide(width: 3, color: Colors.white),
                backgroundColor: Colors.yellow),
            child: null,
            onPressed: () {
              widget._onColorChange(Colors.yellow);
            }),
        //pink
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                backgroundColor: Colors.pink),
            child: null,
            onPressed: () {
              widget._onColorChange(Colors.pink);
            }),
        //red
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                backgroundColor: Colors.red),
            child: null,
            onPressed: () {
              widget._onColorChange(Colors.red);
            }),
        //brown
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                backgroundColor: Colors.brown),
            child: null,
            onPressed: () {
              widget._onColorChange(Colors.brown);
            }),
        //purple
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                backgroundColor: Colors.purple),
            child: null,
            onPressed: () {
              widget._onColorChange(Colors.purple);
            }),
        //green
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                backgroundColor: Colors.green),
            child: null,
            onPressed: () {
              widget._onColorChange(Colors.green);
            }),
        //black
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                backgroundColor: Colors.black),
            child: null,
            onPressed: () {
              widget._onColorChange(Colors.black);
            }),
        //lightblue
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                backgroundColor: Colors.lightBlue),
            child: null,
            onPressed: () {
              widget._onColorChange(Colors.lightBlue);
            }),
        //blue
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                backgroundColor: Colors.blue),
            child: null,
            onPressed: () {
              widget._onColorChange(Colors.blue);
            }),
        //orange
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                backgroundColor: Colors.orange),
            child: null,
            onPressed: () {
              widget._onColorChange(Colors.orange);
            }),
        //grey
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: BeveledRectangleBorder(),
                backgroundColor: Colors.grey),
            child: null,
            onPressed: () {
              widget._onColorChange(Colors.grey);
            }),
      ],
    );
  }
}
