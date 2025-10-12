import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
class Variables{
  late BuildContext attendantsContext;
  // String ip = "http://localhost/php/prototype/system_backend/";
  // String ip = "http://ahmedabdelmoniem.atwebpages.com/system_backend/";
  String ip = "http://ahmedmohamed.serv00.net/system_backend/";
  Box attendedBox = Hive.box("Attended");
  Box blockedBox = Hive.box("Blocked");
  Box expectedBox = Hive.box("Expected");
  Box manuallyAddedBox = Hive.box("ManuallyAdded");
  Box blockedFromAttend = Hive.box("BlockedFromAttend");
  Box worksession = Hive.box("worksession");
  Box homeworkBox = Hive.box("homework");
  Map prepairMessages(){
    Map messages = {};
    for (Map student in expectedBox.values) {
      String id = student['id'].toString();
      String attendance = attendedBox.keys.contains(id)?"حضر":"لم يحضر";
      String mark = "";
      String homework =homeworkBox.keys.contains(id)? "قام بعمل الواجب":"لم يقوم بعمل الواجب";
      String name = student['name'];
      String parent = student['parentphone'];
      String phone = student['phone'];
      if(worksession.getAt(0).mark.length !=0){
        mark = worksession.getAt(0).mark[phone]??"0";
        String message = """Mr Abdul-Aziz Tammam Team❤️
السلام عليكم ولي امر الطالب / $name
الحضور $name النهاردة : $attendance 
الواجب : $homework
درجة الامتحان :$mark""";
        messages.addAll({parent.toString().replaceAll("+2", ""):message});
      }else{
        String message = """Mr Abdul-Aziz Tammam Team❤️
السلام عليكم ولي امر الطالب / $name
الحضور $name النهاردة : $attendance 
الواجب : $homework""";
        messages.addAll({parent.toString().replaceAll("+2", ""):message});
      }
    }
    return messages;
  }
}