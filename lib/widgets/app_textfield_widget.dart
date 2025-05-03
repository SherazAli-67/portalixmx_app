import 'package:flutter/material.dart';
import 'package:portalixmx_app/res/app_colors.dart';

import '../res/app_textstyles.dart' show AppTextStyles;

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required TextEditingController textController,
    required String hintText,
    this.isPassword = false,
    this.readOnly = false,
    TextInputType? textInputType
  }) : _textController = textController,_hintText = hintText, _textInputType = textInputType;

  final TextEditingController _textController;
  final String _hintText;

  final bool isPassword;
  final bool readOnly;
  final TextInputType? _textInputType;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._textController,
      readOnly: widget.readOnly,
      obscureText: widget.isPassword && hidePassword,
      keyboardType: widget._textInputType,
      decoration: InputDecoration(
          hintText: widget._hintText,
          hintStyle: AppTextStyles.hintTextStyle,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: widget.isPassword ? TextButton(
              onPressed: () => setState(() => hidePassword = !hidePassword),
              child: Text(hidePassword ? "Show" :"Hide", style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.primaryColor),)) : null,
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),),
          fillColor: Colors.white,
          filled: true
      ),
    );
  }
}