import 'package:attendants/classes/session.dart';
import 'package:flutter/material.dart';
class Style {
  style(double fontSize, Color? color, bool isBold,{FontStyle? fontStyle}){
    return TextStyle(
      fontFamily:'sans-serif',
      fontWeight: isBold? FontWeight.bold:FontWeight.normal,
      color: color,
      fontSize: fontSize,
      fontStyle: fontStyle,
      
    );
  }
  buttonStyle(Color? backgroundColor,Color? overlayColor,double borderRadius){
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(backgroundColor),
      overlayColor: MaterialStateProperty.all(overlayColor),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)))
    );
  }
  replace(var sentence){
    return sentence.toString().replaceAll("(", "").replaceAll(")", "");
  }
  String convertToMunitsSeconds(Duration duration){
    final parsedMinutes = duration.inMinutes % 60;
    final minutes = parsedMinutes < 10
    ? '0$parsedMinutes'
    : parsedMinutes.toString();

    final parsedSeconds = duration.inSeconds % 60;
    final seconds = parsedSeconds < 10
    ? '0$parsedSeconds'
    : parsedSeconds.toString();
    return "$minutes:$seconds";
  }
}