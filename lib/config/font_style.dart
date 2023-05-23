import 'package:flutter/material.dart';
import 'package:flutter_fashion/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

/// It's a class that returns a TextStyle object
class PrimaryFont {
  PrimaryFont._();
  static PrimaryFont instance = PrimaryFont._();

  /// It's a default value for the fontSize and color.
  final double _fontSize = 14.0;

  /// It's a default value for the color.
  final Color _color = darkColor;

  /// It's a default value for the fontWeight.
  final FontWeight _fontWeight = FontWeight.w500;

  /// It returns a TextStyle object.
  ///
  /// Returns:
  ///   A TextStyle object.
  TextStyle small() {
    return GoogleFonts.robotoSlab(
      fontSize: 12,
      color: _color,
      fontWeight: _fontWeight,
    );
  }

  TextStyle medium() {
    return GoogleFonts.robotoSlab(
      fontSize: 16,
      color: _color,
      fontWeight: _fontWeight,
    );
  }

  TextStyle large() {
    return GoogleFonts.robotoSlab(
      fontSize: 18,
      color: _color,
      fontWeight: _fontWeight,
    );
  }

  TextStyle big() {
    return GoogleFonts.robotoSlab(
      fontSize: 25,
      color: _color,
      fontWeight: _fontWeight,
    );
  }

  /// `copyWith` is a function that returns a new `TextStyle` object with the same properties as the
  /// original `TextStyle` object, except for the properties that are passed in as arguments
  ///
  /// Args:
  ///   fontSize (double): The size of the font.
  ///   color (Color): The color of the text.
  ///   fontWeight (FontWeight): The font weight to use when drawing the text (e.g., bold).
  ///
  /// Returns:
  ///   A TextStyle object.
  TextStyle copyWith({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    double? wordSpacing,
    TextDecoration? decoration,
  }) {
    return GoogleFonts.robotoSlab(
      fontSize: fontSize ?? _fontSize,
      wordSpacing: wordSpacing ?? 1.0,
      color: color ?? _color,
      fontWeight: fontWeight ?? _fontWeight,
      height: height ?? 1.5,
      decoration: decoration,
    );
  }
}
