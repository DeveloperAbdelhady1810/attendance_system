// import 'dart:io';
// import 'package:attendants/classes/branch.dart';
// import 'package:attendants/classes/control_database.dart';
// import 'package:attendants/classes/export.dart';
// import 'package:attendants/classes/session.dart';
// import 'package:attendants/classes/sql_center.dart';
// import 'package:attendants/classes/style.dart';
// import 'package:attendants/classes/user.dart';
// import 'package:attendants/classes/variables.dart';
// import 'package:attendants/generated/l10n.dart';
// import 'package:attendants/screens/marks_mode_screen.dart';
// import 'package:attendants/screens/upload_to_server.dart';
// import 'package:flutter/material.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// class Attendants extends StatefulWidget {
//   const Attendants({Key? key,required this.session, required this.isworksession}) : super(key: key);
//   final Session session;
//   final bool isworksession;
//   @override
//   State<Attendants> createState() => AttendantsState();
// }
// FocusNode addStudentToAttendantsManuallyFocus = FocusNode();
// late bool isworksession;
// List<Widget> blockedStudentsFromAttend = [];
// List<Widget> expectedAttendantsStudentsWidgets= [];
// List<Widget> attendantsStudentsWidgets= [];
// List<Student> expectedAttendantsStudents = [];
// List<Student> attendantsStudents = [];
// List<Student> blockedStudentsFromAttendList = [];
// List<Student> manuallyAdded = [];
// List<String> blockedList = [];
// bool gettingExpected = false;
// bool gettingAttendants = false;
// TextEditingController sessionNameController = TextEditingController();
// TextEditingController addStudentToAttendantsManually = TextEditingController();
// bool searching = false;
// List<Widget> streamBuilders = [];
// String selectedBranch = "Select";
// String student3Email = "";
// Session currentAttendantsSession= Session(stage: "", branch: selectedBranch, attendants: [], name: "", time: "",weekday: "",sessionId: "",mark: {},isscientific: false);
// List<DropdownMenuItem<String>> dropdownMenuItems = [
//   DropdownMenuItem(value:"Select",child: Text(S.current.selectBranch))
// ];
// bool attendantsLoading = false;
// bool connected = false;
// String connection = "";
// List<Branch>branches = [
//   Branch(
//     name: "Alfa El Haram",
//     firsttime: "",
//     secondtime: "",
//     thirdtime: "",
//     isFirst: "true",
//     isSecond: "true",
//     isThird: "true",
//     capacity: "0"
//   ),
//   Branch(
//     name: "Alfa El Taawon",
//     firsttime: "",
//     secondtime: "",
//     thirdtime: "",
//     isFirst: "true",
//     isSecond: "true",
//     isThird: "true",
//     capacity: "0"
//   ),
//   Branch(
//     name: "Learn El Mohandseen",
//     firsttime: "",
//     secondtime: "",
//     thirdtime: "",
//     isFirst: "true",
//     isSecond: "true",
//     isThird: "true",
//     capacity: "0"
//   ),
//   Branch(
//     name: "Learn El Dokki",
//     firsttime: "",
//     secondtime: "",
//     thirdtime: "",
//     isFirst: "true",
//     isSecond: "true",
//     isThird: "true",
//     capacity: "0"
//   ),
//   Branch(
//     name: "Teachers Hadye October",
//     firsttime: "",
//     secondtime: "",
//     thirdtime: "",
//     isFirst: "true",
//     isSecond: "true",
//     isThird: "true",
//     capacity: "0"
//   ),
//   Branch(
//     name: "El Nakheel",
//     firsttime: "",
//     secondtime: "",
//     thirdtime: "",
//     isFirst: "true",
//     isSecond: "true",
//     isThird: "true",
//     capacity: "0"
//   ),
//   Branch(
//     name: "Alfa El Lebeeny",
//     firsttime: "",
//     secondtime: "",
//     thirdtime: "",
//     isFirst: "true",
//     isSecond: "true",
//     isThird: "true",
//     capacity: "0"
//   ),
// ];
// int onlinecounter = 0;
// int offlinecounter = 0;
// List offline =[];
// List online = [];
// bool showDropDown = true;
// class AttendantsState extends State<Attendants> {
//   count(state){
//     if(state == "Online"){
//       // print(online.length.toString());
//       List attendedonline = [];
//       for (var student in Variables().attendedBox.values.toList()) {
//         if(student.state == "Online"){
//           setState((){
//             attendedonline.add(student);
//           });
//         }
//       }
//       return attendedonline.length.toString();
//     }
//     else if(state == "Offline"){
//       List attendedoffline = [];
//       for (var student in Variables().attendedBox.values.toList()) {
//         if(student.state == "Offline"){
//           setState((){
//             attendedoffline.add(student);
//           });
//         }
//       }
//       return attendedoffline.length.toString();
//     }
//     else if(state=="expected"){
//       List expected = [];
//       for (var student in Variables().expectedBox.values.toList()) {
//         setState((){
//           expected.add(student);
//         });
//       }
//       return expected.length.toString();
//     }
//     return "0";
//   }
//   prepareOffline()async{
//     setState(() {
//       attendantsLoading = true;
//       showDropDown = false;
//       isworksession = true;
//     });
//     // String quizId3 = await getSessionDetails();
//     // http.Response marks = await http.post(
//     //   Uri.parse(
//     //     "${Variables().ip}get_all_marks.php",
//     //   ),
//     //   body:{
//     //     "quizId":quizId3
//     //   }
//     // );
//     var marksMap = await SqlCenter().getAllMarks(currentAttendantsSession.name,currentAttendantsSession.stage);
//     if (marksMap != "Not Found") {
//       // Map marksMap = jsonDecode(marks.body);
      
//       marksMap.forEach((key, value) {
//         setState((){
//           currentAttendantsSession.mark.addAll({key:value['mark']});
//           Variables().worksession.values.first.mark.addAll({key.toString():value['mark'].toString()});
//         });
//       });
//     }
    
//     // http.Response response = await http.post(
//     //   Uri.parse(
//     //     "${Variables().ip}get_students_manually.php"
//     //   ),
//     //   body:{
//     //     "stage":currentAttendantsSession.stage
//     //   }
//     // );
//     // // print(response.body);
//     // Map students = jsonDecode(response.body);
//     var students = await SqlCenter().getStudentsManually(currentAttendantsSession.stage);
//     if (students != "Not Found") {
//       students.forEach((key, value) async{
//         Student student =  Student(
//           cardId: value['id'].toString(),
//           email: value['email'],
//           firstName: value['firstname'],
//           gender: value['gender'],
//           lastName: value['lastname'],
//           parrentEmail: value['parrentemail'],
//           parrentPassword: "",
//           parrentPhone: value['parrentphone'],
//           password: "",
//           phone: value['phone'],
//           stage: value['stage'].toString().replaceAll("QuadroEncoding", " "),
//           place: value['place'],
//           state: value['state'],
//           time: value['time'].toString().replaceAll("QuadroEncoding", " "),
//           balance: value['balance'].toString().replaceAll("QuadroEncoding", " "),
//         );
//         setState((){
//           manuallyAdded.add(student);
//         });
//         // await Control().addStudent(box: Variables().manuallyAddedBox, student: student);
//       });
//     }
//     // adding data to hive
//     for (Student student in expectedAttendantsStudents) {
//       await Control().addStudent(box: Variables().expectedBox, student: student);
//     }
//     for (String studentEmail in currentAttendantsSession.attendants) {
//       var student = await getStudent(studentEmail);
//       if (student =="Not Found") {} else {
//         setState((){
//           attendantsStudents.add(student);
//         });
//       }
//     }
//     for (Student student in attendantsStudents) {
//       await Control().addStudent(box: Variables().attendedBox, student: student);
//     }
//     for (String studentEmail in blockedList) {
//       await Control().addBlockedStudent(box: Variables().blockedBox, studentEmail: studentEmail);
//     }
//     for (Student student in blockedStudentsFromAttendList) {
//       await Control().blockFromAttend(box: Variables().blockedFromAttend, student: student);
//     }
//     for (Student student in manuallyAdded) {
//       await Control().addStudent(box: Variables().manuallyAddedBox, student: student);
//     }
//     //////////////////////
    
//     setState(() {
//       attendantsLoading = false;
//     });
//   }
//   // getBranches2()async{
//     // branches.clear();
//     // http.Response response = await http.get(
//     //   Uri.parse(
//     //     "${Variables().ip}get_branches.php"
//     //   )
//     // );
//     // Map branchesMap = jsonDecode(response.body);
//     // var branchesMap = await SqlCenter().getBranches();
//   //   branchesMap.forEach((key, value) {
//   //     setState((){
//   //       branches.add(
//   //         Branch(
//   //           name: value['name'],
//   //           firsttime: value['firsttime'],
//   //           secondtime: value['secondtime'],
//   //           thirdtime: value['thirdtime'],
//   //           isFirst: value['isfirst'],
//   //           isSecond: value['issecond'],
//   //           isThird: value['isthird'],
//   //           capacity: value['capacity'].toString(),
//   //         )
//   //       );
//   //     });
//   //   });
//   // }
//   buildDropDown()async{
//     // print(branches);
//     // print(widget.session.stage);
//     dropdownMenuItems.clear();
//     dropdownMenuItems.add(DropdownMenuItem(value:"Select",child: Text(S.current.selectBranch)));
//     if (dropdownMenuItems.length>1) {} else {
//       for (Branch branch in branches) {
//         if(widget.session.stage=="First Secondry"){
//           if(branch.isFirst=="true"){
//             setState(() {
//               dropdownMenuItems.add(
//                 DropdownMenuItem<String>(value: branch.name, child:Text(branch.name))
//               );
//             });
//           }else{}
//         }else if(widget.session.stage=="Second Secondry"){
//           if(branch.isSecond=="true"){
//             setState(() {
//               dropdownMenuItems.add(
//                 DropdownMenuItem<String>(value: branch.name, child:Text(branch.name))
//               );
//             });
//           }else{}
//         }else if(widget.session.stage == "Third Secondry"){
//           if(branch.isThird=="true"){
//             setState(() {
//               dropdownMenuItems.add(
//                 DropdownMenuItem<String>(value: branch.name, child:Text(branch.name))
//               );
//             });
//           }else{}
//         }
//       }
//     }
    
//   }
//   // getSessionDetails()async{
//     // http.Response response = await http.get(
//     //   Uri.parse(
//     //     "${Variables().ip}is_session_found.php?sessionName=${currentAttendantsSession.name}&stage=${currentAttendantsSession.stage}&branch=${currentAttendantsSession.branch}"
//     //   )
//     // );
//     // print("${Variables().ip}is_session_found.php?sessionName=${currentAttendantsSession.name}&stage=${currentAttendantsSession.stage}");
//     // print(response.body);
//     // var response = await SqlCenter().isSessionFound(currentAttendantsSession.name, currentAttendantsSession.stage, currentAttendantsSession.branch);
//     // if (response.toString()!="Not Found"){
//       // var data = jsonDecode(response.body);
//       // setState(() {
//         // sessionId = data['id'];
//         // sessionId = widget.sessionId;
//       //   widget.session.sessionId = response['id'].toString();
//       //   currentAttendantsSession.sessionId = response['id'].toString();
//       //   Variables().worksession.values.first.sessionId = response['id'].toString();
//       // });
//       // http.Response response2 = await http.post(
//       //   Uri.parse(
//       //     "${Variables().ip}get_quiz_id.php"
//       //   ),
//       //   body: {
//       //     "id":currentAttendantsSession.sessionId
//       //   }
//       // );
//       // var response2 = await SqlCenter().getQuizId(currentAttendantsSession.sessionId);
//       // if (response2.toString()!="Not Found") {
//       //   String quizId3 = response2;
//         // print("quizId --------($quizId)");

//       //   return quizId3;
//       // }else{
//       //   //print("quiz id error");
//       // }
//     // }else{
//     //   // print("else");
//     // }
//   // }
//   manageAttendants()async{
//     // expectedAttendantsStudents.clear();
//     // setState(() {
//     //   attendantsStudentsWidgets.clear();
//     //   expectedAttendantsStudentsWidgets.clear();
//     //   blockedStudentsFromAttend.clear();
//     //   attendantsLoading = true;
//     //   gettingExpected = true;
//     //   gettingAttendants = true;
//     // });
//     // http.Response studentsResponse = await http.get(
//     //   Uri.parse(
//     //     "${Variables().ip}get_expected_attendants.php?stage=${currentAttendantsSession.stage.toString().replaceAll(" ", "QuadroEncoding")}&branch=${selectedBranch.replaceAll(" ", "QuadroEncoding")}"
//     //   )
//     // );
//     // var studentsResponse = await  SqlCenter().getExpectedStudent(currentAttendantsSession.stage, selectedBranch);
//     // print(studentsResponse.body);
//     // print("${Variables().ip}get_expected_attendants.php?stage=${currentAttendantsSession.stage.toString().replaceAll(" ", "QuadroEncoding")}&branch=${selectedBranch.replaceAll(" ", "QuadroEncoding")}");
//     // if (studentsResponse != "No student found in this stage") {
//     //     // Map students = jsonDecode(studentsResponse);
//     //     studentsResponse.forEach((key, value) {
//     //       setState(() {
//     //         expectedAttendantsStudents.add(
//     //           Student(
//     //             cardId: value['id'].toString(),
//     //             email: value['email'],
//     //             firstName: value['firstname'],
//     //             gender: value['gender'],
//     //             lastName: value['lastname'],
//     //             parrentEmail: value['parrentemail'],
//     //             parrentPassword: "",
//     //             parrentPhone: value['parrentphone'],
//     //             password: value['password'],
//     //             phone: value['phone'],
//     //             stage: value['stage'].toString().replaceAll("QuadroEncoding", " "),
//     //             place: value['place'],
//     //             state: value['state'],
//     //             time: value['time'].toString().replaceAll("QuadroEncoding", " "),
//     //             balance: value['time'].toString().replaceAll("QuadroEncoding", " "),
//     //           )
//     //         );
//     //       });
//     //       gettingExpected = false;
//     //       gettingAttendants = false;
//     //       attendantsLoading= false;
//     //     });
//     //     // http.Response attendedStudentsResponse = await http.get(
//     //     //   Uri.parse(
//     //     //     "${Variables().ip}get_sessions.php?mode=900&stage=${currentAttendantsSession.stage.toString().replaceAll(' ', 'Ahmed')}&branch=${selectedBranch.toString().replaceAll(" ", "QuadroEncoding")}&&name=${currentAttendantsSession.name.toString().replaceAll(" ", "QuadroEncoding")}"
//     //     //   )
//     //     // );
//     //     var sessions = await SqlCenter().getSessions("900",currentAttendantsSession.stage.toString().replaceAll(" ","QuadroEncoding"),selectedBranch.toString().replaceAll(" ","QuadroEncoding"),currentAttendantsSession.name.toString());
//     //     // if (attendedStudentsResponse != "No Results Found!") {
//     //       // Map sessions = jsonDecode(attendedStudentsResponse);
//     //       sessions.forEach((key, value) async{
//     //         String attendants = value['attendants'];
//     //         List parsedattendants = attendants.toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "").split(",").map((e) => e.toString()).toList();
//     //         for (String studentEmail in parsedattendants) {
//     //           // Student student = await getStudent(studentEmail);
//     //           setState(() {
//     //             currentAttendantsSession.attendants.add(studentEmail);
//     //           });
//     //         }
//     //       });
//     //       await prepareOffline();
//     //     // } else {
//     //     //   print("error");
//     //     // }   
//     // } else {
//     //   setState(() {
//     //     gettingAttendants = false;
//     //     gettingExpected = false;
//     //     attendantsLoading = false;
//     //   });
//     //   showDialog(context: context, builder: (context)=> AlertDialog(content: Text(S.of(context).nodata),));
//     // }
//   }
//   addToAttendants(Student student)async{
//     setState(() {
//       attendantsLoading = true;
//     });
//     setState(() {
//       currentAttendantsSession.attendants.add(student.email);
//     });
//     await Control().addStudent(box: Variables().attendedBox, student: student);
//     await Control().addStudent(box: Variables().homeworkBox, student: student);
//     await Control().deleteStudent(box: Variables().expectedBox, studentEmail: student.email);
//     if(student.state == "Online"){
//       setState((){
//         onlinecounter ++;
//         online.add(student);
//       });
//     }else{
//       setState((){
//         offlinecounter ++;
//         offline.add(student);
//       });
//     }
//     setState((){
//       attendantsLoading = false;
//     });
//   }
//   getStudent(String studentEmail)async{
//     // http.Response response = await http.get(
//     //   Uri.parse(
//     //     "${Variables().ip}login2.php?email=$studentEmail"
//     //   )
//     // );
//     var studentData = await SqlCenter().getStudent(studentEmail);
//     // print("${Variables().ip}login2.php?email=$studentEmail");
//     if(studentData !="Not Found"){
      
//       var student3 = Student(
//         cardId: studentData['id'].toString(),
//         email: studentData['email'],
//         firstName: studentData['firstname'],
//         gender: studentData['gender'],
//         lastName: studentData['lastname'],
//         parrentEmail: studentData['parrentemail'],
//         parrentPassword: "",
//         parrentPhone: studentData['parrentphone'],
//         password: "",
//         phone: studentData['phone'],
//         stage: studentData['stage'].toString().replaceAll("QuadroEncoding", " "),
//         place: studentData['place'],
//         state: studentData['state'],
//         time: studentData['time'].toString().replaceAll("QuadroEncoding", " "),
//         balance: studentData['balance'].toString().replaceAll("QuadroEncoding", " "),
//       );
//       return student3;
//     }else{
//       return "Not Found";
//     }
//   }
//   async()async{
//     await buildDropDown();
//   }
//   removeFromAttendants(Student student)async{
//     // print("in delete");
//     setState(() {
//       attendantsLoading = true;
//       currentAttendantsSession.attendants.remove(student.email);
//       attendantsStudents.remove(student);
//       student3Email = student.email;
//     });
//     await Control().deleteStudent(box: Variables().attendedBox, studentEmail: student.email);
//     await Control().addStudent(box: Variables().expectedBox, student:student);
//     prepareOffline();
//     setState((){
//       attendantsLoading = false;
//     });
//   }
//   forLoops(int mode)async{
//     // print(expectedAttendantsStudents.length);
//     if (mode ==1) {
//       for(Student student2 in expectedAttendantsStudents){
//         setState((){
//           expectedAttendantsStudentsWidgets.add(
//             Wrap(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   onPressed: (){
//                     showDialog(context: context, builder: (context)=>AlertDialog(
//                       title: Text(
//                         "${student2.firstName} ${student2.lastName} Details",
//                       ),
//                       content: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("ID :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.cardId),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Email :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.email),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Phone :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.phone),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Parrent Phone :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.parrentPhone),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("State :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.state),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Password :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.password),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Center :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.place),
//                             ]
//                           ),
//                         ],
//                       )
//                     ));
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     elevation: 4,
//                     color: Colors.indigo,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             Style().replace(student2.firstName),
//                             style: Style().style(18,Colors.white,true),
//                           ),
//                           const SizedBox(width: 8,),
//                           Text(
//                             S.of(context).parrentphone("${Style().replace(student2.parrentPhone)}"),
//                             style: Style().style(15,Colors.white,true),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: ()async{
//                     await addToAttendants(student2);
//                   },
//                   icon: const Icon(
//                     Icons.check,
//                     color: Colors.indigo,
//                     size: 30
//                   )
//                 )
//               ],
//             )
//           );
//         });
//       }
//       for(String student3Email in currentAttendantsSession.attendants){
//         var student3 = await getStudent(student3Email);
//         if(student3 == "Not Found"){

//         }else{
//           setState(() {
//             attendantsStudents.add(student3);
//             attendantsStudentsWidgets.add(
//               Wrap(
//                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: (){
//                       showDialog(context: context, builder: (context)=>AlertDialog(
//                         title: Text(
//                           "${student3.firstName} ${student3.lastName} Details",
//                         ),
//                         content: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("ID :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.cardId),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Email :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.email),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Phone :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.phone),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Parrent Phone :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.parrentPhone),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("State :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.state),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Password :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.password),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Center :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.place),
//                               ]
//                             ),
//                           ],
//                         )
//                       ));
//                     },
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       elevation: 4,
//                       color: Colors.green,
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               Style().replace(student3.firstName),
//                               style: Style().style(18,Colors.white,true),
//                             ),
//                             const SizedBox(width: 8,),
//                             Text(
//                               S.of(context).parrentphone("${Style().replace(student3.parrentPhone)}"),
//                               style: Style().style(15,Colors.white,true),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       IconButton(
//                         onPressed: ()async{
//                           await removeFromAttendants(student3);
//                         },
//                         icon: const Icon(
//                           Icons.cancel_outlined,
//                           color: Colors.red,
//                           size: 30
//                         )
//                       ),
//                       IconButton(
//                         onPressed: ()async{
//                           await Control().homeworkmanagment(student: student3);
//                           setState(() {
//                             attendantsLoading = true;
//                           });
//                           prepareOffline();
//                           setState((){
//                             attendantsLoading = false;
//                           });
//                         },
//                         icon: Icon(
//                           Icons.home_work,
//                           color:Variables().homeworkBox.get(student3.email)!=null?Colors.green: Colors.red,
//                           size: 30
//                         )
//                       ),
//                     ],
//                   )
//                 ],
//               )
//             );
//           });
//           setState(() {
//             attendantsStudentsWidgets.add(
//               Wrap(
//                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     elevation: 4,
//                     color: Colors.green,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             Style().replace(student3.firstName),
//                             style: Style().style(18,Colors.white,true),
//                           ),
//                           const SizedBox(width: 8,),
//                           Text(
//                             S.of(context).parrentphone("${Style().replace(student3.parrentPhone)}"),
//                             style: Style().style(15,Colors.white,true),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       IconButton(
//                         onPressed: ()async{
//                           await removeFromAttendants(student3);
//                         },
//                         icon: const Icon(
//                           Icons.cancel_outlined,
//                           color: Colors.red,
//                           size: 30
//                         )
//                       ),
//                       IconButton(
//                         onPressed: ()async{
//                           await Control().homeworkmanagment(student: student3);
                          
//                           setState(() {
//                             attendantsLoading = true;
//                           });
//                           prepareOffline();
//                           setState((){
//                             attendantsLoading = false;
//                           });
//                         },
//                         icon:  Icon(
//                           Icons.home_work,
//                           color:Variables().homeworkBox.get(student3.email)!=null?Colors.green: Colors.red,
//                           size: 30
//                         )
//                       ),
//                     ],
//                   )
//                 ],
//               )
//             );
//           });
//         }
//       }
//     } else if(mode ==2){
//       for(Student student2 in expectedAttendantsStudents){
//         setState((){
//           expectedAttendantsStudentsWidgets.add(
//             Wrap(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   onPressed: (){
//                     showDialog(context: context, builder: (context)=>AlertDialog(
//                       title: Text(
//                         "${student2.firstName} ${student2.lastName} Details",
//                       ),
//                       content: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("ID :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.cardId),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Email :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.email),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Phone :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.phone),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Parrent Phone :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.parrentPhone),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("State :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.state),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Password :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.password),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Center :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.place),
//                             ]
//                           ),
//                         ],
//                       )
//                     ));
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     elevation: 4,
//                     color: Colors.indigo,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             Style().replace(student2.firstName),
//                             style: Style().style(18,Colors.white,true),
//                           ),
//                           const SizedBox(width: 8,),
//                           Text(
//                             S.of(context).parrentphone("${Style().replace(student2.parrentPhone)}"),
//                             style: Style().style(15,Colors.white,true),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: ()async{
//                     await addToAttendants(student2);
//                   },
//                   icon: const Icon(
//                     Icons.check,
//                     color: Colors.indigo,
//                     size: 30
//                   )
//                 )
//               ],
//             )
//           );
//         });
//       }
//     }else if(mode==3){
//       // Student student3 = await getStudent(student3Email);
//       for (Student student3 in attendantsStudents) {
//         if(student3Email == student3.email){
//           setState(() {
//             attendantsStudentsWidgets.add(
//               Wrap(
//                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: (){
//                       showDialog(context: context, builder: (context)=>AlertDialog(
//                         title: Text(
//                           "${student3.firstName} ${student3.lastName} Details",
//                         ),
//                         content: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("ID :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.cardId),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Email :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.email),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Phone :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.phone),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Parrent Phone :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.parrentPhone),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("State :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.state),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Password :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.password),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Center :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.place),
//                               ]
//                             ),
//                           ],
//                         )
//                       ));
//                     },
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       elevation: 4,
//                       color: Colors.green,
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               Style().replace(student3.firstName),
//                               style: Style().style(18,Colors.white,true),
//                             ),
//                             const SizedBox(width: 8,),
//                             Text(
//                               S.of(context).parrentphone("${Style().replace(student3.parrentPhone)}"),
//                               style: Style().style(15,Colors.white,true),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       IconButton(
//                         onPressed: ()async{
//                           await removeFromAttendants(student3);
//                         },
//                         icon: const Icon(
//                           Icons.cancel_outlined,
//                           color: Colors.red,
//                           size: 30
//                         )
//                       ),
//                       IconButton(
//                         onPressed: ()async{
//                           await Control().homeworkmanagment(student: student3);
                          
//                           setState(() {
//                             attendantsLoading = true;
//                           });
//                           prepareOffline();
//                           setState((){
//                             attendantsLoading = false;
//                           });
//                         },
//                         icon: Icon(
//                           Icons.home_work,
//                           color:Variables().homeworkBox.get(student3.email)!=null?Colors.green: Colors.red,
//                           size: 30
//                         )
//                       ),
//                     ],
//                   )
//                 ],
//               )
//             );
//           });
//           break;
//         }else{
//           // print(student3Email);
//         }
//       }
//     }else if(mode==4){
//       // Student student3 = await getStudent(student3Email);
//       for (Student student3 in attendantsStudents) {
//         if(student3Email == student3.email){
          
//         }else{
//           // print(student3Email);
//           setState(() {
//             attendantsStudentsWidgets.add(
//               Wrap(
//                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: (){
//                       showDialog(context: context, builder: (context)=>AlertDialog(
//                         title: Text(
//                           "${student3.firstName} ${student3.lastName} Details",
//                         ),
//                         content: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("ID :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.cardId),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Email :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.email),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Phone :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.phone),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Parrent Phone :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.parrentPhone),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("State :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.state),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Password :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.password),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text("Center :"),
//                               ]
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(student3.place),
//                               ]
//                             ),
//                           ],
//                         )
//                       ));
//                     },
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       elevation: 4,
//                       color: Colors.green,
//                       child: Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               Style().replace(student3.firstName),
//                               style: Style().style(18,Colors.white,true),
//                             ),
//                             const SizedBox(width: 8,),
//                             Text(
//                               S.of(context).parrentphone("${Style().replace(student3.parrentPhone)}"),
//                               style: Style().style(15,Colors.white,true),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       IconButton(
//                         onPressed: ()async{
//                           await removeFromAttendants(student3);
//                         },
//                         icon: const Icon(
//                           Icons.cancel_outlined,
//                           color: Colors.red,
//                           size: 30
//                         )
//                       ),
//                       IconButton(
//                         onPressed: ()async{
//                           await Control().homeworkmanagment(student: student3);
                          
//                           setState(() {
//                             attendantsLoading = true;
//                           });
//                           prepareOffline();
//                           setState((){
//                             attendantsLoading = false;
//                           });
//                         },
//                         icon:  Icon(
//                           Icons.home_work,
//                           color:Variables().homeworkBox.get(student3.email)!=null?Colors.green: Colors.red,
//                           size: 30
//                         )
//                       ),
//                     ],
//                   )
//                 ],
//               )
//             );
//           });
//           break;
//         }
//       }
//     }
//   }
//   @override
//   void initState() {
//     super.initState();
//     if (selectedBranch != "Select") {
      
//       Control().insertWorksession(session: currentAttendantsSession);
//     }
//     currentAttendantsSession = widget.session;
//     isworksession = widget.isworksession;
//     session.branch = selectedBranch;
//     if (isworksession) {
//       selectedBranch = currentAttendantsSession.branch;
//       showDropDown = false;
//       // prepareOffline();
//     } else {
//     }
//     // print(currentAttendantsSession.branch);
//     async();
    
//   }
//   @override
//   void dispose() {
//     Variables().worksession.clear();
//     selectedBranch = "Select";
//     attendantsStudentsWidgets.clear();
//     expectedAttendantsStudentsWidgets.clear();
//     blockedStudentsFromAttend.clear();
//     dropdownMenuItems.clear();
//     dropdownMenuItems.add(DropdownMenuItem(value:"Select",child: Text(S.current.selectBranch)));
//     // dropdownMenuItems.clear();
//     // attendantsLoading = true;
//     // gettingExpected = true;
//     // gettingAttendants = true;
//     showDropDown = true;
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     searchAttendants(String searchQuery)async{
//       manuallyAdded.clear();
//       for (var i = 0; i < Variables().manuallyAddedBox.length; i++) {
//         Student student = Variables().manuallyAddedBox.getAt(i);
//         setState(() {
//           manuallyAdded.add(student);
//         });
//       }
//       // print(manuallyAdded[0].email);
//       List<Widget> searchResults2 = [];
//       setState(() {
//         searching = true;
//       });
//       searchResults2.clear();
//       // print("in search");
//       List<String>fields = [
//         'email',
//         'firstname',
//         'lastname',
//         'phone',
//         'parrentphone',
//         'parrentemail',
//         'password',
//         'gender',
//         'stage',
//         'id',
//         'place',
//         'time',
//       ];
//       int score = 0;
//       for(String field in fields){
//         // print(field);
//         try {
//           for (Student student in manuallyAdded) {
//             // print(student.cardId);
//             // print(searchQuery);
//             if (field == "email") {
//               if (student.email == searchQuery) {
//                 setState(() {
//                   addStudentToAttendantsManually.clear();
//                   addStudentToAttendantsManually.text = "";
//                   searchResults2.add(
//                     Text(
//                       "${student.firstName} ${student.lastName} added",
//                       style: Style().style(30, Colors.green, true)
//                     )
//                   );
//                 });
//                 await addToAttendants(student);
//               }
//             } else if(field == "firstname"){
//               if (student.firstName.toLowerCase() == searchQuery.toLowerCase()) {
//                 searchResults2.add(
//                   Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: const BorderSide(width: 1,color: Colors.grey)),
//                     child: Container(
//                       padding: const EdgeInsets.all(18),
//                       margin: const EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children:[
//                               Text(
//                                 "${student.firstName} ${student.lastName}",
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                               Text(
//                                 student.stage,
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                             ]
//                           ),
//                           const SizedBox(height: 7,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).email,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.email),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).id,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.cardId),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).phone,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.phone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).gender,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.gender),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).password,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.password),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentemail,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentEmail),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentphonetitle,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPhone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentpassword,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPassword),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).center,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.place),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).time,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.time),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Center(
//                             child: TextButton(
//                               child:Text(
//                                 S.of(context).add,
//                                 style:Style().style(20,Colors.indigo,true),
//                               ),
//                               onPressed: ()async{
//                                 Navigator.pop(context);
//                                 addStudentToAttendantsManually.clear();
//                                 await addToAttendants(student);
//                               }
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 );
//               } else {
                
//               }
//             } else if(field == "lastname"){
//               if (student.lastName.toLowerCase() == searchQuery.toLowerCase()) {
//                 searchResults2.add(
//                   Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: const BorderSide(width: 1,color: Colors.grey)),
//                     child: Container(
//                       padding: const EdgeInsets.all(18),
//                       margin: const EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children:[
//                               Text(
//                                 "${student.firstName} ${student.lastName}",
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                               Text(
//                                 student.stage,
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                             ]
//                           ),
//                           const SizedBox(height: 7,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).email,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.email),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).id,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.cardId),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).phone,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.phone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).gender,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.gender),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).password,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.password),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentemail,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentEmail),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentphonetitle,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPhone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentpassword,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPassword),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).center,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.place),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).time,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.time),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Center(
//                             child: TextButton(
//                               child:Text(
//                                 S.of(context).add,
//                                 style:Style().style(20,Colors.indigo,true),
//                               ),
//                               onPressed: ()async{
//                                 Navigator.pop(context);
//                                 addStudentToAttendantsManually.clear();
//                                 await addToAttendants(student);
//                               }
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 );
//               }
//             } else if(field == "phone"){
//               if (student.phone == searchQuery) {
//                 setState(() {
//                   searchResults2.add(
//                     Text(
//                       "${student.firstName} ${student.lastName} added",
//                       style: Style().style(30, Colors.green, true)
//                     )
//                   );
//                   addStudentToAttendantsManually.clear();
//                 });
//                 await addToAttendants(student);
//                 // searchResults2.add(
//                   // Card(
//                   //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: const BorderSide(width: 1,color: Colors.grey)),
//                   //   child: Container(
//                   //     padding: const EdgeInsets.all(18),
//                   //     margin: const EdgeInsets.all(10),
//                   //     child: Column(
//                   //       children: [
//                   //         Row(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //           children:[
//                   //             Text(
//                   //               "${student.firstName} ${student.lastName}",
//                   //               style: Style().style(20, Colors.black, true),
//                   //             ),
//                   //             Text(
//                   //               student.stage,
//                   //               style: Style().style(20, Colors.black, true),
//                   //             ),
//                   //           ]
//                   //         ),
//                   //         const SizedBox(height: 7,),
//                   //         Row(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //           children: [
//                   //             Text(
//                   //               S.of(context).email,
//                   //               style: Style().style(20, Colors.blue, true),
//                   //             ),
//                   //             Text(
//                   //               Style().replace(student.email),
//                   //               style: Style().style(18, Colors.black, false),
//                   //             )
//                   //           ],
//                   //         ),
//                   //         Row(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //           children: [
//                   //             Text(
//                   //               S.of(context).id,
//                   //               style: Style().style(20, Colors.blue, true),
//                   //             ),
//                   //             Text(
//                   //               Style().replace(student.cardId),
//                   //               style: Style().style(18, Colors.black, false),
//                   //             )
//                   //           ],
//                   //         ),
//                   //         Row(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //           children: [
//                   //             Text(
//                   //               S.of(context).phone,
//                   //               style: Style().style(20, Colors.blue, true),
//                   //             ),
//                   //             Text(
//                   //               Style().replace(student.phone),
//                   //               style: Style().style(18, Colors.black, false),
//                   //             )
//                   //           ],
//                   //         ),
//                   //         Row(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //           children: [
//                   //             Text(
//                   //               S.of(context).gender,
//                   //               style: Style().style(20, Colors.blue, true),
//                   //             ),
//                   //             Text(
//                   //               Style().replace(student.gender),
//                   //               style: Style().style(18, Colors.black, false),
//                   //             )
//                   //           ],
//                   //         ),
//                   //         Row(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //           children: [
//                   //             Text(
//                   //               S.of(context).password,
//                   //               style: Style().style(20, Colors.blue, true),
//                   //             ),
//                   //             Text(
//                   //               Style().replace(student.password),
//                   //               style: Style().style(18, Colors.black, false),
//                   //             )
//                   //           ],
//                   //         ),
//                   //         Row(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //           children: [
//                   //             Text(
//                   //               S.of(context).parrentemail,
//                   //               style: Style().style(20, Colors.blue, true),
//                   //             ),
//                   //             Text(
//                   //               Style().replace(student.parrentEmail),
//                   //               style: Style().style(18, Colors.black, false),
//                   //             )
//                   //           ],
//                   //         ),
//                   //         Row(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //           children: [
//                   //             Text(
//                   //               S.of(context).parrentphonetitle,
//                   //               style: Style().style(20, Colors.blue, true),
//                   //             ),
//                   //             Text(
//                   //               Style().replace(student.parrentPhone),
//                   //               style: Style().style(18, Colors.black, false),
//                   //             )
//                   //           ],
//                   //         ),
//                   //         Row(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //           children: [
//                   //             Text(
//                   //               S.of(context).parrentpassword,
//                   //               style: Style().style(20, Colors.blue, true),
//                   //             ),
//                   //             Text(
//                   //               Style().replace(student.parrentPassword),
//                   //               style: Style().style(18, Colors.black, false),
//                   //             )
//                   //           ],
//                   //         ),
//                   //         Row(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //           children: [
//                   //             Text(
//                   //               S.of(context).center,
//                   //               style: Style().style(20, Colors.blue, true),
//                   //             ),
//                   //             Text(
//                   //               Style().replace(student.place),
//                   //               style: Style().style(18, Colors.black, false),
//                   //             )
//                   //           ],
//                   //         ),
//                   //         Row(
//                   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //           children: [
//                   //             Text(
//                   //               S.of(context).time,
//                   //               style: Style().style(20, Colors.blue, true),
//                   //             ),
//                   //             Text(
//                   //               Style().replace(student.time),
//                   //               style: Style().style(18, Colors.black, false),
//                   //             )
//                   //           ],
//                   //         ),
//                   //         Center(
//                   //           child: TextButton(
//                   //             child:Text(
//                   //               S.of(context).add,
//                   //               style:Style().style(20,Colors.indigo,true),
//                   //             ),
//                   //             onPressed: ()async{
//                   //               Navigator.pop(context);
//                   //               addStudentToAttendantsManually.clear();
//                   //               await addToAttendants(student);
//                   //             }
//                   //           ),
//                   //         )
//                   //       ],
//                   //     ),
//                   //   ),
//                   // )
//                 // );
//               }
//             } else if(field == "parrentphone"){
//               if (student.parrentPhone == searchQuery) {
//                 searchResults2.add(
//                   Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: const BorderSide(width: 1,color: Colors.grey)),
//                     child: Container(
//                       padding: const EdgeInsets.all(18),
//                       margin: const EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children:[
//                               Text(
//                                 "${student.firstName} ${student.lastName}",
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                               Text(
//                                 student.stage,
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                             ]
//                           ),
//                           const SizedBox(height: 7,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).email,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.email),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).id,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.cardId),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).phone,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.phone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).gender,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.gender),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).password,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.password),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentemail,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentEmail),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentphonetitle,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPhone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentpassword,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPassword),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).center,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.place),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).time,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.time),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Center(
//                             child: TextButton(
//                               child:Text(
//                                 S.of(context).add,
//                                 style:Style().style(20,Colors.indigo,true),
//                               ),
//                               onPressed: ()async{
//                                 Navigator.pop(context);
//                                 addStudentToAttendantsManually.clear();
//                                 await addToAttendants(student);
//                               }
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 );
//               }
//             } else if(field == "parrentemail"){
//               if (student.parrentEmail == searchQuery) {
//                 searchResults2.add(
//                   Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: const BorderSide(width: 1,color: Colors.grey)),
//                     child: Container(
//                       padding: const EdgeInsets.all(18),
//                       margin: const EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children:[
//                               Text(
//                                 "${student.firstName} ${student.lastName}",
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                               Text(
//                                 student.stage,
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                             ]
//                           ),
//                           const SizedBox(height: 7,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).email,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.email),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).id,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.cardId),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).phone,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.phone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).gender,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.gender),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).password,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.password),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentemail,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentEmail),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentphonetitle,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPhone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentpassword,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPassword),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).center,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.place),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).time,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.time),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Center(
//                             child: TextButton(
//                               child:Text(
//                                 S.of(context).add,
//                                 style:Style().style(20,Colors.indigo,true),
//                               ),
//                               onPressed: ()async{
//                                 Navigator.pop(context);
//                                 addStudentToAttendantsManually.clear();
//                                 await addToAttendants(student);
//                               }
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 );
//               }
//             } else if(field == "password"){
//               if (student.password == searchQuery) {
//                 searchResults2.add(
//                   Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: const BorderSide(width: 1,color: Colors.grey)),
//                     child: Container(
//                       padding: const EdgeInsets.all(18),
//                       margin: const EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children:[
//                               Text(
//                                 "${student.firstName} ${student.lastName}",
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                               Text(
//                                 student.stage,
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                             ]
//                           ),
//                           const SizedBox(height: 7,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).email,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.email),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).id,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.cardId),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).phone,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.phone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).gender,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.gender),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).password,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.password),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentemail,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentEmail),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentphonetitle,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPhone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentpassword,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPassword),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).center,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.place),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).time,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.time),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Center(
//                             child: TextButton(
//                               child:Text(
//                                 S.of(context).add,
//                                 style:Style().style(20,Colors.indigo,true),
//                               ),
//                               onPressed: ()async{
//                                 Navigator.pop(context);
//                                 addStudentToAttendantsManually.clear();
//                                 await addToAttendants(student);
//                               }
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 );
//               }
//             } else if(field == "gender"){
//               if (student.gender.toLowerCase() == searchQuery.toLowerCase()) {
//                 searchResults2.add(
//                   Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: const BorderSide(width: 1,color: Colors.grey)),
//                     child: Container(
//                       padding: const EdgeInsets.all(18),
//                       margin: const EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children:[
//                               Text(
//                                 "${student.firstName} ${student.lastName}",
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                               Text(
//                                 student.stage,
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                             ]
//                           ),
//                           const SizedBox(height: 7,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).email,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.email),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).id,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.cardId),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).phone,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.phone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).gender,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.gender),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).password,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.password),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentemail,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentEmail),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentphonetitle,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPhone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentpassword,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPassword),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).center,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.place),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).time,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.time),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Center(
//                             child: TextButton(
//                               child:Text(
//                                 S.of(context).add,
//                                 style:Style().style(20,Colors.indigo,true),
//                               ),
//                               onPressed: ()async{
//                                 Navigator.pop(context);
//                                 addStudentToAttendantsManually.clear();
//                                 await addToAttendants(student);
//                               }
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 );
//               }
//             } else if(field == "stage"){
//               if (student.stage.toLowerCase() == searchQuery.toLowerCase()) {
//                 searchResults2.add(
//                   Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: const BorderSide(width: 1,color: Colors.grey)),
//                     child: Container(
//                       padding: const EdgeInsets.all(18),
//                       margin: const EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children:[
//                               Text(
//                                 "${student.firstName} ${student.lastName}",
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                               Text(
//                                 student.stage,
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                             ]
//                           ),
//                           const SizedBox(height: 7,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).email,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.email),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).id,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.cardId),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).phone,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.phone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).gender,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.gender),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).password,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.password),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentemail,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentEmail),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentphonetitle,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPhone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentpassword,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPassword),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).center,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.place),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).time,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.time),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Center(
//                             child: TextButton(
//                               child:Text(
//                                 S.of(context).add,
//                                 style:Style().style(20,Colors.indigo,true),
//                               ),
//                               onPressed: ()async{
//                                 Navigator.pop(context);
//                                 addStudentToAttendantsManually.clear();
//                                 await addToAttendants(student);
//                               }
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 );
//               }
//             } else if(field == "id"){
//               if (student.cardId == searchQuery) {
//                 setState(() {
//                   searchResults2.add(
//                     Text(
//                       "${student.firstName} ${student.lastName} added",
//                       style: Style().style(30, Colors.green, true)
//                     )
//                   );
//                   addStudentToAttendantsManually.clear();
//                 });
                
//                 await addToAttendants(student);
//               }
//             } else if(field == "place"){
//               if (student.place.toLowerCase() == searchQuery.toLowerCase()) {
//                 searchResults2.add(
//                   Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: const BorderSide(width: 1,color: Colors.grey)),
//                     child: Container(
//                       padding: const EdgeInsets.all(18),
//                       margin: const EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children:[
//                               Text(
//                                 "${student.firstName} ${student.lastName}",
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                               Text(
//                                 student.stage,
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                             ]
//                           ),
//                           const SizedBox(height: 7,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).email,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.email),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).id,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.cardId),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).phone,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.phone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).gender,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.gender),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).password,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.password),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentemail,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentEmail),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentphonetitle,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPhone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentpassword,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPassword),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).center,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.place),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).time,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.time),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Center(
//                             child: TextButton(
//                               child:Text(
//                                 S.of(context).add,
//                                 style:Style().style(20,Colors.indigo,true),
//                               ),
//                               onPressed: ()async{
//                                 Navigator.pop(context);
//                                 addStudentToAttendantsManually.clear();
//                                 await addToAttendants(student);
//                               }
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 );
//               }
//             } else if(field == "time"){
//               if (student.time == searchQuery) {
//                 searchResults2.add(
//                   Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: const BorderSide(width: 1,color: Colors.grey)),
//                     child: Container(
//                       padding: const EdgeInsets.all(18),
//                       margin: const EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children:[
//                               Text(
//                                 "${student.firstName} ${student.lastName}",
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                               Text(
//                                 student.stage,
//                                 style: Style().style(20, Colors.black, true),
//                               ),
//                             ]
//                           ),
//                           const SizedBox(height: 7,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).email,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.email),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).id,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.cardId),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).phone,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.phone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).gender,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.gender),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).password,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.password),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentemail,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentEmail),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentphonetitle,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPhone),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).parrentpassword,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.parrentPassword),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).center,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.place),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 S.of(context).time,
//                                 style: Style().style(20, Colors.blue, true),
//                               ),
//                               Text(
//                                 Style().replace(student.time),
//                                 style: Style().style(18, Colors.black, false),
//                               )
//                             ],
//                           ),
//                           Center(
//                             child: TextButton(
//                               child:Text(
//                                 S.of(context).add,
//                                 style:Style().style(20,Colors.indigo,true),
//                               ),
//                               onPressed: ()async{
//                                 Navigator.pop(context);
//                                 addStudentToAttendantsManually.clear();
//                                 await addToAttendants(student);
//                               }
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 );
//               }
//             }
//           }
//         }catch(e){
//           // print("line 2489   $e");
//         }
//         setState(() {
//           searching = false;
//         });
//       }
//       showDialog(
//         context: context,
//         builder: (context)=>AlertDialog(
//           title: Text('Search Results'),
//           content: SingleChildScrollView(
//             child: Column(
//               children: searchResults2
//             )
//           )
//         )
//       ).then((value) {});
//     }
//     List<Widget> streamBuilders = [
//       //expected
//       Container(
//         margin: const EdgeInsets.all(10),
//         width: MediaQuery.of(context).size.width * 0.25,
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
//         child: ListView.builder(
//           itemCount: Variables().expectedBox.length,
//           itemBuilder: (context,index){
//             Student student2 = Variables().expectedBox.getAt(index);
//             return Wrap(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   onPressed: (){
//                     showDialog(context: context, builder: (context)=>AlertDialog(
//                       title: Text(
//                         "${student2.firstName} ${student2.lastName} Details",
//                       ),
//                       content: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("ID :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.cardId),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Email :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.email),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Phone :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.phone),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Parrent Phone :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.parrentPhone),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("State :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.state),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Password :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.password),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Center :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.place),
//                             ]
//                           ),
//                         ],
//                       )
//                     ));
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     elevation: 4,
//                     color: Colors.indigo,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 Style().replace(student2.firstName),
//                                 style: Style().style(18,Colors.white,true),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(
//                                 S.of(context).parrentphone("${Style().replace(student2.parrentPhone)}"),
//                                 style: Style().style(15,Colors.white,true),
//                               ),
//                             ]
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: ()async{
//                     await addToAttendants(student2);
//                   },
//                   icon: const Icon(
//                     Icons.check,
//                     color: Colors.indigo,
//                     size: 30
//                   )
//                 )
//               ],
//             );
//           }
//         )
//       ),
//       // attended offline
//       Container(
//         margin: const EdgeInsets.all(10),
//         padding: const EdgeInsets.all(18),
//         width: MediaQuery.of(context).size.width * 0.25,
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
//         child: Align(
//           alignment: Alignment.topCenter,
//           child: ListView.builder(
//             itemCount: Variables().attendedBox.length,
//             reverse: true,
//             shrinkWrap: true,
//             itemBuilder: (context,index){
//               // print(Variables().attendedBox.length);
//               Color color = Colors.green;
//               Student student2 = Variables().attendedBox.getAt(index);
//               if(student2.state == "Offline"){
//                 return Wrap(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton(
//                       onPressed: (){
//                         showDialog(context: context, builder: (context)=>AlertDialog(
//                           title: Text(
//                             "${student2.firstName} ${student2.lastName} Details",
//                           ),
//                           content: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("ID :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.cardId),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("Email :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.email),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("Phone :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.phone),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("Parrent Phone :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.parrentPhone),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("State :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.state),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("Password :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.password),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("Center :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.place),
//                                 ]
//                               ),
//                             ],
//                           )
//                         ));
//                       },
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         elevation: 4,
//                         color: color,
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     Style().replace(student2.firstName),
//                                     style: Style().style(18,Colors.white,true),
//                                     textWidthBasis: TextWidthBasis.parent,
//                                     overflow: TextOverflow.clip,
//                                   ),
//                                   const SizedBox(width: 8,),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:MainAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     S.of(context).parrentphone("${Style().replace(student2.parrentPhone)}"),
//                                     style: Style().style(15,Colors.white,true),
//                                     textWidthBasis: TextWidthBasis.parent,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         IconButton(
//                           onPressed: ()async{
//                             await removeFromAttendants(student2);
//                           },
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Colors.red,
//                             size: 30
//                           )
//                         ),
//                         IconButton(
//                           onPressed: ()async{
//                             await Control().homeworkmanagment(student: student2);
//                             setState(() {
//                               attendantsLoading = true;
//                             });
//                             prepareOffline();
//                             setState((){
//                               attendantsLoading = false;
//                             });
//                             // print("here");
//                           },
//                           icon:  Icon(
//                             Icons.home_work,
//                             color:Variables().homeworkBox.get(student2.email)!=null?Colors.green: Colors.red,
//                             size: 30
//                           )
//                         ),
//                       ],
//                     )
//                   ],
//                 );
//               }else{
//                 return const SizedBox();
//               }
//             }
//           ),
//         )
//         ,
//       ),
//       // attended online
//       Container(
//         margin: const EdgeInsets.all(10),
//         padding: const EdgeInsets.all(18),
//         width: MediaQuery.of(context).size.width * 0.25,
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
//         child: Align(
//           alignment: Alignment.topCenter,
//           child: ListView.builder(
//             itemCount: Variables().attendedBox.length,
//             reverse: true,
//             shrinkWrap: true,
//             itemBuilder: (context,index){
//               // print(Variables().attendedBox.length);
//               Color color = Colors.green;
//               Student student2 = Variables().attendedBox.getAt(index);
//               if(student2.state == "Online"){
//                 return Wrap(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton(
//                       onPressed: (){
//                         showDialog(context: context, builder: (context)=>AlertDialog(
//                           title: Text(
//                             "${student2.firstName} ${student2.lastName} Details",
//                           ),
//                           content: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("ID :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.cardId),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("Email :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.email),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("Phone :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.phone),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("Parrent Phone :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.parrentPhone),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("State :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.state),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("Password :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.password),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text("Center :"),
//                                 ]
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(student2.place),
//                                 ]
//                               ),
//                             ],
//                           )
//                         ));
//                       },
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         elevation: 4,
//                         color: color,
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     Style().replace(student2.firstName),
//                                     style: Style().style(18,Colors.white,true),
//                                     textWidthBasis: TextWidthBasis.parent,
//                                     overflow: TextOverflow.clip,
//                                   ),
//                                   const SizedBox(width: 8,),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:MainAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     S.of(context).parrentphone("${Style().replace(student2.parrentPhone)}"),
//                                     style: Style().style(15,Colors.white,true),
//                                     textWidthBasis: TextWidthBasis.parent,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         IconButton(
//                           onPressed: ()async{
//                             await removeFromAttendants(student2);
//                           },
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Colors.red,
//                             size: 30
//                           )
//                         ),
//                         IconButton(
//                           onPressed: ()async{
//                             await Control().homeworkmanagment(student: student2);
//                             setState(() {
//                               attendantsLoading = true;
//                             });
//                             prepareOffline();
//                             setState((){
//                               attendantsLoading = false;
//                             });
//                             // print("here");
//                           },
//                           icon:  Icon(
//                             Icons.home_work,
//                             color:Variables().homeworkBox.get(student2.email)!=null?Colors.green: Colors.red,
//                             size: 30
//                           )
//                         ),
//                       ],
//                     )
//                   ],
//                 );
//               }else{
//                 return const SizedBox();
//               }
//             }
//           ),
//         )
//         ,
//       ),
//       //blocked from attennd
//       Container(
//         margin: const EdgeInsets.all(10),
//         padding: const EdgeInsets.all(18),
//         width: MediaQuery.of(context).size.width * 0.15,
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
//         child: ListView.builder(
//           itemCount: Variables().blockedFromAttend.length,
//           itemBuilder: (context,index){
//             Student student2 = Variables().blockedFromAttend.getAt(index);
//             return Wrap(
//               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton(
//                   onPressed: (){
//                     showDialog(context: context, builder: (context)=>AlertDialog(
//                       title: Text(
//                         "${student2.firstName} ${student2.lastName} Details",
//                       ),
//                       content: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("ID :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.cardId),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Email :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.email),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Phone :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.phone),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Parrent Phone :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.parrentPhone),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("State :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.state),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Password :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.password),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text("Center :"),
//                             ]
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(student2.place),
//                             ]
//                           ),
//                         ],
//                       )
//                     ));
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     elevation: 4,
//                     color: Colors.red,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             Style().replace(student2.firstName),
//                             style: Style().style(18,Colors.white,true),
//                           ),
//                           const SizedBox(width: 8,),
//                           Divider(color: Colors.white,height:2,thickness:2),
//                           Text(
//                             S.of(context).parrentphone("${Style().replace(student2.parrentPhone)}"),
//                             style: Style().style(15,Colors.white,true),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           }
//         )
//       ),
//     ];
//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width-15,
//         height: MediaQuery.of(context).size.height-10,
//         padding: const EdgeInsets.symmetric(horizontal:20,vertical: 0),
//         margin: const EdgeInsets.symmetric(horizontal:6.5,vertical: 10),
//         decoration:  BoxDecoration(
// 			color: Colors.white,
// 			image: DecorationImage(
// 			  image: AssetImage("assets/images/logo png.jpg"),
// 			),
// 			borderRadius: BorderRadius.circular(30),
// 			boxShadow: const[
// 			  BoxShadow(color: Colors.blue,blurRadius: 5),
// 			],
// 		  ),
//         child: ModalProgressHUD(
//           inAsyncCall: attendantsLoading,
//           // child: StreamOnlineBuilder()
//           child: SingleChildScrollView(
//             child:Column(
//               children: [
//                 Container(
//                   // width: MediaQuery.of(context).size.width * 0.25,
//                   padding: const EdgeInsets.symmetric(horizontal:10),
//                   decoration: const BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(18),
//                       bottomRight: Radius.circular(18),
//                     )
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         currentAttendantsSession.name,
//                         style: Style().style(28, Colors.white, true),
//                       ),
//                       !showDropDown?Text(
//                         // "You are working in $selectedBranch",
//                         S.of(context).youareworkingin(selectedBranch),
//                         style: Style().style(22, Colors.white, true),
//                       )
//                       :
//                       const SizedBox(),
//                       showDropDown
//                       ?
//                       DropdownButton(
//                         value: selectedBranch,
//                         items: dropdownMenuItems,
//                         onChanged: (value)async{
//                           // print(value);
//                           if (value != "Select") {
//                             setState(() {
//                               selectedBranch = value as String;
//                               session.branch = value;
//                               currentAttendantsSession.branch = value;
//                               Control().insertWorksession(session: currentAttendantsSession);
//                             });
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("Preparing Offline Mode ....."))
//                             );
//                             // await getSessionDetails();
//                             await manageAttendants();
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text("Offline Mode is Ready "))
//                             );
//                           }
//                         }
//                       )
//                       :
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           TextButton(
//                             onPressed: ()async{
//                               // print(currentAttendantsSession.mark);
//                               String success = await Export().exportAttendants(session:currentAttendantsSession);
//                               if (success == "success"){
//                                 Variables().attendantsContext = context;
//                                 await Control().deleteAll(box: Variables().worksession);
//                                 await Control().deleteAll(box: Variables().attendedBox);
//                                 await Control().deleteAll(box: Variables().blockedBox);
//                                 await Control().deleteAll(box: Variables().blockedFromAttend);
//                                 await Control().deleteAll(box: Variables().expectedBox);
//                                 await Control().deleteAll(box: Variables().manuallyAddedBox);
//                                 await Variables().worksession.clear();
//                                 await Process.run("close.bat",[]);
//                                 // Navigator.pop(context);
//                                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(connected: connected, connection: connection, currentStage: currentStage)));
//                                 // Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //     builder: (context)=>UploadToServer(sessionId: currentAttendantsSession.sessionId)
//                                 //   )
//                                 // );
//                               }else{
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text(S.of(context).failedToExport))
//                                 );
//                               }
//                             },
//                             style: ButtonStyle(
//                               elevation: MaterialStateProperty.all<double>(30),
//                               backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
//                             ),
//                             child: Text(
//                               // "Exit Without Saving",
//                               S.of(context).exitWithoutSaving,
//                               style: Style().style(20,Colors.blue,true)
//                             ),
//                           ),
//                           const SizedBox(width:5),
//                           TextButton(
//                             onPressed: ()async{
//                               // print(currentAttendantsSession.mark);
//                               String success = await Export().exportAttendants(session:currentAttendantsSession);
//                               if (success == "success"){
//                                 Variables().attendantsContext = context;
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context)=>UploadToServer(sessionId: currentAttendantsSession.sessionId)
//                                   )
//                                 );
//                               }
                              
//                             },
//                             style: ButtonStyle(
//                               elevation: MaterialStateProperty.all<double>(30),
//                               backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
//                             ),
//                             child: Text(
//                               // "Submit This Session",
//                               S.of(context).submitThisSession,
//                               style: Style().style(20,Colors.blue,true)
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 10,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       children: [
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width*0.3-20,
//                           child: TextField(
//                             controller: addStudentToAttendantsManually,
//                             textInputAction: TextInputAction.done,
//                             focusNode: addStudentToAttendantsManuallyFocus,
//                             autofocus: false,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                                 gapPadding: 7,
//                                 borderSide: const BorderSide(color: Colors.white,width: 2)
//                               ),
//                               // labelText: "Add Student Manually",
//                               labelText:S.of(context).addStudentsManually,
//                               hintStyle: Style().style(20, Colors.white, false),
//                               // hintText: "Type Anything Of Student Data",
//                               hintText: S.of(context).typeanythingofstddata,
//                               labelStyle: Style().style(20, Colors.white, false),
//                               floatingLabelStyle: Style().style(20, Colors.white, false),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                                 gapPadding: 4,
//                                 borderSide: const BorderSide(color: Colors.blue,width: 2),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                                 gapPadding: 4,
//                                 borderSide: const BorderSide(color: Colors.white,width: 2),
//                               ),
//                               fillColor: Colors.grey,
//                               filled: true,
//                               suffixIcon: IconButton(
//                                 onPressed: ()async{
//                                   if (addStudentToAttendantsManually.text != ""){
//                                     if(selectedBranch != "Select"){
//                                       await searchAttendants(addStudentToAttendantsManually.text);
//                                       setState(() {
//                                         addStudentToAttendantsManually.clear();
//                                         addStudentToAttendantsManuallyFocus.requestFocus();
//                                       });
//                                       // Navigator.push(context,builder: (context)=>Attendants(session: Variables().worksession.values.elementAt(0),isworksession: true,));
//                                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendants(session: Variables().worksession.values.elementAt(0),isworksession: true,)));
//                                     }else{
//                                       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Choose Branch First")));
//                                     }
//                                   }else{
//                                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Anything of Student Data First")));
//                                   }
//                                 },
//                                 icon: const Icon(
//                                   Icons.add,
//                                   color:Colors.white,
//                                 )
//                               ),
//                             ),
//                             onChanged: (value){
//                               // print(value);
//                             },
//                             onSubmitted: (value)async{
//                               if (addStudentToAttendantsManually.text != ""){
//                                 if(selectedBranch != "Select"){
//                                   await searchAttendants(value);
//                                   setState(() {
//                                     addStudentToAttendantsManually.clear();
//                                     addStudentToAttendantsManuallyFocus.requestFocus();
//                                   });
//                                   // Navigator.of(context);
//                                   // Navigator.push(context,builder: (context)=>Attendants(session: Variables().worksession.values.elementAt(0),isworksession: true,));
                                  
//                                 }else{
//                                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Choose Branch First")));
//                                 }
//                               }else{
//                                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Anything of Student Data First")));
//                               }
//                             },
//                             style: Style().style(18, Colors.white, false),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         Text(
//                           // "Expected To Attend",
//                           S.of(context).expectedToAttend(count("expected")),
//                           style: Style().style(25, Colors.blue, true),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         TextButton(
//                           onPressed: ()async{
//                             await Variables().attendedBox.addAll(Variables().expectedBox.values);
//                             await Variables().homeworkBox.addAll(Variables().expectedBox.values);
//                             setState(() {
                              
//                             });
//                           },
//                           style: Style().buttonStyle(Colors.green,Colors.green[900],18),
//                           child: Text(
//                             "Attend All",
//                             style:Style().style(25,Colors.white,true)
//                           )
//                         ),
//                         Text(
//                           // "Attendants offline",
//                           S.of(context).attendants(count("Offline")),
//                           style: Style().style(25, Colors.green, true),
//                         ),

//                       ],
//                     ),
                    
//                     Text(
//                       // "Attendants online",
//                       // count("Offline"),
//                       S.of(context).attendantsonline(count("Online")),
//                       style: Style().style(25, Colors.green, true),
//                     ),
                    
//                     Column(
//                       children: [
//                         TextButton(
//                           onPressed: (){
                            
//                             Navigator.push(context, MaterialPageRoute(builder:(context)=>MarksModeScreen(session:currentAttendantsSession)));
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
//                             shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//                             padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10)),
//                           ),
//                           child: Text(
//                             // "Marks Mode",
//                             S.of(context).marksMode,
//                             style: Style().style(22, Colors.white, false),
//                           ),
//                         ),
//                         Text(
//                           // "Blocked From Attend",
//                           S.of(context).blockedFromAttend,
//                           style: Style().style(25, Colors.red, true),
//                         ),
//                       ],
//                     ),
//                   ]
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: streamBuilders,
//                 )
//               ],
//             ),
//           )
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
//       floatingActionButton:!isworksession
//       ? FloatingActionButton(
//         onPressed: (){
//           Navigator.pop(context);
//           dropdownMenuItems.clear();
//           dropdownMenuItems.add(DropdownMenuItem(value:"Select",child: Text(S.current.selectBranch)));
//         },
//         backgroundColor: Colors.blue,
//         child: const Icon(
//           Icons.home,
//           color: Colors.white,
//         ),
//       )
//       :
//       null,
//     );
//   }
// }