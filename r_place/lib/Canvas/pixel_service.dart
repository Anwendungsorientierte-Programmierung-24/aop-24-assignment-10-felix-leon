import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:r_place/Canvas/pixel.dart';

class PixelService  {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Pixel>> getPixels() {
    return _firestore.collection('pixels').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Pixel(
          id: doc.id,
          color: Color(data['color']),
        );
      }).toList();
    });
  }

  Future<void> updatePixel(String id, Color color) async {
    await _firestore.collection('pixels').doc(id).set({
      'color': color.value,
    });
  }
}