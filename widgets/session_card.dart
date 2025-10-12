import 'package:attendants/classes/session.dart';
import 'package:attendants/classes/style.dart';
import 'package:attendants/generated/l10n.dart';
import 'package:attendants/screens/attendants_screen.dart';
import 'package:flutter/material.dart';
class SessionCard extends StatelessWidget {
  const SessionCard({Key? key, required this.sessionName, required this.attendants, required this.branch,required this.time, required this.session}) : super(key: key);
  final String sessionName;
  final String attendants;
  final String branch;
  final String time;
  final Session session;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          child: Container(
            padding : const EdgeInsets.all(20),
            margin:const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.3 -22,
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
                      sessionName,
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
                      // "Attendants :",
                      S.of(context).attendants(session.attendants.length),
                      style: Style().style(18,Colors.black,false),
                    ),
                    Text(
                      attendants,
                      style: Style().style(18,Colors.black,false),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Center :",
                //       style: Style().style(18,Colors.black,false),
                //     ),
                //     Text(
                //       branch,
                //       style: Style().style(18,Colors.black,false),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Time :",
                //       style: Style().style(18,Colors.black,false),
                //     ),
                //     Text(
                //       time,
                //       style: Style().style(18,Colors.black,false),
                //     ),
                //   ],
                // ),
              ]
            )
          ),
          onPressed: (){
            // Navigator.push(context,MaterialPageRoute(builder: (context)=>Attendants(session:session,isworksession: false,)));
          },
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}