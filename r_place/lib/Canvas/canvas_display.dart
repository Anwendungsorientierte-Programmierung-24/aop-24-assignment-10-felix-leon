import 'package:flutter/material.dart';
import 'package:r_place/Canvas/canvas_tile.dart';
import 'package:r_place/Canvas/firebase_service.dart';

class CanvasDisplay extends StatefulWidget {
  late void Function(int) _onSelected;
  late List<CanvasTile> _grid;

  CanvasDisplay(List<CanvasTile> grid, void Function(int) onSelected) {
    _grid = grid;
    _onSelected = onSelected;
  }

  @override
  State<CanvasDisplay> createState() => _CanvasDisplayState();
}

class _CanvasDisplayState extends State<CanvasDisplay> {
  FirebaseService fb = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<CanvasTile>>(
          stream: fb.getPixels(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final pixels = snapshot.data!;
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 20,
                ),
                itemCount: 400,
                itemBuilder: (context, index) {
                  final pixelId = index.toString();
                  final pixel = pixels.firstWhere(
                    (pixel) => pixel.ID == pixelId,
                    orElse: () => CanvasTile(ID: pixelId, color: Colors.white),
                  );
                });
          }),
    );
  }
}
