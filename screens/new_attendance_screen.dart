import 'dart:io';

import 'package:attendants/classes/control_database.dart';
import 'package:attendants/classes/export.dart';
import 'package:attendants/classes/session.dart';
import 'package:attendants/classes/sql_center.dart';
import 'package:attendants/classes/style.dart';
import 'package:attendants/classes/user.dart';
import 'package:attendants/classes/variables.dart';
import 'package:attendants/generated/l10n.dart';
import 'package:attendants/screens/upload_to_server.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class NewAttendanceScreen extends StatefulWidget {
  const NewAttendanceScreen({super.key, required this.session, required this.isworksession, required this.chpname});
  final Session session;
  final bool isworksession;
  final String chpname;
  @override
  State<NewAttendanceScreen> createState() => _NewAttendanceScreenState();
}
Map searchResults = {};
TextEditingController searchallController = TextEditingController();
TextEditingController quizFullMarkController = TextEditingController(text:"10");
String selectedBranch = "Alfa El Haram";
String state = "";
bool showDropDown = true;
bool loading = false;
Map allStudents = {};
Map expected = {};
Map attended = {};
Map online = {};
int sent = 0;
Map messages = {};
Session currentAttendantsSession= Session(stage: "", branch: selectedBranch, attendants: [], name: "", time: "",weekday: "",sessionId: "",mark: {},isscientific: "false",chpname:"");
class _NewAttendanceScreenState extends State<NewAttendanceScreen> {
  removeFromAttendants(Map student)async{
    // print("in delete");
    setState(() {
      currentAttendantsSession.attendants.remove(student['id'].toString());
      online.remove(student['id'].toString());
      attended.remove(student['id'].toString());
      // student3Email = student.email;
    });
    await Control().deleteStudent(box: Variables().attendedBox, studentid: student['id'].toString());
    await Control().deleteStudent(box: Variables().homeworkBox, studentid: student['id'].toString());
    await Control().addStudent(box: Variables().expectedBox, student:student);
    setState((){});
  }
  search(String value)async{
    setState(() {
      searchResults.clear();
    });
    for(Map student in Variables().manuallyAddedBox.values){
      if(student['id'].toString().toString()==value.toString()){
        setState((){
          searchResults.addAll({student['id'].toString():student});
        });
        break;
      }else if(student['phone'] == value){
        setState((){
          searchResults.addAll({student['id'].toString():student});
        });
        break;
      }else if(student['name'].contains(value)){
        setState((){
          searchResults.addAll({student['id'].toString():student});
        });
      }else if(student['parentphone'] == value){
        setState((){
          searchResults.addAll({student['id'].toString():student});
        });
      }
    }
  }
  Map searchAttendAtStart(String phone){
    Map targetStd = {};
    for (Map student in allStudents.values) {
      if (student['phone']==phone) {
        targetStd = student;
        break;
      }
    }
    return targetStd;
  }
  start()async{
    // var studentsResponse = await  SqlCenter().getExpectedStudent(widget.session.stage,selectedBranch,widget.session.isscientific);
    // setState(() {
    //   expected = studentsResponse;
    //   showDropDown = false;
    // });
    // for (Map student in expected.values) {
    //   await Control().addStudent(box: Variables().expectedBox, student: student);
    // }
    setState((){
      loading = true;
    });
    var manuallyResponse = await  SqlCenter().getStudentsManually(widget.session.stage,widget.session.isscientific,widget.chpname,widget.session.name,selectedBranch);
    // print(manuallyResponse['All']);
    if(manuallyResponse == "Not Found"){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("No Students in this specifications")));
    }else{
      setState(() {
        allStudents = manuallyResponse['All'];
        showDropDown = false;
      });
      if(manuallyResponse['Attended'] !=null){
        for (Map student2 in manuallyResponse['Attended'].values) {
          Map targetStd = searchAttendAtStart(student2['phone']);
          if(targetStd.isNotEmpty){
            await Control().addStudent(box: Variables().attendedBox, student: targetStd);
            await Control().addStudent(box: Variables().homeworkBox, student: targetStd);
            setState((){
              currentAttendantsSession.mark[targetStd['phone'].toString()] = student2['mark'];
            });
            if(student2['state']=="Online"){
              setState((){
                online.addAll({targetStd['id'].toString():targetStd});
              });
            }else{
              setState((){
                attended.addAll({targetStd['id'].toString():targetStd});
              });
            }
          }
        }
      }
      for (Map student in allStudents.values) {
        await Control().addStudent(box: Variables().manuallyAddedBox, student: student);
        if(student['center']==selectedBranch){
          setState((){
            expected.addAll({student['id']:student});
          });
          await Control().addStudent(box: Variables().expectedBox, student: student);
        }
      }
    }
    setState((){
      loading = false;
    });
  }
  addToAttendants(Map student)async{
    setState(() {
      currentAttendantsSession.attendants.add(student);
    });
    await Control().addStudent(box: Variables().attendedBox, student: student);
    await Control().addStudent(box: Variables().homeworkBox, student: student);
    // await Control().deleteStudent(box: Variables().expectedBox, studentid: student['id'].toString().toString());
    if(student['state'] == "Online"){
      setState((){
        online.addAll({student['id'].toString():student});
      });
    }else{
      setState((){
        attended.addAll({student['id'].toString():student});
      });
    }
  }
  @override
  void initState() {
    if(widget.isworksession){
      Session session = Variables().worksession.getAt(0);
      setState(() {
        showDropDown = false;
        currentAttendantsSession = session;
        for (Map student55 in Variables().expectedBox.values) {
          if (!currentAttendantsSession.attendants.contains(student55)) {
            expected.addAll({student55['id'].toString():student55});
          }
        }
        for (Map student66 in Variables().attendedBox.values) {
          if (student66['state']=="Online") {
            online.addAll({student66['id'].toString():student66});
          } else {
            attended.addAll({student66['id'].toString():student66});
          }
        }
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        body:Container(
          width: MediaQuery.of(context).size.width-15,
          height: MediaQuery.of(context).size.height-10,
          padding: const EdgeInsets.symmetric(horizontal:20,vertical: 0),
          margin: const EdgeInsets.symmetric(horizontal:6.5,vertical: 10),
          decoration:  BoxDecoration(
            color: Colors.white,
            image: const DecorationImage(
              image: AssetImage("assets/images/logo png.jpg"),
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const[
              BoxShadow(color: Colors.blue,blurRadius: 5),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // width: MediaQuery.of(context).size.width * 0.25,
                  padding: const EdgeInsets.symmetric(horizontal:10),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.session.name,
                        style: Style().style(28, Colors.white, true),
                      ),
                      !showDropDown?Text(
                        // "You are working in $selectedBranch",
                        selectedBranch,
                        style: Style().style(22, Colors.white, true),
                      )
                      :
                      const SizedBox(),
                      showDropDown
                      ?
                      DropdownButton(
                        value: selectedBranch,
                        items: const [
                          DropdownMenuItem(value: 'Alfa El Haram', child: Text("Alfa El Haram")),
                          DropdownMenuItem(value: 'Alfa El Taawon', child: Text("Alfa El Taawon")),
                          DropdownMenuItem(value: 'Alfa El Lebeeny', child: Text("Alfa El Lebeeny")),
                          DropdownMenuItem(value: 'El Nakheel', child: Text("El Nakheel',")),
                          DropdownMenuItem(value: 'Learn El Mohanseen', child: Text("Learn El Mohanseen")),
                          DropdownMenuItem(value: 'Learn El Dokki', child: Text("Learn El Dokki")),
                          DropdownMenuItem(value: 'Teachers Hadeye October', child: Text("Teachers Hadeye October")),
                        ],
                        onChanged: (value)async{
                          // print(value);
                          if (value != "Select") {
                            setState(() {
                              selectedBranch = value as String;
                              widget.session.branch = value;
                              Control().insertWorksession(session: widget.session);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Preparing Offline Mode ....."))
                            );
                            // await getSessionDetails();
                            // await manageAttendants();
                            await start();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Offline Mode is Ready "))
                            );
                          }
                        }
                      )
                      :
                      Column(
                        children: [
                          const SizedBox(height:5),
                          TextButton(
                            onPressed: ()async{
                              Variables().attendantsContext = context;
                              await Control().deleteAll(box: Variables().worksession);
                              await Control().deleteAll(box: Variables().attendedBox);
                              await Control().deleteAll(box: Variables().blockedBox);
                              await Control().deleteAll(box: Variables().blockedFromAttend);
                              await Control().deleteAll(box: Variables().expectedBox);
                              await Control().deleteAll(box: Variables().manuallyAddedBox);
                              await Variables().worksession.clear();
                              await Process.run("close.bat",[]);
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(30),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            child: Text(
                              // "Exit Without Saving",
                              S.of(context).exitWithoutSaving,
                              style: Style().style(20,Colors.blue,true)
                            ),
                          ),
                          const SizedBox(height:5),
                          TextButton(
                            onPressed: ()async{
                              String success = await Export().exportAttendants2(session:widget.session);
                              if (success == "success"){
                                Variables().attendantsContext = context;
                                showDialog(context:context,builder: (context){
                                  return StatefulBuilder(
                                    builder: (context,setState2){
                                      return Dialog(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Uploading To Server...",
                                              style:Style().style(30,Colors.blue,true),
                                            ),
                                            const SizedBox(height: 5,),
                                            const Divider(
                                              thickness: 2,
                                              height: 2,
                                              color: Colors.blue,
                                            ),
                                            const SizedBox(height: 5,),
                                            state==""?TextButton(
                                              style: Style().buttonStyle(Colors.blue, Colors.blue.shade900, 20),
                                              onPressed:()async{
                                                setState2((){
                                                  state = "Adding Attendance....";
                                                });
                                                await SqlCenter().addToAttendants2(Variables().attendedBox.values.toList(), widget.session.name, widget.session.chpname, widget.session.stage, widget.session.branch);
                                                setState2((){
                                                  state = "Adding Marks....";
                                                });
                                                await SqlCenter().addMarks2(widget.session.name,widget.session.chpname,widget.session.stage,currentAttendantsSession.mark);
                                                setState2((){
                                                  state = "Done";
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Start",
                                                  style:Style().style(20,Colors.white,false)
                                                ),
                                              )
                                            ):
                                            state!="Done"?const CircularProgressIndicator(
                                              color: Colors.white,
                                              backgroundColor: Colors.blue,
                                            ):const Icon(Icons.check,color:Colors.green),
                                            const SizedBox(height: 5,),
                                            Text(
                                              state,
                                              style:Style().style(20,Colors.blue,false)
                                            ),
                                            const SizedBox(height: 5,),
                                            state=="Done"||sent==messages.length?Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                TextButton(
                                                  style: Style().buttonStyle(Colors.blue,Colors.blue[900],20),
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                    setState2((){
                                                      state="";
                                                    });
                                                    setState((){
                                                      state="";
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Close Dialog (Continue Session)",
                                                      style: Style().style(18, Colors.white, true),
                                                    ),
                                                  )
                                                ),
                                                TextButton(
                                                  style: Style().buttonStyle(Colors.red,Colors.red[900],20),
                                                  onPressed: ()async{
                                                    await Control().deleteAll(box: Variables().worksession);
                                                    await Control().deleteAll(box: Variables().attendedBox);
                                                    await Control().deleteAll(box: Variables().blockedBox);
                                                    await Control().deleteAll(box: Variables().blockedFromAttend);
                                                    await Control().deleteAll(box: Variables().expectedBox);
                                                    await Control().deleteAll(box: Variables().manuallyAddedBox);
                                                    await Variables().worksession.clear();
                                                    await Process.run("close.bat",[]);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Close Session",
                                                      style: Style().style(18, Colors.white, true),
                                                    ),
                                                  )
                                                ),
                                                TextButton(
                                                  style: Style().buttonStyle(Colors.green,Colors.green[900],20),
                                                  onPressed: ()async{
                                                    setState2((){
                                                      state="Prepairing Messages....";
                                                    });
                                                    setState2((){
                                                      messages = Variables().prepairMessages();
                                                    });
                                                    setState((){
                                                      messages = Variables().prepairMessages();
                                                    });
                                                    for(String phone in messages.keys){
                                                      setState2((){
                                                        state = "Sleeping....";
                                                      });
                                                      await Future.delayed(const Duration(seconds:7));
                                                      setState2((){
                                                        sent++;
                                                        state="Sending Messages....";
                                                      });
                                                      try{
                                                        http.Response sendMessage = await http.get(Uri.parse("http://localhost:3000/send?phone=$phone&message=${messages[phone]}"));
                                                      }catch(e){}
                                                    }
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Send Whatsapp Messages",
                                                      style: Style().style(18, Colors.white, true),
                                                    ),
                                                  )
                                                ),
                                              ],
                                            ):Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Close Dialog (Continue Session)",
                                                    style: Style().style(18, const Color.fromARGB(255, 109, 102, 151), true),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Close Session",
                                                    style: Style().style(18, const Color.fromARGB(255, 163, 106, 106), true),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Send Whatsapp Messages",
                                                    style: Style().style(18, const Color.fromARGB(255, 135, 163, 126), true),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height:5),
                                            state=="Sending Messages...."||state=="Sleeping...."?Text(
                                              "Sent $sent / ${messages.length}",
                                              style:Style().style(25,Colors.blue,true)
                                            ):const SizedBox(),
                                      
                                          ]
                                        ),
                                      );
                                    }
                                  );
                                });
                              }
                              
                            },
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(30),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                            child: Text(
                              // "Submit This Session",
                              S.of(context).submitThisSession,
                              style: Style().style(20,Colors.blue,true)
                            ),
                          ),
                          const SizedBox(height:5),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Expected (${expected.length})",
                      style: Style().style(25, Colors.blue, true),
                    ),
                    Text(
                      "Attended (${attended.length})",
                      style: Style().style(25, Colors.green, true),
                    ),
                    Text(
                      "Online (${online.length})",
                      style: Style().style(25, Colors.green, true),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.blue,width: 2),
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 300,
                          child:TextField(
                            controller: searchallController,
                            style: Style().style(24, Colors.blue, true),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: "Search | Scan",
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                            onChanged: (value){
                              search(value);
                            },
                            onSubmitted: (value)async{
                              addToAttendants(searchResults.values.elementAt(0));
                            },
                          )
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(color: Colors.blue,width: 2),
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 200,
                          child:TextField(
                            controller: quizFullMarkController,
                            style: Style().style(20, Colors.blue, true),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: "Quiz Full Mark",
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                          )
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white.withOpacity(0.7),
                  child: DataTable(
                    dividerThickness: 2,
                    // checkboxHorizontalMargin: 1.5,
                    dataTextStyle: Style().style(18, Colors.black, true),
                    border: TableBorder(
                      borderRadius: BorderRadius.circular(18),
                      bottom: const BorderSide(
                        color: Colors.indigo,
                        width: 2
                      ),
                      left: const BorderSide(
                        color: Colors.indigo,
                        width: 2
                      ),
                      right: const BorderSide(
                        color: Colors.indigo,
                        width: 2
                      ),
                      top: const BorderSide(
                        color: Colors.indigo,
                        width: 2
                      ),
                    ),
                    columns: [
                      DataColumn(label: Wrap(children:[Text('Name',style:Style().style(22,Colors.blue,true))])),
                      DataColumn(label: Wrap(children:[Text('Phone',style:Style().style(22,Colors.blue,true))])),
                      DataColumn(label: Wrap(children:[Text('Parent',style:Style().style(22,Colors.blue,true))])),
                      DataColumn(label: Wrap(children:[Text('ID',style:Style().style(22,Colors.blue,true))])),
                      DataColumn(label: Wrap(children:[Text('Stage',style:Style().style(22,Colors.blue,true))])),
                      DataColumn(label: Wrap(children:[Text('Attended',style:Style().style(22,Colors.blue,true))])),
                      DataColumn(label: Wrap(children:[Text('Mark',style:Style().style(22,Colors.blue,true))])),
                      DataColumn(label: Wrap(children:[Text('Actions',style:Style().style(22,Colors.blue,true))]))
                    ],
                    rows: searchallController.text.isEmpty? expected.values.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item['name'])),
                        DataCell(Text(item['phone'])),
                        DataCell(Text(item['parentphone'])),
                        DataCell(Text(item['id'].toString().toString())),
                        DataCell(Text(item['stage'])),
                        DataCell(
                          Variables().attendedBox.keys.contains(item['id'].toString())?const Icon(
                            Icons.check,
                            color: Colors.green
                          ):const Icon(
                            Icons.clear,
                            color: Colors.red
                          )
                        ),
                        DataCell(
                          TextField(
                            controller: TextEditingController(text: currentAttendantsSession.mark[item['phone'].toString()]??"0"),
                            onSubmitted: (value)async{
                              setState(() {
                                currentAttendantsSession.mark[item['phone'].toString()] = "$value/${quizFullMarkController.text}";
                              });
                              Session session2 = currentAttendantsSession;
                              session2.chpname = widget.chpname;
                              await Control().insertWorksession(session: session2);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:BorderSide(
                                  color:Colors.blue
                                )
                              ),
                            ),
                          )
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: ()async{
                                  await Control().homeworkmanagment(student: item);
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.home_work,
                                  color:Variables().homeworkBox.get(item['id'].toString())!=null?Colors.green: Colors.red,
                                  size: 30
                                )
                            
                              ),
                              !Variables().attendedBox.keys.contains(item['id'].toString())?
                              IconButton(
                                icon:const Icon(
                                  Icons.person_add,
                                  color: Colors.blue,
                                ),
                                onPressed: ()async{
                                  await addToAttendants(item);
                                  // // DataScreenState().controllers(item['name'],item['phone'],item['parentphone'],item['parrentJob'],item['stage'],item['center']);
                                },
                              ):
                              IconButton(
                                icon:const Icon(
                                  Icons.person_off,
                                  color: Colors.red,
                                ),
                                onPressed: ()async{
                                  await removeFromAttendants(item);
                                  // // DataScreenState().controllers(item['name'],item['phone'],item['parentphone'],item['parrentJob'],item['stage'],item['center']);
                                },
                              ),
                            ],
                          )
                        ),
                      ]);
                    }).toList()
                    :
                    searchResults.values.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item['name'])),
                        DataCell(Text(item['phone'])),
                        DataCell(Text(item['parentphone'])),
                        DataCell(Text(item['id'].toString().toString())),
                        DataCell(Text(item['stage'])),
                        DataCell(
                          Variables().attendedBox.keys.contains(item['id'].toString())?const Icon(
                            Icons.check,
                            color: Colors.green
                          ):const Icon(
                            Icons.clear,
                            color: Colors.red
                          )
                        ),
                        DataCell(
                          TextField(
                            controller: TextEditingController(text: currentAttendantsSession.mark[item['phone'].toString()]??"0"),
                            onSubmitted: (value)async{
                              setState(() {
                                currentAttendantsSession.mark[item['phone'].toString()] = "$value/${quizFullMarkController.text}";
                              });
                              Session session2 = currentAttendantsSession;
                              session2.chpname = widget.chpname;
                              await Control().insertWorksession(session: session2);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:BorderSide(
                                  color:Colors.blue
                                )
                              ),
                            ),
                          )
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: ()async{
                                  await Control().homeworkmanagment(student: item);
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.home_work,
                                  color:Variables().homeworkBox.get(item['id'].toString())!=null?Colors.green: Colors.red,
                                  size: 30
                                )
                            
                              ),
                              !Variables().attendedBox.keys.contains(item['id'].toString())?
                              IconButton(
                                icon:const Icon(
                                  Icons.person_add,
                                  color: Colors.blue,
                                ),
                                onPressed: ()async{
                                  await addToAttendants(item);
                                  // // DataScreenState().controllers(item['name'],item['phone'],item['parentphone'],item['parrentJob'],item['stage'],item['center']);
                                },
                              ):
                              IconButton(
                                icon:const Icon(
                                  Icons.person_off,
                                  color: Colors.red,
                                ),
                                onPressed: ()async{
                                  await removeFromAttendants(item);
                                  // // DataScreenState().controllers(item['name'],item['phone'],item['parentphone'],item['parrentJob'],item['stage'],item['center']);
                                },
                              ),
                            ],
                          )
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
        floatingActionButton:expected.isEmpty
        ? FloatingActionButton(
          onPressed: (){
            Navigator.pop(context);
          },
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.home,
            color: Colors.white,
          ),
        )
        :
        null,
      ),
    );
  }
}