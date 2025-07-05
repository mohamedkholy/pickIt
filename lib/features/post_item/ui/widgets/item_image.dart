import 'dart:io';

import 'package:flutter/material.dart';

class ItemImage extends StatelessWidget {
  final String photo;
  final Function(String) onDelete;
  const ItemImage({super.key, required this.photo, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8, bottom: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              File(photo),
              width: 100,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 3,
            right: 3,
            child: GestureDetector(
              onTap: () => onDelete(photo),
              child: Icon(Icons.clear, size: 20, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
