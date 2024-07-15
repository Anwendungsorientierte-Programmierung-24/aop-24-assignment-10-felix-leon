import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:r_place/Canvas/pixel.dart';
import 'package:r_place/Canvas/pixel_service.dart';
import 'package:r_place/screens/login_screen.dart';
import 'package:r_place/services/auth_service.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({Key? key}) : super(key: key);

  @override
  _CanvasScreenState createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  Color _selectedColor = Colors.black;

  void _navigateToLoginScree() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  Future<void> _logout() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signOut();
      _navigateToLoginScree();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final pixelService = Provider.of<PixelService>(context);
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
                _logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 50.0),
            Expanded(
              child: StreamBuilder<List<Pixel>>(
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
                        (pixel) => pixel.id == pixelId,
                        orElse: () => Pixel(id: pixelId, color: Colors.white),
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