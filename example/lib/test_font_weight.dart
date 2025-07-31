import 'package:flutter/material.dart';

class CustomFontWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // This should trigger the lint
        Text(
          'Direct FontWeight usage',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // This should trigger the lint
        Text(
          'Another direct usage',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        // This should NOT trigger the lint
        Text(
          'Using CustomFontWeight',
          style: TextStyle(fontWeight: CustomFontWeight.bold),
        ),
      ],
    );
  }
}