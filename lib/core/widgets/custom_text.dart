import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final TextStyle textStyle;
  final TextAlign ?textAlign;
   const CustomText( {super.key,required this. title, required this. textStyle,this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(title,style: textStyle,textAlign: textAlign,maxLines: 2);
  }
}
