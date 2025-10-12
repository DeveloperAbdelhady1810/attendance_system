import 'package:attendants/classes/style.dart';
import 'package:attendants/generated/l10n.dart';
import 'package:flutter/material.dart';
class CodeCard extends StatelessWidget {
  const CodeCard({Key? key,required this.code,required this.index}) : super(key: key);
  final String code;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding : const EdgeInsets.all(10),
      margin:const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.3 -25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: const[
          BoxShadow(
            blurRadius: 8,
            color: Colors.blue,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Text(
                index.toString(),
                style: Style().style(20,Colors.black,true),
              ),
              const SizedBox(),
            ],
          ),
          const SizedBox(height: 7,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // "Code :",
                S.of(context).code,
                style: Style().style(18,Colors.black,false),
              ),
              Text(
                code,
                style: Style().style(18,Colors.black,false),
              ),
            ],
          ),
        ]
      )
    );    
  }
}