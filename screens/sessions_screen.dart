import 'package:attendants/classes/session.dart';
import 'package:attendants/classes/style.dart';
import 'new_attendance_screen.dart';
import 'package:flutter/material.dart';
class SessionsScreen extends StatefulWidget {
  const SessionsScreen({super.key, required this.sessions, required this.isscientific, required this.chpname});
  final List sessions;
  final String isscientific;
  final String chpname;
  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}
class _SessionsScreenState extends State<SessionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sessions'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (MediaQuery.of(context).size.width/400).toInt()>0?(MediaQuery.of(context).size.width/400).toInt():1),
        itemCount: widget.sessions.length,
        itemBuilder: (context,index){
          return TextButton(
            onPressed: ()async{
              Session session = Session(
                sessionId: widget.sessions.elementAt(index)['id'].toString(),
                weekday: "",
                stage: widget.sessions.elementAt(index)['chpstage'],
                branch: "",
                attendants: [],
                name: widget.sessions.elementAt(index)['name'],
                mark: {},
                time: "",
                isscientific: widget.isscientific.toString(),
                chpname: widget.chpname,
              );
              // Navigator.push(context, MaterialPageRoute(builder: (context)=>Attendants(session: session, isworksession: false)));
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NewAttendanceScreen(chpname: widget.chpname,session:session,isworksession: false,)));
            },
            child: Container(
              padding : const EdgeInsets.all(20),
              margin:const EdgeInsets.all(10),
              width: 400,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(
                  widget.sessions.elementAt(index)['image'],
                )
                ,
                fit: BoxFit.cover),
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Wrap(
                        children:[
                          Text(
                            widget.sessions.elementAt(index)['name'],
                            style: Style().style(20,Colors.white,true),
                          ),
                        ]
                      ),
                    ),
                      
                  ),
                  // Row(
                  //   mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     const SizedBox(),
                  //     Container(
                  //       padding: const EdgeInsets.all(8),
                  //       decoration: BoxDecoration(
                  //         color: Colors.black,
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       child: Text(
                  //         widget.sessions.elementAt(index)['isscientific'].toString().replaceAll("true", "علمي").toString().replaceAll("false", "أدبي"),
                  //         style: Style().style(20,Colors.white,true),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  const SizedBox(height: 7,),
                ]
              )
            )
          );
        }
      ),
    );
  }
}