import 'dart:ui';

class Pixel {
  final String id;
  final Color color;

  Pixel({required this.id, required this.color});

  factory Pixel.fromMap(Map<String, dynamic> data, String documentId) {
    return Pixel(
      id: documentId,
      color: Color(data['color']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color.value,
    };
  }
}