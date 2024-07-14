import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_place/Canvas/Canvas_color_palette.dart';
import 'package:r_place/Canvas/canvas_display.dart';
import 'package:r_place/Canvas/canvas_tile.dart';
import 'package:r_place/Canvas/firebase_service.dart';

class CanvasService extends StatefulWidget {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  State<CanvasService> createState() => _CanvasServiceState();
}

class _CanvasServiceState extends State<CanvasService> {
  //attributes for Canvas Service
  final List <CanvasTile> _grid = List.generate(100, (index) => CanvasTile(ID: index.toString()));
  Color _currentColor = Colors.white;
  Color _selectedColor = Colors.black;

  @override
  void initState() {
    super.initState();
    fillCanvasTiles();
  }

  @override
   @override
  Widget build(BuildContext context) {
    final pixelService = Provider.of<FirebaseService>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Canvas',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 5, 33, 248),
          actions: [
            IconButton(
              onPressed: () {
                //_logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 50.0),
            Expanded(
              child: StreamBuilder<List<CanvasTile>>(
                stream: pixelService.getPixels(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final pixels = snapshot.data!;
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 20,
                    ),
                    itemCount: 400,
                    itemBuilder: (context, index) {
                      final pixelId = index.toString();
                      final pixel = pixels.firstWhere(
                        (pixel) => pixel.ID == pixelId,
                        orElse: () => CanvasTile(ID: pixelId, color: Colors.white),
                      );
                      return GestureDetector(
                        onTap: () async {
                          await pixelService.updatePixel(
                              pixelId, _selectedColor);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(1.0),
                          color: pixel.color,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Positioned(
              height: 200.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildColorButton(Colors.red),
                        _buildColorButton(Colors.green),
                        _buildColorButton(Colors.blue),
                      ],
                    ),
                    const SizedBox(
                        height:
                            10.0), // Abstand zwischen den Farb-Button-Reihen
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildColorButton(Colors.yellow),
                        _buildColorButton(Colors.orange),
                        _buildColorButton(Colors.purple),
                      ],
                    ),
                    const SizedBox(
                        height:
                            10.0), // Abstand zwischen den Farb-Button-Reihen
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildColorButton(Colors.black),
                        _buildColorButton(Colors.brown),
                        _buildColorButton(Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: _selectedColor == color ? Colors.black : Colors.transparent,
            width: 3.0,
          ),
        ),
      ),
    );
  }
}

  //changing color of spesific tile
  upDateTile(int index){
    setState(() {
      _grid[index] = CanvasTile(ID: index.toString(), color: _currentColor);
      _grid[index].setOnSelected(upDateTile);
    });
  }

  //changing the Color of one pixel
  updateColor(Color color) {
    setState(() {
      _currentColor = color;
    });
  }

  //giving onColorChange to every CanvasTile
  void fillCanvasTiles(){
    setState(() {
      for (int i = 0; i < _grid.length; i++){
        _grid[i].setOnSelected(upDateTile); 
      }
    });
  }
}
