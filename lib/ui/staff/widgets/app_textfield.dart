import 'package:flutter/material.dart';
import 'package:talkangels/ui/staff/constant/app_color.dart';

class SearchTextFormField extends StatelessWidget {
  TextEditingController? controller;
  final String? hintText;
  final validator;
  final onChanged;
  final Widget? suffixIcon;
  Widget? prefixIcon;
  double? fontSize;
  Color? fillColor;
  Color? color;
  BorderRadiusGeometry? borderRadius;
  bool? enabled;
  Color? hintColor;
  FontWeight? hintFontWeight;
  TextInputType? textInputType;

  SearchTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.fontSize,
    this.fillColor,
    this.color,
    this.borderRadius,
    this.enabled,
    this.hintColor,
    this.hintFontWeight,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color ?? textFieldColor,
          borderRadius: borderRadius ?? BorderRadius.circular(5)),
      child: TextFormField(
        keyboardType: textInputType ?? TextInputType.text,
        onChanged: onChanged,
        enabled: enabled,
        cursorColor: whiteColor,
        controller: controller,
        validator: validator,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'League Spartan'),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          prefixIconColor: whiteColor,
          suffixIcon: suffixIcon,
          hintText: hintText ?? "",
          fillColor: fillColor,
          hintStyle: TextStyle(
              color: hintColor ?? whiteColor.withOpacity(0.20),
              fontSize: fontSize ?? 16,
              fontWeight: hintFontWeight ?? FontWeight.w300,
              fontFamily: 'League Spartan'),
          constraints: const BoxConstraints(maxHeight: 55),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(3),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
