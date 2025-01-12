import 'package:flutter/widgets.dart';

//TextStyle builder method
TextStyle _getTextStyle({
  double? fontSize,
  String? fontFamily,
  Color? color,
  FontWeight? fontWeight,
  TextOverflow? textOverflow,
  TextDecoration decoration = TextDecoration.none,
  Color? decorationColor,
  double? height,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    color: color,
    decorationColor: decorationColor,
    letterSpacing: 0,
    decoration: decoration,
    fontWeight: fontWeight,
    overflow: textOverflow,
    height: height,
  );
}

/// Regular TextStyle = FontWeight.w400
class StylesManager {
  /// Medium TextStyle = FontWeight.w500
  static TextStyle medium({
    double fontSize = 10,
    Color? color,
    Color? decorationColor,
    TextOverflow? textOverflow,
    TextDecoration decoration = TextDecoration.none,
    double? height,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
/*       fontFamily: "Tajawal",
 */
      decoration: decoration,
      decorationColor: decorationColor,
      color: color,
      textOverflow: textOverflow,
      fontWeight: FontWeight.w500,
      height: height,
    );
  }

  // /// Light TextStyle = FontWeight.w300
  // static TextStyle light(
  //     {double fontSize = 10,
  //     Color? color,
  //     TextDecoration decoration = TextDecoration.none}) {
  //   return _getTextStyle(
  //     fontSize: fontSize,
  //     fontFamily: AppFonts.font.fontName,
  //     decoration: decoration,
  //     textOverflow: TextOverflow.ellipsis,
  //     color: color,
  //     // fontWeight: AppFonts.font.lightWeight,
  //   );
  // }
  //
  /// SemiBold TextStyle = FontWeight.w700
  static TextStyle semiBold({
    Color? color,
    double? height,
    double fontSize = 10,
    Color? decorationColor,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return _getTextStyle(
      height: height,
      fontSize: fontSize,
      //  fontFamily: Assets.font.tajawalBoldTff,
      decoration: decoration,
      decorationColor: decorationColor,
      color: color,
      fontWeight: FontWeight.w700,
    );
  }

  // /// ExtraBold TextStyle = FontWeight.w800
  // static TextStyle extraBold(
  //     {double fontSize = 10,
  //     Color? color,
  //     TextDecoration decoration = TextDecoration.none}) {
  //   return _getTextStyle(
  //     fontSize: fontSize,
  //     fontFamily: AppFonts.font.fontName,
  //     decoration: decoration,
  //     color: color,
  //     // fontWeight: AppFonts.font.extraBoldWeight,
  //   );
  // }

  // /// Black TextStyle = FontWeight.w900
  // static TextStyle black(
  //     {double fontSize = 10,
  //     Color? color,
  //     TextDecoration decoration = TextDecoration.none}) {
  //   return _getTextStyle(
  //     fontSize: fontSize,
  //     decoration: decoration,
  //     fontFamily: AppFonts.font.fontName,
  //     color: color,
  //     // fontWeight: AppFonts.font.blackWeight,
  //   );
  // }

// // Thin TextStyle
//   static TextStyle thin(
//       {double fontSize = 10,
//       Color? color,
//       TextDecoration decoration = TextDecoration.none}) {
//     return _getTextStyle(
//       fontSize: fontSize,
//       decoration: decoration,
//       fontFamily: AppFonts.font.fontName,
//       color: color,
//       fontWeight: AppFonts.font.extraBoldWeight,
//     );
//   }

// SliverGridDelegateWithFixedCrossAxisCount customSliverGridDelegate({
//   double? height,
//   int? crossAxisCount,
//   MediaType? mediaType,
//   double? mainAxisSpacing,
//   double? crossAxisSpacing,
// }) {
//   switch (mediaType) {
//     case MediaType.reel:
//       return SliverGridDelegateWithFixedCrossAxisCount(
//         mainAxisExtent: height ?? 265.h,
//         crossAxisCount: crossAxisCount ?? 2,
//         mainAxisSpacing: mainAxisSpacing ?? 10.h,
//         crossAxisSpacing: crossAxisSpacing ?? 10.w,
//       );
//     case MediaType.video:
//       return SliverGridDelegateWithFixedCrossAxisCount(
//         mainAxisExtent: height ?? 265.h,
//         crossAxisCount: crossAxisCount ?? 1,
//         mainAxisSpacing: mainAxisSpacing ?? 10.h,
//         crossAxisSpacing: crossAxisSpacing ?? 10.w,
//       );
//     case MediaType.group:
//       return SliverGridDelegateWithFixedCrossAxisCount(
//         mainAxisExtent: height ?? 103.h,
//         crossAxisCount: crossAxisCount ?? 1,
//         mainAxisSpacing: mainAxisSpacing ?? 10.h,
//         crossAxisSpacing: crossAxisSpacing ?? 10.w,
//       );
//     case MediaType.image:
//       return SliverGridDelegateWithFixedCrossAxisCount(
//         mainAxisExtent: height ?? 112.h,
//         crossAxisCount: crossAxisCount ?? 3,
//         mainAxisSpacing: mainAxisSpacing ?? 10.h,
//         crossAxisSpacing: crossAxisSpacing ?? 10.w,
//       );
//     default:
//       return SliverGridDelegateWithFixedCrossAxisCount(
//         mainAxisExtent: height,
//         crossAxisCount: crossAxisCount ?? 1,
//         mainAxisSpacing: mainAxisSpacing ?? 10.h,
//         crossAxisSpacing: crossAxisSpacing ?? 10.w,
//       );
//   }
// }
//
// Size customGridItemSize({
//   double? height,
//   MediaType? mediaType,
//   required double width,
// }) {
//   switch (mediaType) {
//     case MediaType.reel:
//       return Size(width, height ?? 265.h);
//     case MediaType.video:
//       return Size(width, height ?? 265.h);
//     case MediaType.group:
//       return Size(width, height ?? 103.h);
//     case MediaType.image:
//       return Size(width, height ?? 112.h);
//     default:
//       return Size(width, height ?? 10);
//   }
//}
}
