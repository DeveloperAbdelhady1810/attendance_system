// import 'package:attendants/classes/control_database.dart';
// import 'package:attendants/classes/session.dart';
// import 'package:attendants/classes/style.dart';
// import 'package:attendants/classes/user.dart';
// import 'package:attendants/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:attendants/classes/variables.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// class MarksModeScreen extends StatefulWidget {
//   const MarksModeScreen({Key? key, required this.session}) : super(key: key);
//   final Session session;
//   @override
//   State<MarksModeScreen> createState() => _MarksModeScreenState();
// }
// Student currentStudent = Student(balance: "", cardId: "", email: "", firstName: "", gender: "", lastName: "", parrentEmail: "", parrentPassword: "", parrentPhone: "", password: "", phone: "", stage: "", place: "", state: "", time: "");
// bool stdidMode = true;
// bool loading = false;
// Session session = Session(sessionId: "", weekday: "", stage: "", branch: "", attendants: [], name: "", mark: {}, time: "",isscientific: false);
// List<Student> attendants = [];
// Map<String,String> marks = {};
// TextEditingController fullMarkController = TextEditingController();
// TextEditingController queryController = TextEditingController();
// FocusNode markFocusNode = FocusNode();
// class _MarksModeScreenState extends State<MarksModeScreen> {
//   @override
//   void initState() {
//     session = widget.session;
//     attendants = Control().getAllStudents(box: Variables().attendedBox);
//     // marks = Variables().worksession.values.first.mark;
//     marks = session.mark;
//     super.initState();
//   }
//   addMark({required studentId,required mark}){
//     if (fullMarkController.text == "") {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(S.current.quizfullmark))
//       );
//     } else {  
//       setState(() {
//         session.mark[studentId] = "$mark/${fullMarkController.text}";
//         marks[studentId] = "$mark/${fullMarkController.text}";
//       });
//     }
//   }
//   searchAttendants(String query){
//     for(Student student in attendants){
//       if (query == student.phone) {
//         return student;
//       } else if(query == student.email){
//         return student;
//       } else if(query == student.cardId){
//         return student;
//       }
//     }
//   }
//   manageMarks(String query)async{
//     if (stdidMode) {
//       setState(() {
//         try {
//           // print(query);
//           if (searchAttendants(query).firstName!="") {
//             // print(searchAttendants(query).firstName);
//             currentStudent = searchAttendants(query);
//           }else{
//             //print("Not Found");
//           }
//         } catch (e) {
//           //print(e);
//         }
        
//       });
//     } else {
//       addMark(studentId: currentStudent.email, mark: query);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width-15,
//         height: MediaQuery.of(context).size.height-10,
//         padding: const EdgeInsets.symmetric(horizontal:20,vertical: 0),
//         margin: const EdgeInsets.symmetric(horizontal:6.5,vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: const [
//             BoxShadow(color: Colors.blue,blurRadius: 5),
//           ],
//         ),
//         child: ModalProgressHUD(
//           inAsyncCall: loading,
//           child: Row(
//             children: [
//               Container(
//                 margin: const EdgeInsets.all(10),
//                 padding: const EdgeInsets.all(18),
//                 width: MediaQuery.of(context).size.width * 0.3,
//                 height: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                   border: const Border(
//                     right: BorderSide(width: 6,color:Colors.green),
//                     left: BorderSide(width: 6,color:Colors.green),
//                     top: BorderSide(width: 6,color:Colors.green),
//                     bottom: BorderSide(width: 6,color:Colors.green),
//                   ),
//                   borderRadius: BorderRadius.circular(18)
//                 ),
//                 child: Align(
//                   alignment: Alignment.topCenter,
//                   child: ListView.builder(
//                     itemCount: attendants.length,
//                     reverse: true,
//                     shrinkWrap: true,
//                     itemBuilder: (context,index){
//                       Student student2 = attendants[index];
//                       return Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         elevation: 4,
//                         color: Colors.green,
//                         child: Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 Style().replace(student2.firstName),
//                                 style: Style().style(18,Colors.white,true),
//                               ),
//                               const SizedBox(width: 8,),
//                               Text(
//                                 // "Student id : ${}",
//                                 S.of(context).stdid(Style().replace(student2.cardId)),
//                                 style: Style().style(15,Colors.white,true),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.all(10),
//                 padding: const EdgeInsets.all(18),
//                 width: MediaQuery.of(context).size.width * 0.62,
//                 height: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                   border: const Border(
//                     right: BorderSide(width: 6,color:Colors.green),
//                     left: BorderSide(width: 6,color:Colors.green),
//                     top: BorderSide(width: 6,color:Colors.green),
//                     bottom: BorderSide(width: 6,color:Colors.green),
//                   ),
//                   borderRadius: BorderRadius.circular(18)
//                 ),
//                 child: SingleChildScrollView(
//                   controller: ScrollController(),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width*0.3-20,
//                         child: TextField(
//                           controller: fullMarkController,
//                           textInputAction: TextInputAction.done,
//                           autofocus: false,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               gapPadding: 7,
//                               borderSide: const BorderSide(color: Colors.white,width: 2)
//                             ),
//                             // labelText: "Quiz Full Mark",
//                             labelText: S.of(context).quizfullmark2,
//                             hintStyle: Style().style(20, Colors.white, false),
//                             hintText: "20",
//                             labelStyle: Style().style(20, Colors.white, false),
//                             floatingLabelStyle: Style().style(20, Colors.white, false),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               gapPadding: 4,
//                               borderSide: const BorderSide(color: Colors.blue,width: 2),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               gapPadding: 4,
//                               borderSide: const BorderSide(color: Colors.white,width: 2),
//                             ),
//                             fillColor: Colors.grey,
//                             filled: true,
//                             suffixIcon: IconButton(
//                               onPressed: (){},
//                               icon: const Icon(
//                                 Icons.check,
//                                 color:Colors.white,
//                               )
//                             ),
//                           ),
//                           style: Style().style(18, Colors.white, false),
//                           textAlign: TextAlign.center,
//                         )
//                       ),
//                       const SizedBox(height: 10,),
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width*0.3-20,
//                         child: TextField(
//                           focusNode: markFocusNode,
//                           controller: queryController,
//                           textInputAction: TextInputAction.done,
//                           autofocus: false,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               gapPadding: 7,
//                               borderSide: const BorderSide(color: Colors.white,width: 2)
//                             ),
//                             // labelText:stdidMode? "Student Data" : "${currentStudent.firstName}`s Mark",
//                             labelText:stdidMode? S.of(context).studentData:S.of(context).stdMark(currentStudent.firstName),
//                             hintStyle: Style().style(20, Colors.black, false),
//                             // hintText:stdidMode? "Type Anything of Student Data": "Type ${currentStudent.firstName}`s Mark",
//                             hintText:stdidMode? S.of(context).typeanythingofstddata:S.of(context).stdMark(currentStudent.firstName),
//                             labelStyle: Style().style(20, Colors.blue, false),
//                             floatingLabelStyle: Style().style(20, Colors.green, false),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               gapPadding: 4,
//                               borderSide: const BorderSide(color: Colors.blue,width: 2),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               gapPadding: 4,
//                               borderSide: const BorderSide(color: Colors.blue,width: 2),
//                             ),
//                             disabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20),
//                               gapPadding: 4,
//                               borderSide: const BorderSide(color: Colors.blue,width: 2),
//                             ),
//                             fillColor: Colors.grey,
//                             filled: false,
//                           ),
//                           style: Style().style(18, Colors.blue, false),
//                           textAlign: TextAlign.center,
//                           onSubmitted: (value)async{
//                             await manageMarks(value);
//                             setState(() {
//                               stdidMode = !stdidMode;
//                             });
//                             queryController.clear();
//                             markFocusNode.requestFocus();
//                           },
//                         )
//                       ),
//                       const SizedBox(height: 70,),
//                       const Divider(
//                         thickness: 2,
//                         height: 2,
//                         color: Colors.blue,
//                       ),
//                       Center(
//                         child: Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: const BoxDecoration(
//                             border: Border(
//                               right: BorderSide(width: 6,color:Colors.blue),
//                               left: BorderSide(width: 6,color:Colors.blue),
//                               top: BorderSide(width: 6,color:Colors.blue),
//                               bottom: BorderSide(width: 6,color:Colors.blue),
//                             ),
//                             borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(18),
//                               bottomRight: Radius.circular(18),
//                             ),
//                             color: Colors.blue
//                           ),
//                           child: Text(
//                             // "Submitted",
//                             S.of(context).submitted,
//                             style: Style().style(24, Colors.white, true),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height:15),
//                       ListView.builder(
//                         // controller: ScrollController(),
//                         reverse: true,
//                         shrinkWrap: true,
//                         itemCount: marks.length,
//                         itemBuilder: (context,index){
//                           var student = searchAttendants(marks.keys.elementAt(index));
//                           // print(student.firstName);
//                           if(student != null){
//                             return Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               elevation: 4,
//                               color: Colors.green,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(20.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       Style().replace(student.firstName),
//                                       style: Style().style(18,Colors.white,true),
//                                     ),
//                                     const SizedBox(width: 8,),
//                                     Text(
//                                       // "Mark : ${marks.values.elementAt(index)}",
//                                       S.of(context).mark(marks.values.elementAt(index)),
//                                       style: Style().style(15,Colors.white,true),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }else{
//                             return Container();
//                           }
                          
//                         }
//                       )
                    
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: ()async{
//           Session session2 = session;
          
//           setState(() {
//             session2.mark = marks;
//           });
//           await Control().insertWorksession(session: session2);
//           Navigator.pop(context);
//         },
//         backgroundColor: Colors.red,
//         child: const Icon(
//           Icons.home,
//           color: Colors.white,
//         ),
//       )
//     );
//   }
// }