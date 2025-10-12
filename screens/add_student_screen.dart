import 'package:attendants/classes/branch.dart';
import 'package:attendants/classes/session.dart';
import 'package:attendants/classes/sql_center.dart';
import 'package:attendants/classes/style.dart';
import 'package:attendants/generated/l10n.dart';
import 'package:flutter/material.dart';
class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}
String selectedState = "Center";
String currentStage = "";
bool loading = false;
TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController phone = TextEditingController();
TextEditingController parrentPhone = TextEditingController();
TextEditingController parrentEmail = TextEditingController();
String id = "";
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
List<DropdownMenuItem<String>> dropdownMenuItems = [
  DropdownMenuItem(value:"Select",child: Text(S.current.selectBranch))
];

class _AddStudentPageState extends State<AddStudentPage> {
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
  // getBranches2()async{
  //   branches.clear();
  //   var branchesMap = await SqlCenter().getBranches();
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
  async()async{
    // await getBranches2();
    await buildDropDown();
  }
  @override
  void initState() {
    async();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/images/logo png.jpg",
                          width: 100,
                        ),
                        const SizedBox(width: 20,),
                        Text(
                          "Register New Student",
                          style: Style().style(30, Colors.indigo, true),
                        ),
                      ],
                    ),
                  ),
                  // Card(
                  //   color: Colors.grey,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10),
                  //     side: const BorderSide(color: Colors.grey,width: 2),
                  //   ),
                  //   child:Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Text(
                  //       id,
                  //       style: Style().style(24, const Color.fromARGB(255, 131, 255, 135), true),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 10,),
              Center(
                child: DropdownButton(
                  isExpanded: false,
                  items:[
                    DropdownMenuItem<String>(value:S.of(context).selectStage,child:Text(
                      S.of(context).selectStage,
                      style: Style().style(20,Colors.indigo,true),
                    ),),
                    DropdownMenuItem<String>(value:"First Secondry",child:Text(
                      S.of(context).firstsec,
                      style: Style().style(20,Colors.blue[900],true),
                    ),),
                    DropdownMenuItem<String>(value:"Second Secondry", child:Text(
                      S.of(context).secondsec,
                      style: Style().style(20,Colors.blue[900],true),
                    )),
                    DropdownMenuItem<String>(value:"Third Secondry", child:Text(
                      S.of(context).thirdsec,
                      style: Style().style(20,Colors.blue[900],true),
                    ))
                  ],
                  onChanged: (value)async{
                    setState((){
                      stage = value as String;
                    });
                    String id2 = await SqlCenter().getNextId(value as String);
                    setState(() {
                      id = id2;
                    });
                    buildDropDown();
                  },
                  value: stage,
                  icon: const Icon(Icons.arrow_downward),
                ),
              ),
              TextField(
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.grey)
                  ),
                  labelText: 'Student name',
                  labelStyle: Style().style(18, Colors.grey, true),
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(
                    Icons.person
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      name.clear();
                    },
                  ),
                ),
              ),
              TextField(
                controller: phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.grey)
                  ),
                  labelText: 'Student Phone',
                  labelStyle: Style().style(18, Colors.grey, true),
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(
                    Icons.phone
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      phone.clear();
                    },
                  ),
                ),
              ),
              TextField(
                controller: parrentPhone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.grey)
                  ),
                  labelText: 'Student Parrent Phone',
                  labelStyle: Style().style(18, Colors.grey, true),
                  contentPadding: const EdgeInsets.all(10),
                  prefixIcon: const Icon(
                    Icons.phone
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      parrentPhone.clear();
                    },
                  ),
                ),
              ),
              const Divider(color: Colors.grey,thickness: 2,height: 2,),
              const SizedBox(height: 60,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: DropdownButton(
                      isExpanded: false,
                      items:[
                        DropdownMenuItem<String>(value:"Center", child:Text(
                          "Center",
                          style: Style().style(20,Colors.blue[900],true),
                        )),
                        DropdownMenuItem<String>(value:"Online", child:Text(
                          S.of(context).online,
                          style: Style().style(20,Colors.blue[900],true),
                        ))
                      ],
                      onChanged: (value)async{
                        setState((){
                          selectedState = value as String;
                        });
                        buildDropDown();
                      },
                      value: selectedState,
                      icon: const Icon(Icons.arrow_downward),
                    ),
                  ),
                  const SizedBox(height: 60,),
                  selectedState=="Center"?Center(
                    child: DropdownButton(
                      value: selectedBranch,
                      items: dropdownMenuItems,
                      onChanged: (value)async{
                        // print(value);
                        if (value != "Select") {
                          setState(() {
                            selectedBranch = value as String;
                          });
                        }
                      }
                    ),
                  ):const SizedBox(height: 60,),
                  // TextButton.icon(
                  //   onPressed: (){
                  //     setState(() {
                  //       if (gender == "Male"){
                  //         gender = "Female";
                  //       }else{
                  //         gender="Male";
                  //       }
                  //     });
                  //   },
                  //   icon: Icon(
                  //     gender=="Male"? Icons.male: Icons.female,
                  //     color: gender == "Male"?Colors.blue:Colors.pink,
                  //   ),
                  //   label: Text(
                  //     gender,
                  //     style: Style().style(
                  //       20,
                  //       gender == "Male"?Colors.blue:Colors.pink,
                  //       false,
                  //     ),
                  //   )
                  // ),
                ],
              ),
              const SizedBox(height: 40,),
              TextButton(
                style: Style().buttonStyle(Colors.blue, Colors.blue[900], 18),
                onPressed: ()async{
                  if(loading == false){
                    setState(() {
                      loading= true;
                    });
                    if (name.text.isNotEmpty) {
                      if (phone.text.isNotEmpty) {
                        if (parrentPhone.text.isNotEmpty) {
                          if (stage != S.of(context).selectStage) {
                            String message = await SqlCenter().check_register(phone.text, parrentPhone.text);
                            // print(message);
                            if (message == "Not Phisher") {
                              String message  = await SqlCenter().register(name.text, phone.text, parrentPhone.text, stage, selectedBranch.replaceAll("Select", "Online"),selectedState);
                              showDialog(context: context, builder: (context)=>AlertDialog(content: Text(S.of(context).successRegisterSentence(message),style: Style().style(25, Colors.green, true),),));
                            } else {
                              showDialog(context: context, builder: (context)=>AlertDialog(content: Text(S.of(context).failedRegisterSentence(message),style: Style().style(25, Colors.red, true),),));
                            }
                          } else {
                            showDialog(context: context,builder: (context)=> AlertDialog(content: Text(S.of(context).selectStage,),));
                          }
                        } else {
                          showDialog(context: context,builder: (context)=>AlertDialog(content: Text(S.of(context).fillpp),));
                        }
                      } else {
                        showDialog(context: context,builder: (context)=>AlertDialog(content: Text(S.of(context).fillphone),));
                      }
                    } else {
                      showDialog(context: context,builder: (context)=>AlertDialog(content: Text(S.of(context).fill1name),));
                    }
                    setState(() {
                      loading = false;
                    });
                    setState(() {
                      name.clear();
                      phone.clear();
                      parrentPhone.clear();
                      stage = S.of(context).selectStage;
                      id="";
                    });
                  }
                },
                child:!loading? Text(
                  S.of(context).createAcc,
                  style: Style().style(20, Colors.white, true),
                ): const CircularProgressIndicator(color: Colors.white,),
              ),    
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  style: Style().buttonStyle(Colors.blue, Colors.blue[900], 20),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )
                  ),
                  
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}