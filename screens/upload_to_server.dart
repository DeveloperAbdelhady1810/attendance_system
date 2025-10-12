// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:attendants/classes/control_database.dart';
// import 'package:attendants/classes/sql_center.dart';
// import 'package:attendants/generated/l10n.dart';
// import 'package:attendants/screens/attendants_screen.dart';
// import 'package:attendants/screens/home.dart';
// import 'package:attendants/screens/homesender.dart';
// import 'package:attendants/screens/whatsapp_center.dart';
// import 'package:attendants/classes/style.dart';
// import 'package:attendants/classes/user.dart';
// import 'package:attendants/classes/variables.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// class UploadToServer extends StatefulWidget {
//   const UploadToServer({Key? key, required this.sessionId}) : super(key: key);
//   final String sessionId;
//   @override
//   State<UploadToServer> createState() => _UploadToServerState();
// }
// // attendants 
// // quiz id from session id
// // quiz marks
// // send all
// bool doneStep1 = false;
// bool doneStep2 = false;
// bool doneStep3 = false;
// bool doneStep4 = false;
// bool finished = false;
// bool alldone = false;
// List<String> attendants = [];
// String sessionId = "";
// String quizId= "";
// int percentage = 0;
// Map<String,String> marks = {};
// class _UploadToServerState extends State<UploadToServer> {
//   ConnectivityResult _connectivityStatus = ConnectivityResult.none;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   step1()async{
//     //print("in step 1");
//     // print(_connectivityStatus.toString());
//     int targettedLength = Variables().attendedBox.values.length;
//     if (!doneStep1) {
//       while (_connectivityStatus ==  ConnectivityResult.wifi || _connectivityStatus == ConnectivityResult.mobile){
//         // print("in while");
//         for (Student student in Variables().attendedBox.values) {
//           setState(() {
//             attendants.add(student.email.toString());
//           });
//         }  {
//           setState(() {
//         if (attendants.length == targettedLength) 
//             doneStep1 = true;
//           });
//           break;
//         }
//       }
//       // print(attendants);
//     } else if(!doneStep2){
//       await step2();
//       if(!doneStep3){
//         await step3();
//       }
//     }
//     if (!mounted) {
//       return Future.value(null);
//     }
//   }
//   step2()async{
//     while (_connectivityStatus ==  ConnectivityResult.wifi || _connectivityStatus == ConnectivityResult.mobile){
//       // http.Response response = await http.get(
//       //   Uri.parse(
//       //     "${Variables().ip}is_session_found.php?sessionName=${currentAttendantsSession.name}&stage=${currentAttendantsSession.stage}&branch=${currentAttendantsSession.branch}"
//       //   )
//       // );
//       var response = await SqlCenter().isSessionFound(currentAttendantsSession.name,currentAttendantsSession.stage,currentAttendantsSession.branch);
//       if (response.toString()!="Not Found"){
//       //   var data = jsonDecode(response.body);
      
//         setState(() {
//           sessionId = response['id'].toString();
//         });
//         // http.Response response2 = await http.post(
//         //   Uri.parse(
//         //     "${Variables().ip}get_quiz_id.php"
//         //   ),
//         //   body: {
//         //     "id":sessionId,
//         //   }
//         // );
//         var response2 = await SqlCenter().getQuizId(sessionId);
//         if (response2.toString()!="Not Found") {
//           setState(() {
//             quizId = response2.toString();
//             doneStep2 = true;
//           });
//           // print("quizId --------($quizId)");
//           break;
//         }else{
//           //print("quiz id error");
//         }
//       }else{
//         //print("else");
//       }
//       break;
//     }
//     if (!mounted) {
//       return Future.value(null);
//     }
//   }
//   step3()async{
//     // print(
//     //   Variables().worksession.values.elementAt(0).mark
//     // );
//     Map<String,String> workSession;
//     setState(() {
//       workSession = Variables().worksession.values.elementAt(0).mark;
//       marks = workSession;
//       doneStep3 = true;
//     });
//     if (!doneStep4) {
//       await step4();
//     }
//     if (!mounted) {
//       return Future.value(null);
//     }
//   }
//   step4()async{
//     if (!doneStep4) {
//       // print(currentAttendantsSession.stage);
//       while (_connectivityStatus ==  ConnectivityResult.wifi || _connectivityStatus == ConnectivityResult.mobile){
//         // http.Response response = await http.get(
//         //   Uri.parse(
//         //     "${Variables().ip}add_to_attendants.php?attendants=${attendants.toString().replaceAll(" ", "QuadroEncoding")}&id=$sessionId&stage=${currentAttendantsSession.stage.toString().replaceAll(" ", "QuadroEncoding")}&branch=${currentAttendantsSession.branch.toString().replaceAll(" ", "QuadroEncoding")}"
//         //   )
//         // );
//         // print("${Variables().ip}add_to_attendants.php?attendants=${attendants.toString().replaceAll(" ", "QuadroEncoding")}&id=$sessionId&stage=${currentAttendantsSession.stage.toString().replaceAll(" ", "QuadroEncoding")}&branch=${currentAttendantsSession.branch.toString().replaceAll(" ", "QuadroEncoding")}");
//         // print("${Variables().ip}add_to_attendants.php?attendants=${attendants.toString().replaceAll(" ", "QuadroEncoding")}&id=$sessionId&stage=${currentAttendantsSession.stage.toString().replaceAll(" ", "QuadroEncoding")}&branch=${currentAttendantsSession.branch.toString().replaceAll(" ", "QuadroEncoding")}");
//         // print(response.body.toString());
//         var response = await SqlCenter().addToAttendants(attendants,currentAttendantsSession.name, sessionId, currentAttendantsSession.stage.toString().replaceAll(" ", "QuadroEncoding"), currentAttendantsSession.branch.toString().replaceAll(" ", "QuadroEncoding"));
//         if(response.toString()=="Success"){
//           setState((){
//             doneStep4 = true;
//           });
//           if (!finished) {
//             await finish();
//           }
//         }
//         break;
//       }
//     }
//     if (!mounted) {
//       return Future.value(null);
//     }
//   }
//   finish()async{
//     setState((){
//       finished = true;
//     });
//     int done = 0;
//     int all = marks.values.length;
//     var responseAdd = await SqlCenter().addMark(currentAttendantsSession.name,currentAttendantsSession.stage, marks);
//     // marks.forEach((key, value) async{
//     //   var responseAdd = await SqlCenter().addMark(key, currentAttendantsSession.name,currentAttendantsSession.stage, value);
//     //   done++;
//     //   setState(() {
//     //     percentage = (done~/all)*100;
//     //   });
//     // });
//     setState(() {
//       alldone = true;
//     });
//     if (!mounted) {
//       return Future.value(null);
//     }
//   }
//   async()async{
//     await step1();
//   }
//   @override
//   void initState() {
//     super.initState();
//     if(_connectivityStatus ==  ConnectivityResult.wifi || _connectivityStatus == ConnectivityResult.mobile){
//       //print("from1");
//       async();
      
//     }else{
//       //print("from2");
//       initConnectivity();
//       _connectivitySubscription = _connectivity.onConnectivityChanged.listen((_updateConnectionStatus));
//     }
//     sessionId = widget.sessionId;
//   }
//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     _connectivityStatus = ConnectivityResult.none;
//     doneStep1 = false;
//     doneStep2 = false;
//     doneStep3 = false;
//     doneStep4 = false;
//     finished = false;
//     super.dispose();
//   }
//   Future<void> initConnectivity()async{
//     late ConnectivityResult result;
//     try {
//       result = await _connectivity.checkConnectivity();
//       // await manage();
      
//     } catch (e) {
//       //print(e);
//     }
//     if (!mounted) {
//       return Future.value(null);
//     }
//     return _updateConnectionStatus(result);
//   }
//   Future<void> _updateConnectionStatus(ConnectivityResult result)async{
//     setState(() {
//       _connectivityStatus = result;
//     });
//     if (!mounted) {
//       return Future.value(null);
//     }
//     step1();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         child: Center(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     // !doneStep1?"1) Gettiing Attendants......":"Got Attendants",
//                     !doneStep1?S.of(context).gettingattendants:S.of(context).gotattendants,
//                     style: Style().style(23, !doneStep1?Colors.blue:Colors.green, true),
//                   ),
//                   !doneStep1?const CircularProgressIndicator(color: Colors.blue,):const Icon(Icons.check,color: Colors.green,)
//                 ],
//               ),
//               const SizedBox(height: 10,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     // !doneStep2?"2) Getting Quiz Id........":"Got Id",
//                     !doneStep2?S.of(context).gettingquizid:S.of(context).gotid,
//                     style: Style().style(23, !doneStep2?Colors.blue:Colors.green, true),
//                   ),
//                   !doneStep2?const CircularProgressIndicator(color: Colors.blue,):const Icon(Icons.check,color: Colors.green,)
//                 ],
//               ),
//               const SizedBox(height: 10,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     // !doneStep3?"3) Arranging Quiz Marks........":"Got Marks",
//                     !doneStep3?S.of(context).arrangingquizmarks:S.of(context).gotmarks,
//                     style: Style().style(23, !doneStep3?Colors.blue:Colors.green, true),
//                   ),
//                   !doneStep3?const CircularProgressIndicator(color: Colors.blue,):const Icon(Icons.check,color: Colors.green,)
//                 ],
//               ),
//               const SizedBox(height: 10,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     // !doneStep4?"4) Send Attendants To The Server........":"Sent",
//                     !doneStep4?S.of(context).sendattendants:S.of(context).sent,
//                     style: Style().style(23, !doneStep4?Colors.blue:Colors.green, true),
//                   ),
//                   !doneStep4?const CircularProgressIndicator(color: Colors.blue,):const Icon(Icons.check,color: Colors.green,)
//                 ],
//               ),
//               const SizedBox(height: 30,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     // finished?"Marks Sent":"",
//                     finished?S.of(context).markssent:"",
//                     style: Style().style(25, Colors.blue, true),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "$percentage%",
//                     style: Style().style(25, Colors.blue, true),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30,),
//               Center(
//                 child: Row(
//                   mainAxisAlignment: finished ? MainAxisAlignment.spaceBetween:MainAxisAlignment.center,
//                   children: [
//                     TextButton(
//                       onPressed: ()async{
//                         if (finished) {
//                           // await prepareWhatsapp();
//                           await Control().deleteAll(box: Variables().worksession);
//                           await Control().deleteAll(box: Variables().attendedBox);
//                           await Control().deleteAll(box: Variables().blockedBox);
//                           await Control().deleteAll(box: Variables().blockedFromAttend);
//                           await Control().deleteAll(box: Variables().expectedBox);
//                           await Control().deleteAll(box: Variables().manuallyAddedBox);
//                           await Variables().worksession.clear();
//                           // _connectivitySubscription.cancel();
//                           Navigator.pop(context);
//                           Navigator.pop(context);
//                           Navigator.of(context).push(
//                             MaterialPageRoute(builder: (context)=>const Home(connected: false,connection: "",currentStage: "",))
//                           );
//                           await Process.run("close.bat",[]);
//                         }else{
//                           Navigator.pop(context);
//                           await Process.run("close.bat", []);
//                         }
                        
//                       },
//                       style: ButtonStyle(
//                         shadowColor: MaterialStateProperty.all<Color>(Colors.blue),
//                         elevation: MaterialStateProperty.all<double>(30),
//                         backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                       ),
//                       child: Text(
//                         // finished?"Close":"Back",
//                         finished?S.of(context).close:S.of(context).back,
//                         style: Style().style(23, Colors.white, false),
//                       )
//                     ),
//                     finished?TextButton(
//                       onPressed: ()async{
//                         // Navigator.pop(context);
//                         await Process.run("close.bat", []);
//                       },
//                       style: ButtonStyle(
//                         shadowColor: MaterialStateProperty.all<Color>(Colors.blue),
//                         elevation: MaterialStateProperty.all<double>(30),
//                         backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//                       ),
//                       child: Text(
//                         S.of(context).back,
//                         style: Style().style(23, Colors.white, false),
//                       )
//                     ):const SizedBox()
//                     ,
//                     finished ?
//                     TextButton(
//                       onPressed: ()async{
//                         if (finished) {
//                           // await prepareWhatsapp();
//                           // _connectivitySubscription.cancel();
//                           Navigator.pop(context);
//                           Navigator.pop(context);
//                           Navigator.of(context).push(
//                             MaterialPageRoute(builder: (context)=>WhatsappCenter(marks:marks,attended: Variables().attendedBox.keys.toList(),expected: Variables().expectedBox.keys.toList(),session:currentAttendantsSession))
//                             // MaterialPageRoute(builder: (context)=>MyHomePage(marks:marks,attended: Variables().attendedBox.keys.toList(),expected: Variables().expectedBox.keys.toList(),))
//                           );
//                           await Control().deleteAll(box: Variables().worksession);
//                           await Control().deleteAll(box: Variables().attendedBox);
//                           await Control().deleteAll(box: Variables().blockedBox);
//                           await Control().deleteAll(box: Variables().blockedFromAttend);
//                           await Control().deleteAll(box: Variables().expectedBox);
//                           await Control().deleteAll(box: Variables().manuallyAddedBox);
//                           await Variables().worksession.clear();
//                         }else{
//                           Navigator.pop(context);
//                         }
//                       },
//                       style: ButtonStyle(
//                         shadowColor: MaterialStateProperty.all<Color>(Colors.green),
//                         elevation: MaterialStateProperty.all<double>(30),
//                         backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
//                       ),
//                       child: Text(
//                         S.of(context).gotowhatsappcenter,
//                         style: Style().style(23, Colors.white, false),
//                       )
//                     )
//                     :
//                     const SizedBox(),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }