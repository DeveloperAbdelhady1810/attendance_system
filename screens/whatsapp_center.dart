import 'dart:io';
import 'package:attendants/classes/session.dart';
import 'package:attendants/classes/sql_center.dart';
import 'package:attendants/classes/style.dart';
import 'package:attendants/classes/user.dart';
import 'package:attendants/generated/l10n.dart';
import 'package:attendants/screens/homesender.dart';
import 'package:flutter/material.dart';
class WhatsappCenter extends StatefulWidget {
  const WhatsappCenter({Key? key, required this.marks, required this.expected, required this.attended, required this.session}) : super(key: key);
  final Map<String,String> marks;
  final List expected;
  final List attended;
  final Session session;
  @override
  State<WhatsappCenter> createState() => _WhatsappCenterState();
}
Map<String,String> marks = {};
String messageAlert = "";
String status = S.current.pressStart;
getStudent(String studentEmail)async{
  var studentData = await SqlCenter().getStudent(studentEmail);
  if(studentData.toString()!="Not Found"){
    var student3 = Student(
      cardId: studentData['id'].toString(),
      email: studentData['email'],
      firstName: studentData['firstname'],
      gender: studentData['gender'],
      lastName: studentData['lastname'],
      parrentEmail: studentData['parrentemail'],
      parrentPassword: "",
      parrentPhone: studentData['parrentphone'],
      password: "",
      phone: studentData['phone'],
      stage: studentData['stage'].toString().replaceAll("QuadroEncoding", " "),
      place: studentData['place'],
      state: studentData['state'],
      time: studentData['time'].toString().replaceAll("QuadroEncoding", " "),
      balance: studentData['balance'].toString().replaceAll("QuadroEncoding", " "),
    );
    return student3;
  }else{
    return "Not Found";
  }
}
bool ready =false;
bool started =false;
bool finished = false;
bool initializing = false;
class _WhatsappCenterState extends State<WhatsappCenter> {
  // prepareWhatsapp()async{
  //   List<Map<String,String>> associatedList = [];
  //   marks.forEach((key, value) async{
  //     Student student = await getStudent(key);
  //     if(Variables().homeworkBox.get(student.email) != null){
  //       associatedList.add({
  //         student.parrentPhone:"السلام عليكم ولي أمر الطالب ${student.firstName} ${student.lastName} لقد حضر الطالب وقام بعمل الواجب ودرجة امتحانه $value"
  //       });
  //     }else{
  //       associatedList.add({
  //         student.parrentPhone:"السلام عليكم ولي أمر الطالب ${student.firstName} ${student.lastName} لقد حضر الطالب ولم يقوم بعمل الواجب ودرجة امتحانه $value"
  //       });
  //     }
  //     if (associatedList.length == marks.keys.length) {
  //       String message = await Export().exportToCsv(associatedList);
  //       if (message == "success") {
  //         setState(() {
  //           ready = true;
  //           // messageAlert = "Whatsapp Bot is Ready To Go";
  //           messageAlert = S.of(context).whatsappBotReady;
  //         });
  //       } else {
  //         setState(() {
  //           ready = false;
  //           // messageAlert = "Error In Preparing Whatsapp Bot";
  //           messageAlert = S.of(context).errorInPreparingWhatsappBot;
  //         });
  //       }
  //     }
  //   });
  // }
  donePrepared()async{
    setState(() {
      ready = true;
      messageAlert = S.of(context).whatsappBotReady;
    });
  }
  preparesettings()async{
    await Process.run("Get Whatz Trial.exe",[]);
    
  }
  async()async{
    // await preparesettings();
  }
  @override
  void initState() {
    marks = widget.marks;
    async();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width-15,
        height: MediaQuery.of(context).size.height-10,
        padding: const EdgeInsets.symmetric(horizontal:20,vertical: 0),
        margin: const EdgeInsets.symmetric(horizontal:6.5,vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Colors.green,blurRadius: 7),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    // "Whatsapp Center",
                    S.of(context).whatsappcenter,
                    style:Style().style(30,ready?Colors.green: Colors.red, true)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    messageAlert,
                    style:Style().style(30,ready?Colors.green: Colors.red, true)
                  ),
                ),
                
              ],
            ),
            const SizedBox(height: 35,),
            Center(
              child: Text(
                // "Process Status ...",
                S.of(context).processStatus,
                style: Style().style(25, Colors.blue, false),
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal:20,vertical: 0),
              margin: const EdgeInsets.symmetric(horizontal:6.5,vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(color: Colors.green,blurRadius: 7),
                ],
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Text(
                    status,
                    style: Style().style(25, Colors.blue, false),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            ready
            ?
            !started
            ?
            TextButton(
              style: ButtonStyle(
                shadowColor: MaterialStateProperty.all<Color>(Colors.green),
                elevation: MaterialStateProperty.all<double>(30),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: ()async{
                setState(() {
                  started = true;
                });
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  // MaterialPageRoute(builder: (context)=>WhatsappCenter(marks:marks,attended: Variables().attendedBox.keys.toList(),expected: Variables().expectedBox.keys.toList(),))
                  MaterialPageRoute(builder: (context)=>MyHomePage(session:widget.session))
                );
              },
              child: Text(
                S.of(context).start,
                style: Style().style(24, Colors.white, false),
              )
            )
            :
            finished?
            TextButton(
              style: ButtonStyle(
                shadowColor: MaterialStateProperty.all<Color>(Colors.green),
                elevation: MaterialStateProperty.all<double>(30),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: ()async{
                Navigator.of(context).pop();
              },
              child: Text(
                S.of(context).close,
                style: Style().style(24, Colors.white, false),
              )
            )
            :const SizedBox()
            :const SizedBox(),
            Row(
              children:[
                TextButton(
                  style: Style().buttonStyle(Colors.green, Colors.green[900], 20),
                  onPressed: ()async{
                    if(initializing == true){
                      setState(() {
                        initializing = true;
                      });
                      await preparesettings();
                      setState(() {
                        initializing = false;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: !initializing? Text(
                      "Initialize Whatz",
                      style: Style().style(20, Colors.white, true),
                    )
                    :const CircularProgressIndicator(),
                  )
                ),
              ]
            ),
            const SizedBox(height:10),
            Text(
              "Double Check For the a.txt, i.txt Are Existing in Folder",
              style: Style().style(16, Colors.black, false),
            ),
            const SizedBox(height: 10,),
            Row(
              children:[
                TextButton(
                  style: Style().buttonStyle(Colors.blue, Colors.blue[900], 20),
                  onPressed: ()async{
                    await donePrepared();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: !initializing? Text(
                      "Checked?",
                      style: Style().style(20, Colors.white, true),
                    )
                    :const CircularProgressIndicator(),
                  )
                ),
              ]
            ),
          ],
        )
      ),
    );
  }
}