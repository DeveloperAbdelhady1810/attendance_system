import 'dart:math';

import 'package:attendants/classes/session.dart';
String code = "";
List<String> codes = [];
List alphabet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
List upperCaseAlphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
List numbers = ["1","2","3","4","5","6","7","8","9","10"];
String part1 ="";
String part2 ="";
String part3 ="";
String part4 ="";
class CreateCodes{
  createCodes(int numberOfCodes){
    for (var i = 0; i < numberOfCodes; i++) {
      numbers.shuffle();
      alphabet.shuffle();
      upperCaseAlphabet.shuffle();
      for (var c = 1; c < 7; c++) {
        if (c == 1) {
          part1 = upperCaseAlphabet[Random().nextInt(upperCaseAlphabet.length)] +
          numbers[Random().nextInt(numbers.length)] +
          alphabet[Random().nextInt(alphabet.length)];
        }else if(c ==2){
          part2 = upperCaseAlphabet[Random().nextInt(upperCaseAlphabet.length)] +
          numbers[Random().nextInt(numbers.length)] +
          alphabet[Random().nextInt(alphabet.length)];
        }else if(c ==3){
          part3 = upperCaseAlphabet[Random().nextInt(upperCaseAlphabet.length)] +
          numbers[Random().nextInt(numbers.length)] +
          alphabet[Random().nextInt(alphabet.length)];
        }else if(c ==4){
          part4 = upperCaseAlphabet[Random().nextInt(upperCaseAlphabet.length)] +
          numbers[Random().nextInt(numbers.length)] +
          alphabet[Random().nextInt(alphabet.length)];
        }
      }
      code = part1 + part2 + part3 + part4;
      codes.add(code);
    }
    // print(codes);
    return codes;
  }
  
}