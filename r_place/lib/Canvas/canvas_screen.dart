import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:r_place/Canvas/pixel.dart';
import 'package:r_place/Canvas/pixel_service.dart';
import 'package:r_place/screens/login_screen.dart';
import 'package:r_place/services/auth_service.dart';
import 'package:r_place/services/connection_service.dart';

// Main widget for the Canvas screen.
class CanvasScreen extends StatefulWidget {
  // Constants
  static const String _title = 'R/Place Canvas';
  const CanvasScreen({super.key});

  @override
  _CanvasScreenState createState() => _CanvasScreenState();
}

// State class for CanvasScreen to manage state and build the UI
class _CanvasScreenState extends State<CanvasScreen> {
  // Class variables
  Color _selectedColor = Colors.white; // Default selected color
  bool _isConnected = false;
  bool _dialogVisible = false;
  bool _isSnackBarVisible = false;

  // Override of the initState method to check the connection status
  @override
  void initState() {
    super.initState();
    _checkInitialConnection();

    // Subscribe to connectivity changes
    final connectionService =
        Provider.of<ConnectionService>(context, listen: false);
    connectionService.status.listen((isConnected) {
      setState(() {
        _isConnected = isConnected;
      });
      // if there is no connection a dialog will be shown by using the
      // _showDialog method
      if (!_isConnected) {
        _showErrorDialog();
        // if the connection is restored a snackbar will be displayed
      } else {
        _showSnackBar();
      }
    });
  }

  // Method displays a snackbar with a message
  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          'Internet connection restored',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // Method displays a Dialog if there is no connection with the internet
  void _showErrorDialog() {
    // Validates that the dialog wasnt displayed before
    if (!_dialogVisible) {
      _dialogVisible = true;
      // ShowDialog displays the error message
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text(
            'Connection problem',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'No internet connection. Please check your connection.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                _dialogVisible = false;
                Navigator.of(context).pop();
              },
              child: const Center(
                child: Text(
                  'OK',
                  style: TextStyle(color: Color.fromARGB(255, 5, 33, 248)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  // Navigates to the login screen.
  void _navigateToLoginScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  // Handles user logout and navigates to the login screen.
  Future<void> _logout() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      // Sign out the user
      await authService.signOut();
      // Navigate to the login screen
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

  // Checks the connection status of the phoen
  Future<bool> checkConnection() async {
    var connection = await (Connectivity().checkConnectivity());
    // Connection with the wifi or flat is needed
    if (connection.contains(ConnectivityResult.wifi) ||
        connection.contains(ConnectivityResult.mobile)) {
      return true;
    } else {
      return false;
    }
  }

  // Method checks the initial connection by using the checkConnection method
  void _checkInitialConnection() async {
    bool isConnected = await checkConnection();
    setState(() {
      _isConnected = isConnected;
    });
    if (!_isConnected) {
      _showErrorDialog();
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
    final pixelService = Provider.of<PixelService>(context);
    // Access pixel service
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
                  // Logout action when button is pressed by using the _logout method
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
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error fetching pixels: ${snapshot.error}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }

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
                                // if there is no connection a snackbar with an
                                // error message will be displayed
                                if (!_isConnected) {
                                  if (!_isSnackBarVisible) {
                                    _isSnackBarVisible = true;
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              'No internet connection. Cannot update pixel.',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        )
                                        .closed
                                        .then((_) {
                                      _isSnackBarVisible =
                                          false; // Reset the flag when the Snackbar is closed
                                    });
                                  }
                                  return;
                                }
                                try {
                                  // Update pixel color on tap by using the
                                  // updatePixel method from PixelService
                                  await pixelService.updatePixel(
                                      pixelId, _selectedColor);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error updating pixel: $e'),
                                    ),
                                  );
                                }
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
                  )),
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
