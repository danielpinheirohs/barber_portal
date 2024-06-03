import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BRBTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final int? minLines;
  final int? maxLines;
  final MaskTextInputFormatter? inputMask;
  final bool? alignLabelWithHint;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool readOnly;

  const BRBTextFormField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.errorText,
    this.minLines,
    this.maxLines,
    this.inputMask,
    this.alignLabelWithHint,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.textInputAction,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      minLines: minLines,
      maxLines: maxLines,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      readOnly: readOnly,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelText: label,
        alignLabelWithHint: alignLabelWithHint,
        hintText: hint,
        focusColor: const Color(0xff00478F),
        errorText: errorText,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: Colors.black.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      inputFormatters: inputMask != null ? [inputMask!] : null,
    );
  }
}
