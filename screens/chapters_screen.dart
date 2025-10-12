import 'package:attendants/classes/sql_center.dart';
import 'package:attendants/classes/style.dart';
import 'package:attendants/screens/sessions_screen.dart';
import 'package:flutter/material.dart';
class ChaptersScreen extends StatefulWidget {
  const ChaptersScreen({super.key, required this.chapters});
  final List chapters;
  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}
class _ChaptersScreenState extends State<ChaptersScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (MediaQuery.of(context).size.width / 400).toInt()>0?(MediaQuery.of(context).size.width / 400).toInt():1),
      itemCount: widget.chapters.length,
      shrinkWrap: true,
      itemBuilder: (context,index){
        bool loading = false;
        return StatefulBuilder(
          builder:(context,setState2) => TextButton(
            onPressed: ()async{
              if(!loading){
                setState2(() {
                  loading = true;
                });
                List sessions = await SqlCenter().getSessionsnew(widget.chapters.elementAt(index));
                Navigator.push(context,MaterialPageRoute(builder: (context)=>SessionsScreen(isscientific: widget.chapters[index]['isscientific'],sessions:sessions,chpname:widget.chapters.elementAt(index)['name'])));
                setState2((){
                  loading=false;
                });
              }
            },
            child: !loading?
            Container(
              padding : const EdgeInsets.all(20),
              margin:const EdgeInsets.all(10),
              width: 400,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(
                  widget.chapters.elementAt(index)['image'],
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
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.chapters.elementAt(index)['name'],
                          style: Style().style(20,Colors.white,true),
                        ),
                      ),
                      const SizedBox()
                    ],
                  ),
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.chapters.elementAt(index)['isscientific'].toString().replaceAll("true", "علمي").toString().replaceAll("false", "أدبي"),
                          style: Style().style(20,Colors.white,true),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 7,),
                ]
              )
            ):
            CircularProgressIndicator(color: Colors.blue,)
          ),
        );
      },
    );
  }
}