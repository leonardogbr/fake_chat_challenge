import 'dart:typed_data';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final Uint8List image;

  CustomAvatar({this.image});

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: 25,
        child: ClipOval(
          child: Image.memory(
            image,
          ),
        ),
      );
}
