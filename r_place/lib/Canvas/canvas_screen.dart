import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_place/Canvas/pixel.dart';
import 'package:r_place/Canvas/pixel_service.dart';
import 'package:r_place/screens/login_screen.dart';
import 'package:r_place/services/auth_service.dart';

// Main widget for the Canvas screen.
class CanvasScreen extends StatefulWidget {
  // constantss
  static const String _title = 'R/Place Canvas';
  const CanvasScreen({super.key});

  @override
  _CanvasScreenState createState() => _CanvasScreenState();
}

// State class for CanvasScreen to manage state and build the UI.
class _CanvasScreenState extends State<CanvasScreen> {
  // class variables
  Color _selectedColor = Colors.white; // Default selected color.

  // Navigates to the login screen.
  void _navigateToLoginScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  // Handles user logout and navigates to the login screen.
  Future<void> _logout() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      // Sign out the user by using the signOut method of AuthService
      await authService.signOut();
      // Navigate to the login screen by using _navigateToLoginScreen
      _navigateToLoginScreen();
    } catch (e) {
      // Show any error message by a snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          e.toString(),
        ),
      ));
    }
  }

  // Method which resets all pixels to white
  Future<void> _resetPixels(List<Pixel> pixels) async {
    final pixelService = Provider.of<PixelService>(context, listen: false);
    for (var pixel in pixels) {
      // Update each pixel to white
      await pixelService.updatePixel(pixel.id, Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access pixel service
    final pixelService = Provider.of<PixelService>(context);
    // SafeArea to display the statusbar
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.black87,
          ),
          child: Column(
            children: [
              AppBar(
                automaticallyImplyLeading: false,
                title: const Text(
                  // Title displayed in the AppBar
                  CanvasScreen._title,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 5, 33, 248),
                actions: [
                  // Logout action when button is pressed by using the _logout
                  // method
                  IconButton(
                    onPressed: _logout,
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // SizedBox to create some space
              const SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3.0,
                  ),
                ),
                // Height of the grid
                height: MediaQuery.of(context).size.width,
                child: StreamBuilder<List<Pixel>>(
                  // Stream to get pixel data
                  stream: pixelService.getPixels(),
                  builder: (context, snapshot) {
                    // Loading indicator
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    // Access pixel data
                    final pixels = snapshot.data!;
                    return Container(
                      // Background color for the grid
                      color: Colors.white,
                      child: GridView.builder(
                        physics:
                            // Disable scrolling
                            const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          // Number of columns in the grid
                          crossAxisCount: 16,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                        ),
                        // Total number of pixels
                        itemCount: 256,
                        // Get pixel ID
                        itemBuilder: (context, index) {
                          final pixelId = index.toString();
                          final pixel = pixels.firstWhere(
                            (pixel) => pixel.id == pixelId,
                            orElse: () => Pixel(
                              id: pixelId,
                              // Default color if pixel not found
                              color: Colors.white,
                            ),
                          );
                          return GestureDetector(
                            onTap: () async {
                              // Update pixel color on tap by using the
                              // updatePixel method from PixelService
                              await pixelService.updatePixel(
                                  pixelId, _selectedColor);
                            },
                            child: Container(
                              // Set pixel color.
                              color: pixel.color,
                              margin: EdgeInsets.zero,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              // SizedBox to create some space
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 60.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildColorButton(Colors.red),
                        _buildColorButton(Colors.green),
                        _buildColorButton(Colors.blue),
                        _buildColorButton(Colors.pink),
                      ],
                    ),
                    // SizedBox to create some space
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildColorButton(Colors.yellow),
                        _buildColorButton(Colors.orange),
                        _buildColorButton(Colors.purple),
                        _buildColorButton(Colors.lime),
                      ],
                    ),
                    // SizedBox to create some space
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildColorButton(Colors.black),
                        _buildColorButton(Colors.brown),
                        _buildColorButton(Colors.grey),
                        _buildColorButton(Colors.white),
                      ],
                    ),
                    // SizedBox to create some space
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StreamBuilder<List<Pixel>>(
                          // Stream to get pixel data for reset.
                          stream: pixelService.getPixels(),
                          builder: (context, snapshot) {
                            // Loading indicator.
                            if (!snapshot.hasData) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            // Access pixel data
                            final pixels = snapshot.data!;
                            // Reset action by using _resetPixels method
                            return IconButton(
                              onPressed: () => _resetPixels(pixels),
                              icon:
                                  const Icon(Icons.delete, color: Colors.white),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Builds a color button for the color palette.
  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        // Set the selected color
        setState(() {
          _selectedColor = color;
        });
      },
      child: Container(
        // Margin around the color button
        margin: const EdgeInsets.all(4.0),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          // Color of the button
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: _selectedColor == color ? Colors.red : Colors.white,
            width: 6.0,
          ),
        ),
      ),
    );
  }
}