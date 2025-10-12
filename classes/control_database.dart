import 'package:attendants/classes/session.dart';
import 'package:attendants/classes/user.dart';
import 'package:attendants/classes/variables.dart';
import 'package:hive/hive.dart';
class Control {
  addStudent({required Box box,required Map student})async{
    await box.put(student['id'].toString(),student);
  }
  getAllStudents({required Box box}){
    Map students = {};
    for (Map student in box.values) {
      students.addAll({student['id'].toString():student});
    }
    return students;
  }
  // getStudent({required Box box,required String studentEmail})async{
  //   final Student student = box.get(studentEmail);
  //   return student;
  // }
  deleteStudent({required Box box,required String studentid})async{
    await box.delete(studentid);
  }
  deleteAll({required Box box})async{
    await box.deleteAll(box.keys);
  }
  insertWorksession({required Session session})async{
    await Variables().worksession.clear();
    await Variables().worksession.add(session);
  }
  homeworkmanagment({required Map student})async{
    if (Variables().homeworkBox.get(student['id'].toString())!=null) {
      await Variables().homeworkBox.delete(student['id'].toString());
    } else {
      await Variables().homeworkBox.put(student['id'].toString(),student);
    }
    
  }
}