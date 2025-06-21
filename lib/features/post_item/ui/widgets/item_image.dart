import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemImage extends StatelessWidget {
  final String photo;
  final Function(String) onDelete;
  const ItemImage({super.key, required this.photo, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w, bottom: 8.h),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.file(
              File(photo),
              width: 100.w,
              height: 130.h,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 3.h,
            right: 3.w,
            child: GestureDetector(
              onTap: () => onDelete(photo),
              child: Icon(Icons.clear, size: 20.dg, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
