// List<Widget> streamBuilders = [
//       Container(
//         margin: const EdgeInsets.all(10),
//         width: MediaQuery.of(context).size.width * 0.3,
//         height: MediaQuery.of(context).size.height,
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(
//           border: const Border(
//             right: BorderSide(width: 6,color:Colors.blue),
//             left: BorderSide(width: 6,color:Colors.blue),
//             top: BorderSide(width: 6,color:Colors.blue),
//             bottom: BorderSide(width: 6,color:Colors.blue),
//           ),
//           borderRadius: BorderRadius.circular(18)
//           // color: Colors.blue[300]
//         ),
//         child: 
//         selectedBranch!="Select"?
//         ModalProgressHUD(
//           inAsyncCall: gettingExpected,
//           child: SingleChildScrollView(
//             controller: ScrollController(),
//             child: Column(
//               children: expectedAttendantsStudentsWidgets
//             ),
//           ),
//         )
//         : const Text("Select Branch")
        
//       ),
//       Container(
//         margin: const EdgeInsets.all(10),
//         padding: const EdgeInsets.all(18),
//         width: MediaQuery.of(context).size.width * 0.3,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           border: const Border(
//             right: BorderSide(width: 6,color:Colors.green),
//             left: BorderSide(width: 6,color:Colors.green),
//             top: BorderSide(width: 6,color:Colors.green),
//             bottom: BorderSide(width: 6,color:Colors.green),
//           ),
//           borderRadius: BorderRadius.circular(18)
//           // color: Colors.blue[300]
//         ),
//         child:selectedBranch!="Select"?
//         ModalProgressHUD(
//           inAsyncCall: gettingAttendants,
//           child: SingleChildScrollView(
//             controller: ScrollController(),
//             child: Column(
//               children: attendantsStudentsWidgets.reversed.toList(),
//             ),
//           ),
//         )
//         : const Text("Select Branch")
//       ),
//       Container(
//         margin: const EdgeInsets.all(10),
//         padding: const EdgeInsets.all(18),
//         width: MediaQuery.of(context).size.width * 0.3,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           border: const Border(
//             right: BorderSide(width: 6,color:Colors.red),
//             left: BorderSide(width: 6,color:Colors.red),
//             top: BorderSide(width: 6,color:Colors.red),
//             bottom: BorderSide(width: 6,color:Colors.red),
//           ),
//           borderRadius: BorderRadius.circular(18)
//         ),
//           // color: Colors.blue[300]
//         child:selectedBranch!="Select"? 
//         SingleChildScrollView(
//           controller: ScrollController(),
//           child: Column(
//             children: blockedStudentsFromAttend
//           ),
//         )
//         : const Text("Select Branch")
        
//       ),
//     ];
    



// http.Response response = await http.get(
      //   Uri.parse(
      //     "${Variables().ip}add_to_attendants.php?name=${currentAttendantsSession.name.toString().replaceAll(' ','Ahmed')}&attendants=${currentAttendantsSession.attendants.toString().replaceAll(' ','Ahmed')}&stage=${currentAttendantsSession.stage}"
      //   )
      // );
      // // print("${Variables().ip}add_to_attendants.php?name=${currentAttendantsSession.name.toString().replaceAll(' ','Ahmed')}&attendants=${currentAttendantsSession.attendants.toString().replaceAll(' ','Ahmed')}&stage=${currentAttendantsSession.stage}");
      // if(response.body.toString()=="Success"){
      //   setState((){
      //     attendantsStudents.add(student);
      //     student3Email = student.email;
      //   });
      //   // await forLoops(3);
      // }




    // await forLoops(4);
    // attendantsStudentsWidgets.removeAt(index-1);
    // http.Response response = await http.get(
    //   Uri.parse(
    //     "${Variables().ip}add_to_attendants.php?name=${currentAttendantsSession.name.toString().replaceAll(' ','Ahmed')}&attendants=${currentAttendantsSession.attendants.toString().replaceAll(' ','Ahmed')}&stage=${currentAttendantsSession.stage}"
    //   )
    // );
    // await manageAttendants();


// http.Response response = await http.get(
        //   Uri.parse(
        //     "${Variables().ip}search.php?table=studentsInfo&column=$field&value=$searchQuery"
        //   )
        // );
        // if(response.body.toString() != "no users"){
        //   Map data = jsonDecode(response.body) as Map;
        //   data.forEach((key, value) {
        //     Student student = Student(
        //       cardId: value['id'],
        //       email: value['email'],
        //       firstName: value['firstname'],
        //       gender: value['gender'],
        //       lastName: value['lastname'],
        //       parrentEmail: value['parrentemail'],
        //       parrentPassword: (int.parse(value['password']) / 2 *32).toString(),
        //       parrentPhone: value['parrentphone'],
        //       password: value['password'],
        //       phone: value['phone'],
        //       stage: value['stage'].toString().replaceAll("QuadroEncoding", " "),
        //       place: value['place'],
        //       state: value['state'],
        //       time: value['time'].toString().replaceAll("QuadroEncoding", " "),
        //       balance: value['time'].toString().replaceAll("QuadroEncoding", " "),
        //     );
        //     setState(() {
        //       searchResults2.add(
        //         Card(
        //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: const BorderSide(width: 1,color: Colors.grey)),
        //           child: Container(
        //             padding: const EdgeInsets.all(18),
        //             margin: const EdgeInsets.all(10),
        //             child: Column(
        //               children: [
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children:[
        //                     Text(
        //                       "${student.firstName} ${student.lastName}",
        //                       style: Style().style(20, Colors.black, true),
        //                     ),
        //                     Text(
        //                       student.stage,
        //                       style: Style().style(20, Colors.black, true),
        //                     ),
        //                   ]
        //                 ),
        //                 const SizedBox(height: 7,),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(
        //                       "Email :",
        //                       style: Style().style(20, Colors.blue, true),
        //                     ),
        //                     Text(
        //                       Style().replace(student.email),
        //                       style: Style().style(18, Colors.black, false),
        //                     )
        //                   ],
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(
        //                       "ID :",
        //                       style: Style().style(20, Colors.blue, true),
        //                     ),
        //                     Text(
        //                       Style().replace(student.cardId),
        //                       style: Style().style(18, Colors.black, false),
        //                     )
        //                   ],
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(
        //                       "Phone :",
        //                       style: Style().style(20, Colors.blue, true),
        //                     ),
        //                     Text(
        //                       Style().replace(student.phone),
        //                       style: Style().style(18, Colors.black, false),
        //                     )
        //                   ],
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(
        //                       "Gender :",
        //                       style: Style().style(20, Colors.blue, true),
        //                     ),
        //                     Text(
        //                       Style().replace(student.gender),
        //                       style: Style().style(18, Colors.black, false),
        //                     )
        //                   ],
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(
        //                       "Password :",
        //                       style: Style().style(20, Colors.blue, true),
        //                     ),
        //                     Text(
        //                       Style().replace(student.password),
        //                       style: Style().style(18, Colors.black, false),
        //                     )
        //                   ],
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(
        //                       "Parrent Email :",
        //                       style: Style().style(20, Colors.blue, true),
        //                     ),
        //                     Text(
        //                       Style().replace(student.parrentEmail),
        //                       style: Style().style(18, Colors.black, false),
        //                     )
        //                   ],
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(
        //                       "Parrent Phone :",
        //                       style: Style().style(20, Colors.blue, true),
        //                     ),
        //                     Text(
        //                       Style().replace(student.parrentPhone),
        //                       style: Style().style(18, Colors.black, false),
        //                     )
        //                   ],
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(
        //                       "Parrent Password :",
        //                       style: Style().style(20, Colors.blue, true),
        //                     ),
        //                     Text(
        //                       Style().replace(student.parrentPassword),
        //                       style: Style().style(18, Colors.black, false),
        //                     )
        //                   ],
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(
        //                       "Center",
        //                       style: Style().style(20, Colors.blue, true),
        //                     ),
        //                     Text(
        //                       Style().replace(student.place),
        //                       style: Style().style(18, Colors.black, false),
        //                     )
        //                   ],
        //                 ),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(
        //                       "Time :",
        //                       style: Style().style(20, Colors.blue, true),
        //                     ),
        //                     Text(
        //                       Style().replace(student.time),
        //                       style: Style().style(18, Colors.black, false),
        //                     )
        //                   ],
        //                 ),
        //                 Center(
        //                   child: TextButton(
        //                     child:Text(
        //                       "Add",
        //                       style:Style().style(20,Colors.indigo,true),
        //                     ),
        //                     onPressed: ()async{
        //                       Navigator.pop(context);
        //                       addStudentToAttendantsManually.clear();
        //                       await addToAttendants(student);
        //                     }
        //                   ),
        //                 )
        //               ],
        //             ),
        //           ),
        //         )
        //       );
        //     });
        //   });
        // }
        