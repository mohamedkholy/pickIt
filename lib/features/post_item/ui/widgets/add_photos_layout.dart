import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class AddPhotosLayout extends StatefulWidget {
  final Function(List<String>) onAddButtonPressed;
  const AddPhotosLayout({super.key, required this.onAddButtonPressed});

  @override
  State<AddPhotosLayout> createState() => _AddPhotosLayoutState();
}

class _AddPhotosLayoutState extends State<AddPhotosLayout> {
  final ImagePicker _imagePicker = ImagePicker();
  final List<String> _photos = [];

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(8),
        strokeWidth: 3,
        dashPattern: [6, 6],
        color: MyColors(context).secondaryColor,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text("Add photos", style: MyTextStyles(context).font18BlackBold),
            SizedBox(height: 8),
            Text(
              "Add photos to show the item's condition",
              textAlign: TextAlign.center,
              style: MyTextStyles(context).font14BlackRegular,
            ),
            SizedBox(height: 24),
            MaterialButton(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              color: MyColors(context).secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              onPressed: () {
                _imagePicker.pickMultiImage().then((value) {
                  setState(() {
                    _photos.addAll(value.map((e) => e.path).toList());
                    while (_photos.length > 5) {
                      _photos.removeAt(0);
                    }
                    widget.onAddButtonPressed(_photos);
                  });
                });
              },
              child: Text(
                "Add photos",
                style: MyTextStyles(context).font14BlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
