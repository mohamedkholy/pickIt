import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pickit/core/theming/my_colors.dart';
import 'package:pickit/core/theming/my_text_styles.dart';

class MyTextFormField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool isPassword;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  const MyTextFormField({
    super.key,
    required this.hint,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.maxLines,
    this.isPassword = false,
    this.focusNode,
    this.onChanged,
  });

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  bool isPassword = false;

  @override
  void initState() {
    super.initState();
    isPassword = widget.isPassword;
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: MyTextStyles(context).font16BlackRegular,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines,
      obscureText: isPassword,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon:
            widget.isPassword
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                  icon: Icon(
                    size: 24,
                    color: MyColors(context).primaryColorDark,
                    isPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                )
                : null,
        hintText: widget.hint,
        hintStyle: MyTextStyles(context).font16BrownRegular,
        filled: true,
        fillColor: MyColors(context).secondaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
