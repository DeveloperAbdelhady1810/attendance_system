import 'dart:io';
import 'package:attendants/classes/branch.dart';
import 'package:attendants/classes/create_codes.dart';
import 'package:attendants/classes/export.dart';
import 'package:attendants/classes/session.dart';
import 'package:attendants/classes/sql_center.dart';
import 'package:attendants/classes/style.dart';
import 'package:attendants/generated/l10n.dart';
import 'package:attendants/screens/add_student_screen.dart';
import 'package:attendants/screens/chapters_screen.dart';
import 'package:attendants/widgets/code_card.dart';
import 'package:attendants/widgets/session_card.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({Key? key, required this.connected, required this.connection, required this.currentStage}) : super(key: key);
  final bool connected;
  final String connection;
  final String currentStage;
  @override
  State<Home> createState() => _HomeState();
}
String selectedState = "Offline";
TextEditingController howManyCodesController = TextEditingController();
TextEditingController priceCodesController = TextEditingController();
TextEditingController specificWeekController = TextEditingController();
bool sending = false;
List<String> codes = [];
List<Widget> codesCardsToDisplay = [];
late BuildContext maincontext;
bool connected = false;
bool codesloading = false;
String connection = "";
String settingsMode = "";
String currentStage = "";
List sessionsOne = [];
List sessionsTwo = [];
List sessionsThree = [];
List <Session> sessions= [];
List<Widget> sessionsView = [];
List<Widget> sessionsViewTwo = [];
List<Widget> sessionsViewThree = [];
bool loading = false;
bool loading2 = false;
int specificWeek = 0;
TextEditingController firstName = TextEditingController();
TextEditingController lastName= TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController parrentPhone = TextEditingController();
TextEditingController parrentEmail = TextEditingController();
TextEditingController idNumber = TextEditingController();
String gender = "Male";
String stage = S.current.selectStage;
String password = "";
String selectedBranch = S.current.select;
List<Branch>branches = [
  Branch(
    name: "Alfa El Haram",
    firsttime: "",
    secondtime: "",
    thirdtime: "",
    isFirst: "true",
    isSecond: "true",
    isThird: "true",
    capacity: "0"
  ),
  Branch(
    name: "Alfa El Taawon",
    firsttime: "",
    secondtime: "",
    thirdtime: "",
    isFirst: "true",
    isSecond: "true",
    isThird: "true",
    capacity: "0"
  ),
  Branch(
    name: "Learn El Mohandseen",
    firsttime: "",
    secondtime: "",
    thirdtime: "",
    isFirst: "true",
    isSecond: "true",
    isThird: "true",
    capacity: "0"
  ),
  Branch(
    name: "Learn El Dokki",
    firsttime: "",
    secondtime: "",
    thirdtime: "",
    isFirst: "true",
    isSecond: "true",
    isThird: "true",
    capacity: "0"
  ),
  Branch(
    name: "Teachers Hadye October",
    firsttime: "",
    secondtime: "",
    thirdtime: "",
    isFirst: "true",
    isSecond: "true",
    isThird: "true",
    capacity: "0"
  ),
  Branch(
    name: "El Nakheel",
    firsttime: "",
    secondtime: "",
    thirdtime: "",
    isFirst: "true",
    isSecond: "true",
    isThird: "true",
    capacity: "0"
  ),
  Branch(
    name: "Alfa El Lebeeny",
    firsttime: "",
    secondtime: "",
    thirdtime: "",
    isFirst: "true",
    isSecond: "true",
    isThird: "true",
    capacity: "0"
  ),
];

List chapters = [];
List<DropdownMenuItem<String>> dropdownMenuItems = [
  DropdownMenuItem(value:"Select",child: Text(S.current.selectBranch))
];
class _HomeState extends State<Home> {
  // exportSpecificWeek()async{

  // }
  getChapters(currentStageChapters)async{
    chapters = await SqlCenter().getChapters(currentStageChapters);
    setState(() {});
  }
  // getBranches2()async{
  //   // http.Response response = await http.get(
  //   //   Uri.parse(
  //   //     "${Variables().ip}get_branches.php"
  //   //   ),
  //   // );
  //   // print(response.body);
  //   // Map branchesMap = jsonDecode(response.body);
  //   Map branchesMap = await SqlCenter().getBranches();
  //   branchesMap.forEach((key, value) {
  //     setState((){
  //       branches.add(
  //         Branch(
  //           name: value['name'],
  //           firsttime: value['firsttime'],
  //           secondtime: value['secondtime'],
  //           thirdtime: value['thirdtime'],
  //           isFirst: value['isfirst'],
  //           isSecond: value['issecond'],
  //           isThird: value['isthird'],
  //           capacity: value['capacity'].toString(),
  //         )
  //       );
  //     });
  //   });
  // }
  buildDropDown()async{
    if (dropdownMenuItems.length>1) {} else {
      for (Branch branch in branches) {
        if(stage=="Fist Secondry"){
          if(branch.isFirst=="true"){
            setState(() {
              dropdownMenuItems.add(
                DropdownMenuItem<String>(value: branch.name, child:Text(branch.name))
              );
            });
          }else{}
        }else if(stage=="Second Secondry"){
          if(branch.isSecond=="true"){
            setState(() {
              dropdownMenuItems.add(
                DropdownMenuItem<String>(value: branch.name, child:Text(branch.name))
              );
            });
          }else{}
        }else if(stage == "Third Secondry"){
          if(branch.isThird=="true"){
            setState(() {
              dropdownMenuItems.add(
                DropdownMenuItem<String>(value: branch.name, child:Text(branch.name))
              );
            });
          }else{}
        }else {
          // print(stage);
          setState(() {
            dropdownMenuItems.add(
              DropdownMenuItem<String>(value: branch.name, child:Text(branch.name))
            );
          });
        }
      }
    }
  }
  createCodesCards(List<String> codesToBeCards){
    List<Widget> cards =[];
    for (String currentCode in codesToBeCards) {
      cards.add(CodeCard(code: currentCode, index: codesToBeCards.indexOf(currentCode)+1));
    }
    return cards;
  }
  submitCodes(List codesToSend)async{
    setState(() {
      codesloading = true;
    });
    String message = await SqlCenter().submitCodes(codesToSend,priceCodesController.text);
    await Export().exportToExcel(codesToSend,priceCodesController.text);
    setState(() {
      codesloading = false;
    });
    Navigator.pop(context);
    // showDialog(
    //   context: context,
    //   builder: (context)=>AlertDialog(
    //     title: Text(message),
    //     content: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Wrap(
    //               children: codesCardsToDisplay,
    //             ),
    //           ),
    //           Align(
    //             alignment: Alignment.bottomRight,
    //             child: TextButton(
    //               onPressed: ()async{
    //                 print("$codesToSend here");
    //                 await Export().exportToExcel(codesToSend,priceCodesController.text);
    //               },
    //               child: Text(
    //                 S.of(context).export2excell,
    //                 style:Style().style(20, Colors.blue, true)
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   )
    // ).then((value) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(S.of(context).success,style: Style().style(22, Colors.white, true),),),
        backgroundColor: Colors.green,
      )
    );
    setState(() {
      codes.clear();
    });
  }
  submitSessionsCards(){
    // print(sessionsOne.length);
    // print(sessionsTwo.length);
    // print(sessionsThree.length);
    for(Session session in sessionsOne){
      if (session.stage == "First Secondry") {  
        String branch = session.branch;
        String time = session.time;
        List attendants = session.attendants;
        String content = session.name;
        String stage = session.stage;
        setState(() {
          sessionsView.add(
            SessionCard(sessionName: content, attendants: attendants.length.toString(), branch: branch, time: time,session: session)
          );
        });
        // print(session.name);
      } else {}
    }// second
    for(Session session in sessionsTwo){
      if (session.stage == "Second Secondry") {
        String branch = session.branch;
        String time = session.time;
        List attendants = session.attendants;
        String content = session.name;
        String stage = session.stage;
        setState(() {
          sessionsViewTwo.add(
            SessionCard(sessionName: content, attendants: attendants.length.toString(), branch: branch, time: time,session: session)
          );
        });
      } else {}
    }
    for(Session session in sessionsThree){
      if (session.stage == "Third Secondry") {
        String branch = session.branch;
        String time = session.time;
        List attendants = session.attendants;
        String content = session.name;
        String stage = session.stage;
        setState(() {
          sessionsViewThree.add(
            SessionCard(sessionName: content, attendants: attendants.length.toString(), branch: branch, time: time,session: session)
          );
        });
      } else {}
    }
    // print(sessionsView.length);
    // print(sessionsViewTwo.length);
    // print(sessionsViewThree.length);
  }
  // getSessions()async{
  //   sessions.clear();
  //   sessionsOne.clear();
  //   sessionsTwo.clear();
  //   sessionsThree.clear();
  //   sessionsView.clear();
  //   sessionsViewTwo.clear();
  //   sessionsViewThree.clear();
  //   var response = await SqlCenter().getSessions("3", "stage", "branch", "name");
  //   // print(response);
  //   if (response != "No Results Found!") {
  //     // response.forEach((key, value) async {
  //     for (var value in response.values) {
  //         Session session = Session(
  //         stage: value['stage'],
  //         branch: value['branch'],
  //         attendants: value['attendants'].toString().replaceAll("[", "").replaceAll("]", "").replaceAll(" ", "").split(",").map((e) => e).toList(),
  //         name: value['name'],
  //         time: "",
  //         weekday: value['weekday'],
  //         sessionId: value['id'].toString(),
  //         mark: {}
  //       );
  //       if (value['stage'] == "First Secondry") {
  //         setState(() {
  //           sessionsOne.add(session);
  //           String branch = session.branch;
  //           String time = session.time;
  //           List attendants = session.attendants;
  //           String content = session.name;
  //           String stage = session.stage;
  //           setState(() {
  //             sessionsView.add(
  //               SessionCard(sessionName: content, attendants: attendants.length.toString(), branch: branch, time: time,session: session)
  //             );
  //           });
  //         });
  //       }else if(value['stage'] == "Second Secondry"){
  //         setState(() {
  //           // session.time = sessionMap['secondtime'];
  //           sessionsTwo.add(session);
  //           String branch = session.branch;
  //           String time = session.time;
  //           List attendants = session.attendants;
  //           String content = session.name;
  //           String stage = session.stage;
  //           setState(() {
  //             sessionsViewTwo.add(
  //               SessionCard(sessionName: content, attendants: attendants.length.toString(), branch: branch, time: time,session: session)
  //             );
  //           });
  //         });
  //       }else{
  //         setState(() {
  //           // session.time = sessionMap['thirdtime'];
  //           sessionsThree.add(session);
  //           String branch = session.branch;
  //           String time = session.time;
  //           List attendants = session.attendants;
  //           String content = session.name;
  //           String stage = session.stage;
  //           setState(() {
  //             sessionsViewThree.add(
  //               SessionCard(sessionName: content, attendants: attendants.length.toString(), branch: branch, time: time,session: session)
  //             );
  //           });
  //         });
  //       }
  //       // }else{
  //       //   print("in else here 2020");
  //       // }
  //     }
  //     // });
  //     submitSessionsCards();  
  //   }
  // }
  async()async{
    // await getBranches2();
    // await buildDropDown();
  }
  @override
  void initState() {
    codes.clear();
    codesCardsToDisplay.clear();
    maincontext = context;
    connected = widget.connected;
    connection = widget.connection;
    currentStage = widget.currentStage;
    async();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Mr. Abdul-Aziz Tammam Attendance System",
                  style: Style().style(40, Colors.indigo, true)
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-100,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
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
              child: currentStage =="" 
              ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton.icon(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddStudentPage()));
                        },
                        icon: const Icon(Icons.person_add_alt,size: 35,color:Colors.white),
                        label: Text(
                          S.of(context).addStd,
                          style: Style().style(30, Colors.white, true)
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                          overlayColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 0, 103, 188)),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20))
                        )
                      ),
                      TextButton.icon(
                        onPressed: ()async{
                          if (loading == false){
                            setState(() {
                              loading = true;
                            });
                            List<String> branchNames=[];
                            for (Branch branch in branches) {
                              branchNames.add(branch.name);
                            }
                            String success = await SqlCenter().downloadAllStudents(branchNames);
                            setState(() {
                              loading = false;
                              if(success==''){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No students found')));
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.green,content: Text('Students downloaded successfully')));
                              }
                            });
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.red,content: Text('Please wait')));
                          }
                          
                        },
                        icon: const Icon(Icons.download,size: 35,color:Colors.white),
                        label: loading==false
                        ?
                        Text(
                          S.of(context).getStds,
                          style: Style().style(30, Colors.white, true)
                        )
                        :
                        const CircularProgressIndicator(color: Colors.white,),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                          overlayColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 13, 111, 0)),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20))
                        )
                      ),
                      // TextButton.icon(
                      //   onPressed: (){},
                      //   icon: const Icon(Icons.download,size: 35,color:Colors.white),
                      //   label: loading==false
                      //   ?
                      //   Text(
                      //     S.of(context).getStds,
                      //     style: Style().style(30, Colors.white, true)
                      //   )
                      //   :
                      //   const CircularProgressIndicator(color: Colors.white,),
                      //   style: ButtonStyle(
                      //     backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      //     shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                      //     overlayColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 13, 111, 0)),
                      //     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20))
                      //   )
                      // )
                      // SizedBox(
                      //   width: 250,
                      //   child: TextField(
                      //     controller: specificWeekController,
                      //     decoration: const InputDecoration(
                      //       border: OutlineInputBorder(),
                      //       labelText: 'Export Specific Week',
                      //       prefixText: "Week No.",
                      //       labelStyle: TextStyle(fontSize: 15),
                      //       suffixIcon: Icon(
                      //         Icons.downloading
                      //       ),
                      //     ),
                      //     onSubmitted: (value)async{
                      //       setState(() {
                      //         loading2 = true;
                      //         specificWeek = int.parse(value);
                      //       });
                      //       await exportSpecificWeek();
                      //       setState(() {
                      //         loading2 = false;
                      //       });
                      //     },
                      //   ),
                      // ),
                      // loading2?const CircularProgressIndicator():const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  const Divider(
                    thickness: 4,
                    height: 2,
                    color: Colors.blue,
                  ),
                  Center(
                    child:Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Text(
                        S.of(context).selectStage,
                        style: Style().style(35,Colors.blue,true),
                      ),
                    )
                  ),
                  const SizedBox(height: 25,),
                  Wrap(
                    children:[
                      TextButton(
                        onPressed: ()async{
                          // await getSession();
                          await getChapters("First Secondry");
                          setState(() {
                            settingsMode = "session";
                            currentStage = "First";
                          });
                        },
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
                          child: Center(
                            child: Text(
                              S.of(context).firstsec,
                              style: Style().style(35, Colors.black, true)
                            ),
                          ),
                        )
                      ),
                      TextButton(
                        onPressed: ()async{
                          // await getSession();
                          await getChapters("Second Secondry");
                          setState(() {
                            settingsMode = "session";
                            currentStage = "Second";
                          });
                        },
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
                          child: Center(
                            child: Text(
                              S.of(context).secondsec,
                              style: Style().style(35, Colors.black, true)
                            ),
                          ),
                        )
                      ),
                      TextButton(
                        onPressed: ()async{
                          // await getSession();
                          await getChapters("Third Secondry");
                          setState(() {
                            settingsMode = "session";
                            currentStage = "Third";
                          });
                        },
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
                          child: Center(
                            child: Text(
                              S.of(context).thirdsec,
                              style: Style().style(35, Colors.black, true)
                            ),
                          ),
                        )
                      ),
                    ]
                  ),
                ],
              )
              : ChaptersScreen(chapters:chapters),
            ),
          ],
        ),
      ),
      floatingActionButton:settingsMode!=""
      ?
      FloatingActionButton(
        onPressed: ()async{
          setState(() {
            settingsMode = "";
            currentStage = "";
          });
          await Process.run("close.BAT",[]);
        },
        child: const Icon(Icons.home,color:Colors.white,size: 40,)
      )
      :
      TextButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context)=> AlertDialog(
                content: StatefulBuilder(
                  builder: (context, setState) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.width * 0.5,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              S.of(context).createCodes,
                              style: Style().style(25, Colors.blue, true)
                            ),
                            const SizedBox(height: 20,),
                            TextField(
                              controller: howManyCodesController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.blue,width: 2),
                                ),
                                labelText: S.of(context).enterhowmanycodes,
                                hintText: "50",
                                hintStyle: Style().style(18, Colors.blue, false),
                                labelStyle: Style().style(20, Colors.blue, false),
                                floatingLabelStyle: Style().style(20, Colors.blue, false),
                              ),
                              style: Style().style(21, Colors.black, true),
                            ),
                            TextField(
                              controller: priceCodesController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(color: Colors.blue,width: 2),
                                ),
                                labelText: S.of(context).entercodesprice,
                                hintText: "150",
                                hintStyle: Style().style(18, Colors.blue, false),
                                labelStyle: Style().style(20, Colors.blue, false),
                                floatingLabelStyle: Style().style(20, Colors.blue, false),
                              ),
                              style: Style().style(21, Colors.black, true),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: ()async{
                                
                                if (codesloading) {
                                  
                                } else {
                                  if(howManyCodesController.text==""||howManyCodesController.text==null||howManyCodesController.text.isEmpty){
                                    // Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(S.of(context).enterhowmanycodes)));
                                  }else{
                                    List<String>codes2 = await CreateCodes().createCodes(int.parse(howManyCodesController.text)) as List<String>;
                                    setState(() {
                                      codes = codes2;
                                    });
                                    List<Widget>codesCards = createCodesCards(codes2);
                                    setState(() {
                                      codesCardsToDisplay = codesCards;
                                    });
                                    print(codes2);
                                    await submitCodes(codes2);
                                  }
                                  
                                }
                                
                              },
                              child: !codesloading? Text(
                                S.of(context).createCodes,
                                style: Style().style(20, Colors.blue, true),
                              ):const CircularProgressIndicator(),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                ),
            )
          );
        },
        child:Text(
          S.of(context).createCodes,
          style: Style().style(20, Colors.blue, true),
        )
      )
    );
  }
}
class StreamOnlineBuilder extends StatelessWidget {
  const StreamOnlineBuilder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context,AsyncSnapshot<ConnectivityResult> snapshot){
        if (snapshot.hasData){
          ConnectivityResult? result = snapshot.data;
          if(result==ConnectivityResult.mobile){
            // connected to mobile network
            // print("mobile");
            return currentStage =="First"
            ? SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    verticalDirection: VerticalDirection.down,
                    children:sessionsView
                  ),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width -100,
                      child: Container(
                        decoration:  BoxDecoration(
                          color: connected? Colors.green: Colors.red,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          )
                        ),
                        child: Text(
                          connection,
                          style: Style().style(24, Colors.white, true),
                          textAlign: TextAlign.center,
                        ), 
                      ),
                    )
                  ),
                ],
              ),
            )
            : currentStage == "Second"
            ? SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    children: sessionsViewTwo,
                  ),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width -100,
                      child: Container(
                        decoration:  BoxDecoration(
                          color: connected? Colors.green: Colors.red,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          )
                          
                        ),
                        child: Text(
                          connection,
                          style: Style().style(24, Colors.white, true),
                          textAlign: TextAlign.center,
                        ), 
                      ),
                    )
                  ),
                ],
              ),
            )
            : currentStage == "Third"
            ? SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    children: sessionsViewThree,
                  ),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width -100,
                      child: Container(
                        decoration:  BoxDecoration(
                          color: connected? Colors.green: Colors.red,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18),
                          )
                          
                        ),
                        child: Text(
                          connection,
                          style: Style().style(24, Colors.white, true),
                          textAlign: TextAlign.center,
                        ), 
                      ),
                    )
                  ),
                ],
              ),
            ):
            const SizedBox();
            // return CircularProgressIndicator();
          }else if(result == ConnectivityResult.wifi){
            // connected to wifi
            // print("WIFI");
            // Navigator.of(context).pop();
            // Navigator.push(context, MaterialPageRoute(builder: (maincontext)=>Home(connected:true,connection:connection,currentStage:currentStage)));
            return currentStage =="First"
            ? SingleChildScrollView(
              child: Wrap(
                children:sessionsView
              ),
            )
            : currentStage == "Second"
            ? SingleChildScrollView(
              child: Wrap(
                children: sessionsViewTwo,
              ),
            )
            : currentStage == "Third"
            ? SingleChildScrollView(
              child: Wrap(
                children: sessionsViewThree,
              ),
            ):
            const SizedBox();
            // return CircularProgressIndicator();
          }else{
            connected = false;
            connection = "No Internet Connection";
            // Navigator.of(context).pop();
            // Navigator.push(context, MaterialPageRoute(builder: (maincontext)=>Home(connected:true,connection:connection,currentStage:currentStage)));
            // return CircularProgressIndicator();
            return Text(connection);
          }
        } else {
          // return CircularProgressIndicator();
          return Center(
            child: Text(
              "Seems that you just submitted a session please restart the program",
              style: Style().style(30, Colors.blue, true),
            )
          );
        }
      },
    );
  }
}