import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageBytesBase64;

  const ProfileAvatar({
    Key? key,
    required this.imageBytesBase64,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytesDecoded;
    if (imageBytesBase64 != null && imageBytesBase64!.isNotEmpty) {
      try {
        imageBytesDecoded = base64Decode(imageBytesBase64!);
      } catch (e) {
        imageBytesDecoded = null;
      }
    }

    return GestureDetector(
      child: CircleAvatar(
        radius: 40,
        backgroundColor: Colors.grey[300],
        backgroundImage: imageBytesDecoded != null ? MemoryImage(imageBytesDecoded) : null,
        child: imageBytesDecoded == null
            ? Icon(Icons.camera_alt, color: Colors.grey[600])
            : null,
      ),
    );
  }
}
