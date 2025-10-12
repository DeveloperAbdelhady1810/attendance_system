// import 'package:attendants/classes/control_database.dart';
// import 'package:attendants/classes/style.dart';
// import 'package:attendants/classes/user.dart';
// import 'package:attendants/generated/l10n.dart';
// import 'package:attendants/screens/attendants_screen.dart';
// import 'package:flutter/material.dart';
// class StudentCard extends StatelessWidget {
//   const StudentCard({Key? key, required this.student2}) : super(key: key);
//   final Student student2;
//   @override
//   Widget build(BuildContext context) {
//     Color color = Colors.green;
//     return Wrap(
//       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         TextButton(
//           onPressed: (){
//             showDialog(context: context, builder: (context)=>AlertDialog(
//               title: Text('Student Details'),
//               content: Column(),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   }, 
//                   child: Text('Close')
//                 )
//               ],
//             ));
//           },
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25),
//             ),
//             elevation: 4,
//             color: color,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         Style().replace(student2.firstName),
//                         style: Style().style(18,Colors.white,true),
//                         textWidthBasis: TextWidthBasis.parent,
//                         overflow: TextOverflow.clip,
//                       ),
//                       const SizedBox(width: 8,),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment:MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         S.of(context).parrentphone("${Style().replace(student2.parrentPhone)}"),
//                         style: Style().style(15,Colors.white,true),
//                         textWidthBasis: TextWidthBasis.parent,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               onPressed: ()async{
//                 await AttendantsState().removeFromAttendants(student2);
//               },
//               icon: const Icon(
//                 Icons.delete,
//                 color: Colors.red,
//                 size: 30
//               )
//             ),
//             IconButton(
//               onPressed: ()async{
//                 await Control().homeworkmanagment(student: student2);
                
//                 color = Colors.blue;
                
//                 (context as Element).markNeedsBuild();
//                 //print("here");
//               },
//               icon: const Icon(
//                 Icons.home_work,
//                 color: Colors.green,
//                 size: 30
//               )
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }