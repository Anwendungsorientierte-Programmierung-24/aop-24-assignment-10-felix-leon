import 'dart:ui';

class Pixel {
  final String id;
  final Color color;

  Pixel({required this.id, required this.color});

  //decyfering form database
  factory Pixel.fromMap(Map<String, dynamic> data, String documentId) {
    return Pixel(
      id: documentId,
      color: Color(data['color']),
    );
  }

  //converting to map for loading in database
  Map<String, dynamic> toMap() {
    return {
      'color': color.value,
    };
  }
}