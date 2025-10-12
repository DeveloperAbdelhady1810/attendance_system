import 'dart:io';
import 'package:attendants/classes/session.dart';
import 'package:attendants/classes/variables.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
class Export {
  exportStudents(List<Map<String,dynamic>> students)async{
    final Excel excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];
    sheet.setColumnWidth(1, 30);
    sheet.setColumnWidth(2, 30);
    sheet.setColumnWidth(3, 30);
    sheet.setColumnWidth(4, 30);
    sheet.setColumnWidth(5, 30);
    sheet.setColumnWidth(6, 30);
    sheet.setColumnWidth(7, 30);
    sheet.setColumnWidth(8, 30);
    sheet.setColumnWidth(9, 30);
    sheet.cell(CellIndex.indexByString('A1')).value = 'ID';
    sheet.cell(CellIndex.indexByString('B1')).value = 'Name';
    sheet.cell(CellIndex.indexByString('C1')).value = 'Center';
    sheet.cell(CellIndex.indexByString('D1')).value = 'Stage';
    sheet.cell(CellIndex.indexByString('E1')).value = 'Phone';
    sheet.cell(CellIndex.indexByString('F1')).value = 'Parrent Phone';
    sheet.cell(CellIndex.indexByString('G1')).value = 'State';
    sheet.cell(CellIndex.indexByString('H1')).value = 'isscientific';
    sheet.cell(CellIndex.indexByString('I1')).value = 'Password';
    sheet.cell(CellIndex.indexByString('J1')).value = 'Balance';
    int rowIndex = 2;
    for (var i =0;i<students.length;i++) {
      Map currentStudent = students[i];
      sheet.cell(CellIndex.indexByString('A$rowIndex')).value = currentStudent['id'];
      sheet.cell(CellIndex.indexByString('B$rowIndex')).value = currentStudent['name'];
      sheet.cell(CellIndex.indexByString('C$rowIndex')).value = currentStudent['center'];
      sheet.cell(CellIndex.indexByString('D$rowIndex')).value = currentStudent['stage'];
      sheet.cell(CellIndex.indexByString('E$rowIndex')).value = currentStudent['phone'];
      sheet.cell(CellIndex.indexByString('F$rowIndex')).value = currentStudent['parentphone'];
      sheet.cell(CellIndex.indexByString('G$rowIndex')).value = currentStudent['state'];
      sheet.cell(CellIndex.indexByString('H$rowIndex')).value = currentStudent['isscientific'];
      sheet.cell(CellIndex.indexByString('I$rowIndex')).value = currentStudent['password'];
      sheet.cell(CellIndex.indexByString('J$rowIndex')).value = currentStudent['balance'];
      rowIndex ++;
    }
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("dd-MM-yyyy").format(now);
    String excelFile = 'Students Until ($formattedDate).xlsx';
      List<int>? fileBytes = excel.save();
      if (fileBytes!=null) {
        File(
          excelFile
        )..createSync()
        ..writeAsBytesSync(fileBytes);
      }
      return "success";
  }
  exportToExcel(List codes,String price)async{
    // print(codes.length);
    final Excel excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // Set the column widths
    sheet.setColumnWidth(1, 20);
    sheet.setColumnWidth(2, 30);

    // Set the header row
    sheet.cell(CellIndex.indexByString('A1')).value = 'Number';
    sheet.cell(CellIndex.indexByString('B1')).value = 'Code';
    sheet.cell(CellIndex.indexByString('C1')).value = 'Price';

    int rowIndex = 2;
    
    for (var i =0;i<codes.length;i++) {
      sheet.cell(CellIndex.indexByString('A$rowIndex')).value = i+1;
      sheet.cell(CellIndex.indexByString('B$rowIndex')).value = codes[i];
      sheet.cell(CellIndex.indexByString('C$rowIndex')).value = price;
      rowIndex++;
    }

    // Save the Excel file
    String excelFile = 'codes_${codes.length}_$price.xlsx';
    List<int>? fileBytes = excel.save();
    if (fileBytes!=null) {
      File(
        excelFile
      )..createSync()
      ..writeAsBytesSync(fileBytes);
    } else {
      
    }
    
  }
  exportToCsv(List<Map<String,String>> list)async{
    // print(list);
    try {  
      final Excel excel = Excel.createExcel();
      Sheet sheet = excel['Sheet1'];

      // Set the column widths
      sheet.setColumnWidth(1, 20);
      sheet.setColumnWidth(2, 30);
      int rowIndex = 1;
      
      for (var i =0;i<list.length;i++) {
        sheet.cell(CellIndex.indexByString('A$rowIndex')).value = list[i].keys.elementAt(0);
        sheet.cell(CellIndex.indexByString('B$rowIndex')).value = list[i].values.elementAt(0);
        rowIndex++;
      }
      const String excelFile = 'contacts.xlsx';
      List<int>? fileBytes = excel.save();
      if (fileBytes!=null) {
        File(
          excelFile
        )..createSync()
        ..writeAsBytesSync(fileBytes);
      }
      return "success";
    } catch (e) {
      print(e);
      return "failed";
    }
  }
  exportAttendants2({required Session session})async{
    final Excel excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];
    // print(session.mark);
    session.attendants.remove("");
    sheet.cell(CellIndex.indexByString('A1')).value = 'ID';
    sheet.cell(CellIndex.indexByString('B1')).value = 'Mark';
    sheet.cell(CellIndex.indexByString('C1')).value = 'Center';
    sheet.cell(CellIndex.indexByString('D1')).value = 'Stage';
    sheet.cell(CellIndex.indexByString('E1')).value = 'Homework';
    sheet.cell(CellIndex.indexByString('F1')).value = 'Parrent';
    sheet.cell(CellIndex.indexByString('G1')).value = 'Name';
    sheet.cell(CellIndex.indexByString('H1')).value = 'Attended';
    sheet.cell(CellIndex.indexByString('I1')).value = 'State';
    sheet.cell(CellIndex.indexByString('J1')).value = 'Phone';
    int rowIndex = 2;
    // Set the column widths
    sheet.setColumnWidth(1, 20);
    sheet.setColumnWidth(2, 30);
    List list = Variables().expectedBox.values.toList();
    for (var i =0;i<list.length;i++) {
      try {
        String id = list[i]['id'].toString();
        if(Variables().attendedBox.keys.toList().contains(id)){}else{
          String mark = session.mark[id]!=null?session.mark[id]!:"0";
          // String homework = Variables().homeworkBox.get(id) != null ? "true": "false";
          String homework = "false";
          sheet.cell(CellIndex.indexByString('A$rowIndex')).value = id;
          sheet.cell(CellIndex.indexByString('B$rowIndex')).value = mark;
          sheet.cell(CellIndex.indexByString('C$rowIndex')).value = list[i]['center'];
          sheet.cell(CellIndex.indexByString('D$rowIndex')).value = session.stage;
          sheet.cell(CellIndex.indexByString('E$rowIndex')).value = homework;
          sheet.cell(CellIndex.indexByString('F$rowIndex')).value = list[i]['parentphone'].toString().replaceAll(" ", "").replaceAll("+2", "");
          sheet.cell(CellIndex.indexByString('G$rowIndex')).value = list[i]['name'];
          // sheet.cell(CellIndex.indexByString('H$rowIndex')).value = Variables().attendedBox.keys.toList().contains(id).toString();
          sheet.cell(CellIndex.indexByString('H$rowIndex')).value = "false";
          sheet.cell(CellIndex.indexByString('I$rowIndex')).value = list[i]['state'];
          sheet.cell(CellIndex.indexByString('J$rowIndex')).value = list[i]['phone'];
          rowIndex++;
        }
      } catch (e) {
        print(e);
      }
    }
    List list2 = Variables().attendedBox.values.toList();
    for (var i =0;i<list2.length;i++) {
      try {
        String id = list2[i]['id'].toString();
        // print(id);
        if(!Variables().attendedBox.keys.toList().contains(id)){}else{
          String mark = session.mark[id]!=null?session.mark[id]!:"0";
          String homework = Variables().homeworkBox.get(id) != null ? "true": "false";
          // String homework = "false";
          sheet.cell(CellIndex.indexByString('A$rowIndex')).value = id;
          sheet.cell(CellIndex.indexByString('B$rowIndex')).value = mark;
          sheet.cell(CellIndex.indexByString('C$rowIndex')).value = list2[i]['center'];
          sheet.cell(CellIndex.indexByString('D$rowIndex')).value = session.stage;
          sheet.cell(CellIndex.indexByString('E$rowIndex')).value = homework;
          sheet.cell(CellIndex.indexByString('F$rowIndex')).value = list2[i]['parentphone'].toString().replaceAll(" ", "").replaceAll("+2", "");
          sheet.cell(CellIndex.indexByString('G$rowIndex')).value = list2[i]['name'];
          // sheet.cell(CellIndex.indexByString('H$rowIndex')).value = Variables().attendedBox.keys.toList().contains(id).toString();
          sheet.cell(CellIndex.indexByString('H$rowIndex')).value = "true";
          sheet.cell(CellIndex.indexByString('I$rowIndex')).value = list2[i]['state'];
          sheet.cell(CellIndex.indexByString('J$rowIndex')).value = list2[i]['phone'];
          rowIndex++;
        }
      } catch (e) {
        print(e);
      }
    }
    String excelFile = '${session.name} ${session.branch} ${session.stage}.xlsx';
    List<int>? fileBytes = excel.save();
    if (fileBytes!=null) {
      File(
        excelFile
      )..createSync()
      ..writeAsBytesSync(fileBytes);
    }
    return "success";
  }
  // exportAttendants({required Session session})async{
  //   final Excel excel = Excel.createExcel();
  //   Sheet sheet = excel['Sheet1'];
  //   // print(session.mark);
  //   session.attendants.remove("");
  //   sheet.cell(CellIndex.indexByString('A1')).value = 'ID';
  //   sheet.cell(CellIndex.indexByString('B1')).value = 'Mark';
  //   sheet.cell(CellIndex.indexByString('C1')).value = 'Center';
  //   sheet.cell(CellIndex.indexByString('D1')).value = 'Stage';
  //   sheet.cell(CellIndex.indexByString('E1')).value = 'Homework';
  //   sheet.cell(CellIndex.indexByString('F1')).value = 'Parrent';
  //   sheet.cell(CellIndex.indexByString('G1')).value = 'Name';
  //   sheet.cell(CellIndex.indexByString('H1')).value = 'Attended';
  //   sheet.cell(CellIndex.indexByString('I1')).value = 'State';
  //   sheet.cell(CellIndex.indexByString('J1')).value = 'Phone';
  //   int rowIndex = 2;
  //   // Set the column widths
  //   sheet.setColumnWidth(1, 20);
  //   sheet.setColumnWidth(2, 30);
  //   List list = session.attendants;
  //   // List list  = Variables().expectedBox.keys.toList();
  //   // list.addAll(Variables().attendedBox.keys);
  //   print(list.length);
  //   for (var i =0;i<list.length;i++) {
  //     try {
  //       String email = list[i];
  //       Variables().expectedBox.delete(email);
  //       print(email);
  //       String mark = session.mark[email]!=null?session.mark[email]!:"0";
  //       String homework = Variables().homeworkBox.get(email) != null ? "true": "false";
  //       sheet.cell(CellIndex.indexByString('A$rowIndex')).value = Variables().expectedBox.get(email)==null
  //       ?
  //       Variables().attendedBox.get(email).cardId
  //       :
  //       Variables().expectedBox.get(email).cardId;
  //       sheet.cell(CellIndex.indexByString('B$rowIndex')).value = mark;
  //       sheet.cell(CellIndex.indexByString('C$rowIndex')).value = Variables().expectedBox.get(email)==null?Variables().attendedBox.get(email).place:Variables().expectedBox.get(email).place;
  //       sheet.cell(CellIndex.indexByString('D$rowIndex')).value = session.stage;
  //       sheet.cell(CellIndex.indexByString('E$rowIndex')).value = session.sessionId;
  //       sheet.cell(CellIndex.indexByString('F$rowIndex')).value = homework;
  //       sheet.cell(CellIndex.indexByString('G$rowIndex')).value = Variables().expectedBox.get(email)!=null?"2${Variables().expectedBox.get(email).parrentPhone.toString().replaceAll(" ", "").replaceAll("+2", "")}":"2${Variables().attendedBox.get(email).parrentPhone.toString().replaceAll(" ", "").replaceAll("+2", "")}";
  //       sheet.cell(CellIndex.indexByString('H$rowIndex')).value = Variables().expectedBox.get(email)!=null?Variables().expectedBox.get(email).firstName + " " + Variables().expectedBox.get(email).lastName:Variables().attendedBox.get(email).firstName + " " + Variables().attendedBox.get(email).lastName;
  //       sheet.cell(CellIndex.indexByString('I$rowIndex')).value = Variables().attendedBox.keys.toList().contains(email).toString();
  //       sheet.cell(CellIndex.indexByString('J$rowIndex')).value = Variables().expectedBox.get(email)!=null?Variables().expectedBox.get(email).gender:Variables().attendedBox.get(email).gender;
  //       sheet.cell(CellIndex.indexByString('K$rowIndex')).value = Variables().expectedBox.get(email)!=null?Variables().expectedBox.get(email).state:Variables().attendedBox.get(email).state;
  //       sheet.cell(CellIndex.indexByString('L$rowIndex')).value = Variables().expectedBox.get(email)!=null?Variables().expectedBox.get(email).phone:Variables().attendedBox.get(email).phone;
  //       rowIndex++;
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  //   List list2 = Variables().expectedBox.keys.toList();
  //   print(list2.length);
  //   for (var i =0;i<list2.length;i++) {
  //     try {
  //       String email = list2[i];
  //       // Variables().expectedBox.delete(email);
  //       print(email);
  //       String mark = session.mark[email]!=null?session.mark[email]!:"0";
  //       String homework = Variables().homeworkBox.get(email) != null ? "true": "false";
  //       sheet.cell(CellIndex.indexByString('A$rowIndex')).value = Variables().expectedBox.get(email)==null?Variables().attendedBox.get(email).cardId:Variables().expectedBox.get(email).cardId;
  //       sheet.cell(CellIndex.indexByString('B$rowIndex')).value = mark;
  //       sheet.cell(CellIndex.indexByString('C$rowIndex')).value = session.branch;
  //       sheet.cell(CellIndex.indexByString('D$rowIndex')).value = session.stage;
  //       sheet.cell(CellIndex.indexByString('E$rowIndex')).value = session.sessionId;
  //       sheet.cell(CellIndex.indexByString('F$rowIndex')).value = homework;
  //       sheet.cell(CellIndex.indexByString('G$rowIndex')).value = Variables().expectedBox.get(email)!=null?"2${Variables().expectedBox.get(email).parrentPhone.toString().replaceAll(" ", "").replaceAll("+2", "")}":"2${Variables().attendedBox.get(email).parrentPhone.toString().replaceAll(" ", "").replaceAll("+2", "")}";
  //       sheet.cell(CellIndex.indexByString('H$rowIndex')).value = Variables().expectedBox.get(email)!=null?Variables().expectedBox.get(email).firstName + " " + Variables().expectedBox.get(email).lastName:Variables().attendedBox.get(email).firstName + " " + Variables().attendedBox.get(email).lastName;
  //       sheet.cell(CellIndex.indexByString('I$rowIndex')).value = Variables().attendedBox.keys.toList().contains(email).toString();
  //       sheet.cell(CellIndex.indexByString('J$rowIndex')).value = Variables().expectedBox.get(email)!=null?Variables().expectedBox.get(email).gender:Variables().attendedBox.get(email).gender;
  //       sheet.cell(CellIndex.indexByString('K$rowIndex')).value = Variables().expectedBox.get(email)!=null?Variables().expectedBox.get(email).state:Variables().attendedBox.get(email).state;
  //       sheet.cell(CellIndex.indexByString('L$rowIndex')).value = Variables().expectedBox.get(email)!=null?Variables().expectedBox.get(email).phone:Variables().attendedBox.get(email).phone;
  //       rowIndex++;
  //     } catch (e) {
  //     }
  //   }
  //   String excelFile = '${session.name} ${session.branch} ${session.stage}.xlsx';
  //   List<int>? fileBytes = excel.save();
  //   if (fileBytes!=null) {
  //     File(
  //       excelFile
  //     )..createSync()
  //     ..writeAsBytesSync(fileBytes);
  //   }
  //   return "success";
  // }
}