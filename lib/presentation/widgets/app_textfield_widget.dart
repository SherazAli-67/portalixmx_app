import 'package:flutter/material.dart';
import 'package:portalixmx_app/l10n/app_localizations.dart';
import '../../core/res/app_colors.dart';
import '../../core/res/app_textstyles.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    TextEditingController? controller,
    required String hintText,
    this.isPassword = false,
    this.readOnly = false,
    TextInputType? textInputType,
    Color fillColor = Colors.white,
    Color hintTextColor = AppColors.greyColor,
    Color borderColor = Colors.transparent,
    int? maxLines,
    String? title,
    TextCapitalization? capitalization
  }) : _textController = controller,_hintText = hintText, _textInputType = textInputType, _fillColor = fillColor, _hintTextColor = hintTextColor, _borderColor = borderColor, _title = title, _capitalization = capitalization;

  final TextEditingController? _textController;
  final String _hintText;

  final bool isPassword;
  final bool readOnly;
  final TextInputType? _textInputType;
  final Color _fillColor;
  final Color _hintTextColor;
  final Color _borderColor;
  // final int? _maxLines;
  final String? _title;
  final TextCapitalization? _capitalization;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 8,
      children: [
        if(widget._title != null)
          Text(widget._title!, style: AppTextStyles.tileTitleTextStyle.copyWith(color: Colors.white),),
        TextField(
          controller: widget._textController,
          readOnly: widget.readOnly,
          obscureText: widget.isPassword && hidePassword,
          keyboardType: widget._textInputType,
          // textCapitalization: widget._capitalization ?? .sentences,
          textCapitalization: widget._capitalization ?? (widget._textInputType != null && widget._textInputType == .emailAddress ? .none : .sentences),
          onTapOutside: (_)=>  FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
              hintText: widget._hintText,
              hintStyle: AppTextStyles.hintTextStyle.copyWith(color: widget._hintTextColor),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: widget._borderColor)
              ),
              suffixIcon: widget.isPassword ? TextButton(
                  onPressed: () => setState(() => hidePassword = !hidePassword),
                  child: Text(hidePassword ? AppLocalizations.of(context)!.show : AppLocalizations.of(context)!.hide, style: AppTextStyles.regularTextStyle.copyWith(color: AppColors.primaryColor),)) : null,
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: widget._borderColor)),
              fillColor: widget._fillColor,
              filled: true
          ),
        ),
      ],
    );
  }
}