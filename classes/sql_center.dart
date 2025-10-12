import 'dart:io';
import 'package:attendants/classes/export.dart';
import 'package:mysql1/mysql1.dart';
// var settings = ConnectionSettings(
//   host: 'sql8.freesqldatabase.com', 
//   port: 3306,
//   user: 'sql8725971',
//   password: 'ZPRktZcvXj',
//   db: 'sql8725971'
// );
class SqlCenter{
  Future<List> getSessionsnew(var chapter)async{
    var settings = await getsettings();
    var conn = await MySqlConnection.connect(settings);
    var query = 'SELECT * FROM sessions WHERE chpstage = ? && chpname = ? ';
    var result = await conn.query(query,[chapter['stage'],chapter['name']]);
    List sessions = [];
    for (var row in result) {
      sessions.add(row.fields);
    }
    return sessions;
  }
  Future<List> getChapters(String stage)async{
    var settings = await getsettings();
    var conn = await MySqlConnection.connect(settings);
    var query = 'SELECT * FROM chapters WHERE stage = ?';
    var result = await conn.query(query,[stage]);
    List chapters = [];
    for (var row in result) {
      chapters.add(row);
    }
    return chapters;
  }
  Future downloadAllStudents(List<String> branches)async{
    List<Map<String,dynamic>> students = [];
    var settings = await getsettings();
    var conn = await MySqlConnection.connect(settings);
    // for (String branchName in branches) {
      // print(branchName);
      String query = "SELECT * FROM students";
      var res = await conn.query(query,);
      if(res.isNotEmpty){
        for (var row in res) {
          students.add(row.fields);
        }
      }
    // }
    return await Export().exportStudents(students);
  }
  Future submitCodes(List codes,String price)async{
    var conn = await MySqlConnection.connect(await getsettings());
    for (String code in codes) {
      var results = await conn.query("INSERT INTO codes(code,price,bought) VALUES(?,?,?)",[code,price,'false']);
    }
    return "Codes Submitted to site";
  }
  Future getsettings()async{
    File hashFile = File("settings.txt");
    String hash = await hashFile.readAsString();
    List settingsList = hash.split("QuadroEncoding");
    return ConnectionSettings(
      // host: "srv1625.hstgr.io", 
      // port: 3306,
      // user: "u694971669_test",
      // password: "AhmedAdminQuadro4",
      host: settingsList[0], 
      port: int.parse(settingsList[1]),
      user: settingsList[2],
      password: settingsList[3],
      db: settingsList[4],
      timeout: const Duration(minutes: 5)
    );
  }
  // Future getBlocked()async{
  //   var conn = await MySqlConnection.connect(await getsettings());
  //   var results = await conn.query("SELECT * FROM blocked",[]);
  //   Map blocked = {};
  //   for (var row in results) {
  //     blocked.addAll({row.fields['id']:row.fields});
  //     // print(row.fields);
  //   }
  //   await conn.close();
  //   return blocked;
  // }
  Future<String> check_register(String phone,String parentphone)async{
    var conn= await MySqlConnection.connect(await getsettings());
    String message = "";
    // print("here");
    if(parentphone != phone){
      var results5 = await conn.query("SELECT * FROM students WHERE parentphone=?",[phone]);
      if(results5.isNotEmpty){
        message = "Phisher :(You Entered The same Phone Number That Another Student Entered It As His Parrent Phone Number)";
      }else{
        message = "Not Phisher";
      }
    }else {
      message = "Phisher :(You Entered The same Phone Number in Parrent Phone and Phone Fields)";
    }
    await conn.close();
    return message;
  }
  Future<String> getNextId(String stage)async{
    // print("SELECT * FROM studentsinfo WHERE stage=$stage && cardid=(SELECT MAX(cardid) FROM studentsinfo)");
    var conn= await MySqlConnection.connect(await getsettings());
    var query = "SELECT * FROM students WHERE stage=? && id=(SELECT MAX(id) FROM students WHERE stage=?)";
    var results = await conn.query(query,[stage.replaceAll("Ahmed", " ").replaceAll("QuadroEncoding", " "),stage.replaceAll("Ahmed", " ").replaceAll("QuadroEncoding", " ")]);
    return (results.first.fields['id']+1).toString();
  }
  Future<String> register(name, phone, parentphone, stage, branch,state)async{
    String message = "";
    var conn = await MySqlConnection.connect(await getsettings());
    // var results99 = await conn.query("SELECT * FROM students WHERE phone=?",[phone]);
    // if(results99.isNotEmpty){
    //   var resilt0 = await conn.query("UPDATE students SET id=? WHERE phone=?",[cardid,phone]);
    //   message = name + " Updated";
    //   return message;
    // }else{
      var result0 = await conn.query("INSERT INTO students(name,phone,parentphone,stage,center,state) VALUES(?,?,?,?,?,?)",[name,phone.toString().replaceAll(" ", ""),parentphone.toString().replaceAll(" ", ""),stage,branch,state]);
      message = result0.insertId.toString();
      return message;
    // }
  }
  // Future<Map<String,Map>> getBranches()async{
  //   Map<String,Map> branchs = {};
  //   var conn = await MySqlConnection.connect(await getsettings());
  //   var results = await conn.query('SELECT * FROM branches ORDER BY id DESC');
  //   for (var row in results) {
  //     branchs.addAll({row['name']:row.fields});
  //   }
  //   await conn.close();
  //   return branchs;
  // }
  Future<String> getQuizId(sessionId)async{
    String quizId = "";
    var conn = await MySqlConnection.connect(await getsettings());
    var results = await conn.query("SELECT * FROM quizesinfo WHERE sessionId = ?",[sessionId]);
    if(results.isNotEmpty){
      quizId = results.first['id'].toString();
    }else{
      quizId = "Not Found";
    }
    await conn.close();
    return quizId;
  }
  Future getAllMarks(sessionname,stage)async{
    var marks={};
    var conn = await MySqlConnection.connect(await getsettings());
    var results = await conn.query('SELECT * FROM marks WHERE sessionname=? && stage=?',[sessionname,stage]);
    if (results.isNotEmpty) {
      for (var row in results) {
        marks.addAll({row['email']:row.fields});
      }
      await conn.close();
      return marks;
    } else {
      await conn.close();
      return "Not Found";
    }
    
  }
  Future getSessions(mode,stage,branch,name)async{
    var finalresult ={};
    var conn = await MySqlConnection.connect(await getsettings());
    if (mode == "3") {
      var results = await conn.query("SELECT * FROM sessions ORDER BY id ASC",[]);
      for (var row in results) {
        finalresult.addAll({row['name']+row['stage']:row.fields});
      }
    } else if(mode == "900"){
      // var results1 = await conn.query("SELECT * FROM sessions WHERE stage=? && branch=? && name = ?  ORDER BY id ASC",[stage,branch,name]);
      var results1 = await conn.query("SELECT * FROM attended WHERE stage=? && branch=? && sessionName = ?  ORDER BY id ASC",[stage,branch,name]);
      print(results1.length);
      print("SELECT * FROM attended WHERE stage=$stage && branch=$branch && sessionName = $name  ORDER BY id ASC");
	  // print("SELECT * FROM attended WHERE stage=${stage} && branch=${branch} && sessionName = ${name}  ORDER BY id ASC");
      List attended = [];
      for (var row in results1) {
        attended.add(row.fields['email']);
		// print(row.fields['email']);
        // finalresult.addAll({row['name']+row['stage']:row.fields});
      }
      print(attended);
      finalresult.addAll({"$name$stage":{"attendants":attended.toString()}});
    } else{
      var results2 = await conn.query("SELECT * FROM sessions WHERE stage=? && branch=? ORDER BY id ASC",[stage,branch]);
      for (var row in results2) {
        finalresult.addAll({row['name']+row['stage']:row.fields});
      }
    }
    await conn.close();
    return finalresult;
  }
  Future getStudent(email)async{
    var conn = await MySqlConnection.connect(await getsettings());
    var results = await conn.query("SELECT * FROM studentsinfo WHERE email=?",[email]);
    await conn.close();
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return "Not Found";
    }
  }
  Future getExpectedStudent(stage0,branch,isscientific)async{
    var students ={};
    var conn = await MySqlConnection.connect(await getsettings());
    var results = await conn.query("SELECT * FROM students WHERE stage=? AND (center=? OR center=?) AND (isscientific=? OR isscientific=?)",[stage0,branch,"Online","All",isscientific.toString()]);
    if (results.isNotEmpty) {
      for (var row in results) {
        students.addAll({row['id']:row.fields});
      }
      await conn.close();
      return students;
    } else {
      await conn.close();
      return "No student found in this stage";
    }
    
  }
  Future isSessionFound(sessionName,stage0,branch)async{
    String stage1 = stage0.toString().replaceAll(" ", "QuadroEncoding");
    String stage2 = stage0.toString().replaceAll("QuadroEncoding", " ");
    var conn = await MySqlConnection.connect(await getsettings());
    var results = await conn.query("SELECT * FROM sessions WHERE name=? AND (stage=? OR stage = ?) AND branch=?",[sessionName,stage2,stage1,branch]);
    await conn.close();
    if(results.isNotEmpty){
      return results.first;
    }else{
      return "Not Found";
    }
  }
  Future getStudentsManually(stage0,isscientific,chpname,sessionname,center)async{
    Map students = {};
    var conn = await MySqlConnection.connect(await getsettings());
    var results;
    if(isscientific=="All"){
      results = await conn.query("SELECT * FROM students WHERE stage=? && (isscientific=? OR isscientific=?) && (center=? OR center=?)",[stage0,"true","false",center,"Online"]);
    }else{
      results = await conn.query("SELECT * FROM students WHERE stage=? && isscientific=?",[stage0,isscientific.toString()]);
    }
    // print(results.length+" Student Found in/Stage:$stage0, iiscientific: $isscientific");
    if (results.isNotEmpty) {
      Map allStudents = {};
      for (var row in results) {
        // students.addAll({row['id']:row.fields});
        // print(row['id']);
        allStudents.addAll({row['id']:row.fields});
      }
      students.addAll({"All":allStudents});
    }
    var resultsAttendance = await conn.query("SELECT * FROM attended WHERE chpname=? && chpstage=? && sessionname=?",[chpname,stage0,sessionname]);
    if (resultsAttendance.isNotEmpty) {
      Map attended = {};
      Map marks = {};
      var markResults = await conn.query("SELECT * FROM marks WHERE sessionname=? && chpstage=? && chpname=?",[sessionname,stage0,chpname]);
      if (markResults.isNotEmpty) {
        for (var rowMark in markResults) {
          marks[rowMark['phone']] = rowMark['mark'];
        }
      }
      for (var row2 in resultsAttendance) {
        // students.addAll({row['id']:row.fields});
        attended.addAll({row2['phone']:row2.fields..addAll({"mark":marks[row2['phone']]??"0"})});
      }
      students.addAll({"Attended":attended});
    }
    await conn.close();
    return students.isEmpty?"Not Found":students;
  }
  Future addToAttendants(attendants,sessionName,id,stage,branch)async{
    var conn = await MySqlConnection.connect(await getsettings());
    // var results = await conn.query("UPDATE sessions SET attendants =? WHERE id=? && stage=? && branch=?",[attendants.toString().replaceAll("QuadroEncoding", " "),id.toString().replaceAll("QuadroEncoding", " "),stage.toString().replaceAll("QuadroEncoding", " "),branch.toString().replaceAll("QuadroEncoding", " ")]);
    var results0 = await conn.query("DELETE FROM attended WHERE sessionName=? && sessionId=? && stage=? && branch=?",[sessionName,id,stage,branch]);
    for (var studentEmail in attendants) {
      try{
        var results = await conn.query("INSERT INTO attended(sessionName,sessionId,email,stage,branch) VALUES(?,?,?,?,?)",[sessionName,id,studentEmail,stage,branch]);
      }catch(e){
        print(e);
      }
    }
    
    await conn.close();
    return "Success";
  }
  Future addMark(sessionname,stage,marks)async{
    var conn = await MySqlConnection.connect(await getsettings());
      marks.forEach((key, value) async{
        // print(key + " Got " + value);
        try {
          var results0 = await conn.query("SELECT * FROM marks WHERE email=? && sessionname=? && stage=?",[key,sessionname,stage]);
          if (results0.isNotEmpty) {
            var results1 = await conn.query("UPDATE marks SET mark=? WHERE email = ? && sessionname=? && stage=?",[value,key,sessionname,stage]);
          } else {
            var results1 = await conn.query("INSERT INTO marks(sessionname,stage,email,mark) VALUES(?,?,?,?)",[sessionname,stage,key,value]);
          }
        } catch (e) {
          conn = await MySqlConnection.connect(await getsettings());
          var results0 = await conn.query("SELECT * FROM marks WHERE email=? && sessionname=? && stage=?",[key,sessionname,stage]);
          if (results0.isNotEmpty) {
            var results1 = await conn.query("UPDATE marks SET mark=? WHERE email = ? && sessionname=? && stage=?",[value,key,sessionname,stage]);
          } else {
            var results1 = await conn.query("INSERT INTO marks(sessionname,stage,email,mark) VALUES(?,?,?,?)",[sessionname,stage,key,value]);
          }
        }
        
      });
      print("Done All");
    await conn.close();
    return "Success";
  }
  //
  Future addToAttendants2(List attendants,String sessionName,String chpname,String chpstage,String center)async{
    print(sessionName);
    var conn = await MySqlConnection.connect(await getsettings());
    // var results = await conn.query("UPDATE sessions SET attendants =? WHERE id=? && stage=? && branch=?",[attendants.toString().replaceAll("QuadroEncoding", " "),id.toString().replaceAll("QuadroEncoding", " "),stage.toString().replaceAll("QuadroEncoding", " "),branch.toString().replaceAll("QuadroEncoding", " ")]);
    var results0 = await conn.query("DELETE FROM attended WHERE sessionname=? && chpname=? && chpstage=? && center=?",[sessionName,chpname,chpstage,center]);
    for (Map student in attendants) {
      try{
        var results = await conn.query("INSERT INTO attended(sessionname,chpname,phone,chpstage,center) VALUES(?,?,?,?,?)",[sessionName,chpname,student['phone'],chpstage,center]);
      }catch(e){}
    }
    await conn.close();
    return "Success";
  }

  Future addMarks2(String sessionname,String chpname,String chpstage,Map marks)async{
    var conn = await MySqlConnection.connect(await getsettings());
    marks.forEach((key, value) async{
      try {
        var results0 = await conn.query("SELECT * FROM marks WHERE phone=? && sessionname=? && chpstage=? && chpname=? && state=?",[key,sessionname,chpstage,chpname,'quiz']);
        if (results0.isNotEmpty) {
          var results1 = await conn.query("UPDATE marks SET mark=? WHERE phone = ? && sessionname=? && chpstage=? && chpname=? && state=?",[value.toString().split("/")[0],key,sessionname,chpstage,chpname,'quiz']);
        } else {
          var results1 = await conn.query("INSERT INTO marks(sessionname,phone,chpname,chpstage,mark,state) VALUES(?,?,?,?,?,?)",[sessionname,key,chpname,chpstage,value.toString().split("/")[0],'quiz']);
        }
      } catch (e) {
        print(e);
      }
      
    });
    // print("Done All");
    
    return "Success";
  }
}