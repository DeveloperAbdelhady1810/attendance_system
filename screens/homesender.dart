import 'dart:convert';
import 'dart:io';
import 'package:attendants/classes/session.dart';
import 'package:attendants/classes/style.dart';
import 'package:excel/excel.dart' as excell;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.session}) : super(key: key);
  final Session session;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
TextEditingController fileController = TextEditingController();
TextEditingController messageController = TextEditingController();
TextEditingController messageIndexController = TextEditingController();
TextEditingController rowIndexController = TextEditingController();
TextEditingController urlController = TextEditingController();
bool started = false;
bool finished = false;
int counter = 0;
int successCounter = 0;
int failedCounter = 0;
int percentage = 0;
Map<String,String> report = {};
bool dynamicMessage = false;
class _MyHomePageState extends State<MyHomePage> {
  exportToExcel()async{
    // print(codes.length);
    final excell.Excel excel = excell.Excel.createExcel();
    excell.Sheet sheet = excel['Sheet1'];

    // Set the column widths
    sheet.setColumnWidth(1, 20);
    sheet.setColumnWidth(2, 30);

    // Set the header row
    sheet.cell(excell.CellIndex.indexByString('A1')).value = 'Number';
    sheet.cell(excell.CellIndex.indexByString('B1')).value = 'State';

    int rowIndex = 2;
    
    for (var i =0;i<report.length;i++) {
      sheet.cell(excell.CellIndex.indexByString('A$rowIndex')).value = report.keys.toList()[i];
      sheet.cell(excell.CellIndex.indexByString('B$rowIndex')).value = report.values.toList()[i];
      rowIndex++;
    }

    // Save the Excel file
    const String excelFile = 'report.xlsx';
    List<int>? fileBytes = excel.save();
    if (fileBytes!=null) {
      File(
        excelFile
      )..createSync()
      ..writeAsBytesSync(fileBytes);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('report.xlsx created successfully')));
    } else {
      
    }
    
  }
  send()async{
    String message = "";
    // String file = fileController.text;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    Map<String,Map<String,String>> phones= {};
    try {
      var bytes = File('${widget.session.name} ${widget.session.branch} ${widget.session.stage}.xlsx').readAsBytesSync();
      var excel = excell.Excel.decodeBytes(bytes);
      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          // print("${row[0]!.value.toString().}");
          if (row[9]!.value.toString() == "Male") {
            if (row[8]!.value.toString() == "true") {
              if (row[5]!.value.toString() == "true") {
                message = '''*Mr.Abdul-Aziz Tammam Team ♥️* 
.
السلام عليكم
ولي أمر الطالب / ${row[7]!.value}
حبينا نبلغ حضرتك بحضور ${row[7]!.value.toString().split(" ")[0]} الحصة النهاردة بتاريخ $formattedDate وقام بعمل الواجب ودرجة امتحانه هي  ${row[1]!.value}🤍''';
                // message = "السلام عليكم ولي أمر الطالب ${row[7]!.value.toString().split(" ")[0]} لقد حضر الطالب وقام بعمل الواجب ودرجة امتحانه هي ${row[1]!.value}";
                if(int.tryParse(row[6]!.value.toString().replaceAll("+", "").replaceAll(" ","").replaceAll("`", "")) != null){
                  String number = row[6]!.value.toString().replaceAll(" ", "").replaceAll("`", "");
                  if(number[0] == "+"){
                    phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
                  }else if(number[0] == "0"){
                    phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
                  }else if(number[0] == "2" ){
                    phones.addAll({row[7]!.value.toString():{row[6]!.value.toString().replaceAll(" ",""):message}});
                  }else if(number[0] == "1"){
                    phones.addAll({row[7]!.value.toString():{"20${row[6]!.value.toString().replaceAll(" ","")}":message}});
                  }
                }
              }else{
                message = '''*Mr.Abdul-Aziz Tammam Team ♥️* 
.
السلام عليكم
ولي أمر الطالب / ${row[7]!.value}
حبينا نبلغ حضرتك بحضور ${row[7]!.value.toString().split(" ")[0]} الحصة النهاردة بتاريخ $formattedDate ولم يقم بعمل الواجب ودرجة امتحانه هي  ${row[1]!.value}🤍''';
                // message = "السلام عليكم ولي أمر الطالب ${row[7]!.value.toString().split(" ")[0]} لقد حضر الطالب ولم يقم بعمل الواجب ودرجة امتحانه هي ${row[1]!.value}";
                if(int.tryParse(row[6]!.value.toString().replaceAll("+", "").replaceAll(" ","").replaceAll("`", "")) != null){
                  String number = row[6]!.value.toString().replaceAll(" ", "").replaceAll("`", "");
                  if(number[0] == "+"){
                    phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
                  }else if(number[0] == "0"){
                    phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
                  }else if(number[0] == "2" ){
                    phones.addAll({row[7]!.value.toString():{row[6]!.value.toString().replaceAll(" ",""):message}});
                  }else if(number[0] == "1"){
                    phones.addAll({row[7]!.value.toString():{"20${row[6]!.value.toString().replaceAll(" ","")}":message}});
                  }
                }
              }
            } else {
              // message = "السلام عليكم ولي امر الطالب ${row[7]!.value.toString().split(" ")[0]} نريد أن نحيط سيادتكم علما بعدم حضور الطالب حصة اليوم";
              if(row[10]!.value.toString() == "Online"){

              }else{
                message = '''*Mr.Abdul-Aziz Tammam Team ♥️* 
.
السلام عليكم
ولي أمر الطالب / ${row[7]!.value}
حبينا نبلغ حضرتك بعدم حضور ${row[7]!.value.toString().split(" ")[0]} الحصة النهاردة بتاريخ $formattedDate 🤍 
يرجى التواصل معنا لإبلاغكم بمعاد التعويض''';
                if(int.tryParse(row[6]!.value.toString().replaceAll("+", "").replaceAll(" ","").replaceAll("`", "")) != null){
                  String number = row[6]!.value.toString().replaceAll(" ", "").replaceAll("`", "");
                  if(number[0] == "+"){
                    phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
                  }else if(number[0] == "0"){
                    phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
                  }else if(number[0] == "2" ){
                    phones.addAll({row[7]!.value.toString():{row[6]!.value.toString().replaceAll(" ",""):message}});
                  }else if(number[0] == "1"){
                    phones.addAll({row[7]!.value.toString():{"20${row[6]!.value.toString().replaceAll(" ","")}":message}});
                  }
                }
              }
            }
          } else {
            if (row[8]!.value.toString() == "true") {
              if (row[5]!.value.toString() == "true") {
                // message = "السلام عليكم ولي أمر الطالبة ${row[7]!.value.toString().split(" ")[0]} لقد حضرت الطالبة وقامت بعمل الواجب ودرجة امتحانها هي ${row[1]!.value}";
                message = '''*Mr.Abdul-Aziz Tammam Team ♥️* 
.
السلام عليكم
ولي أمر الطالبة / ${row[7]!.value}
حبينا نبلغ حضرتك بحضور ${row[7]!.value.toString().split(" ")[0]} الحصة النهاردة بتاريخ $formattedDate وقامت بعمل الواجب ودرجة امتحانها هي ${row[1]!.value}🤍''';
                if(int.tryParse(row[6]!.value.toString().replaceAll("+", "").replaceAll(" ","").replaceAll("`", "")) != null){
                  String number = row[6]!.value.toString().replaceAll(" ", "").replaceAll("`", "");
                  if(number[0] == "+"){
                    phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
                  }else if(number[0] == "0"){
                    phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
                  }else if(number[0] == "2" ){
                    phones.addAll({row[7]!.value.toString():{row[6]!.value.toString().replaceAll(" ",""):message}});
                  }else if(number[0] == "1"){
                    phones.addAll({row[7]!.value.toString():{"20${row[6]!.value.toString().replaceAll(" ","")}":message}});
                  }
                }
              }else{
                // message = "السلام عليكم ولي أمر الطالبة ${row[7]!.value.toString().split(" ")[0]} لقد حضرت الطالبة ولم تقوم بعمل الواجب ودرجة امتحانها هي ${row[1]!.value}";
                message = '''*Mr.Abdul-Aziz Tammam Team ♥️*
.
السلام عليكم
ولي أمر الطالبة / ${row[7]!.value}
حبينا نبلغ حضرتك بحضور ${row[7]!.value.toString().split(" ")[0]} الحصة النهاردة بتاريخ $formattedDate ولم تقم بعمل الواجب ودرجة امتحانها هي ${row[1]!.value}🤍''';
                if(int.tryParse(row[6]!.value.toString().replaceAll("+", "").replaceAll(" ","").replaceAll("`", "")) != null){
                  String number = row[6]!.value.toString().replaceAll(" ", "").replaceAll("`", "");
                  if(number[0] == "+"){
                    phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
                  }else if(number[0] == "0"){
                    phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
                  }else if(number[0] == "2" ){
                    phones.addAll({row[7]!.value.toString():{row[6]!.value.toString().replaceAll(" ",""):message}});
                  }else if(number[0] == "1"){
                    phones.addAll({row[7]!.value.toString():{"20${row[6]!.value.toString().replaceAll(" ","")}":message}});
                  }
                }
              }
            } else {
              if (row[10]!.value.toString() == "Online") {
                
              } else {
                message = '''*Mr.Abdul-Aziz Tammam Team ♥️* 
.
السلام عليكم
ولي أمر الطالبة / ${row[7]!.value}
حبينا نبلغ حضرتك بعدم حضور ${row[7]!.value.toString().split(" ")[0]} الحصة النهاردة بتاريخ $formattedDate 🤍 
يرجى التواصل معنا لإبلاغكم بمعاد التعويض''';
                if(int.tryParse(row[6]!.value.toString().replaceAll("+", "").replaceAll(" ","").replaceAll("`", "")) != null){
                  String number = row[6]!.value.toString().replaceAll(" ", "").replaceAll("`", "");
                  if(number[0] == "+"){
                    phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
                  }else if(number[0] == "0"){
                    phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
                  }else if(number[0] == "2" ){
                    phones.addAll({row[7]!.value.toString():{row[6]!.value.toString().replaceAll(" ",""):message}});
                  }else if(number[0] == "1"){
                    phones.addAll({row[7]!.value.toString():{"20${row[6]!.value.toString().replaceAll(" ","")}":message}});
                  }
                }
              }
              // message = "السلام عليكم ولي امر الطالبة ${row[7]!.value.toString().split(" ")[0]} نريد أن نحيط سيادتكم علما بعدم حضور الطالبة حصة اليوم";
            }
          }
          // print(phones.length);
          // print(phones.keys);
          // if(int.tryParse(row[6]!.value.toString().replaceAll("+", "").replaceAll(" ","").replaceAll("`", "")) != null){
          //   String number = row[6]!.value.toString().replaceAll(" ", "").replaceAll("`", "");
          //   if(number[0] == "+"){
          //     phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
          //   }else if(number[0] == "0"){
          //     phones.addAll({row[7]!.value.toString():{'2${row[6]!.value.toString().replaceAll("+2", "").replaceAll(" ","")}':message}});
          //   }else if(number[0] == "2" ){
          //     phones.addAll({row[7]!.value.toString():{row[6]!.value.toString().replaceAll(" ",""):message}});
          //   }else if(number[0] == "1"){
          //     phones.addAll({row[7]!.value.toString():{"20${row[6]!.value.toString().replaceAll(" ","")}":message}});
          //   }
          // }
          // print("phones : ${phones}");
        }
      }
      // print("phones : ${phones}");
      // print(phones.length);
    }on FileSystemException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('File Not Found')));
    }
    setState(() {
      counter = phones.length;
      started = true;
    });
    int finishedCount = 0;
    File settingsFile = File("whatsapp-settings.txt");
    String settings = await settingsFile.readAsString();
    if(settings.isEmpty){
    }else{
      List<String> settingsList = settings.split("QuadroEncoding");
      String mode = settingsList[0];
      if(mode == "1"){
        File apiFile = File("a.txt");
        File instanceFile = File("i.txt");
        String api = await apiFile.readAsString();
        String instance = await instanceFile.readAsString();
        for (var name in phones.keys) {
          // {"Ahmed":{"201092995540":"Hi, Ahmed"}}
          // print(phone);
          // print(phones[phone]);
          http.Response response = await http.get(
            Uri.parse(
              "https://app.whatzapi.com/api/send-text.php?number=${phones[name]!.keys.first}&msg=${phones[name]!.values.first}&apikey=$api&instance=$instance"
            )
          );
          //print("https://app.whatzapi.com/api/send-text.php?number=$phone&msg=$message&apikey=$api&instance=$instance");
          if (response.statusCode == 200) {
            var responseText = response.body;
            var jsondata = json.decode(responseText.toString().replaceAll("<br>", ""));
            //print(jsondata);
            if (jsondata['message']=="Message sent") {
              setState(() {
                report.addAll({
                  phones[name]!.keys.first: "Message sent",
                });
                successCounter++;
                finishedCount++;
              });
            } else {
              setState(() {
                report.addAll({
                  phones[name]!.keys.first: "Message failed",
                });
                failedCounter++;
                finishedCount++;
              });
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Internet Connection Error')));
          }
          setState(() {
            percentage = (finishedCount/phones.length*100).toInt();
          });
          if (finishedCount == phones.length) {
            setState(() {
              finished = true;
            });
          }
          await Future.delayed(const Duration(seconds: 5));
        }
      }else{
        // 2QuadroEncoding"+"https://api.maytapi.com/api/"+str(productid)+"/"+str(phoneid)+"/sendMessageQuadroEncoding"+api
        String baseUrl = settingsList[1];
        String api = settingsList[2];
        for (var phone in phones.keys) {
          // print(phone);
          // print(phones[phone]);
          http.Response response = await http.post(
            Uri.parse(
              baseUrl,
            ),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/json",
              "x-maytapi-key":api
            },
            body: jsonEncode({
              "to_number": "${phone.toString()}@c.us",
              "type": "text",
              "message": phones[phone].toString(),
              "typing": "typing",
              "duration": 3
            })
          );
          //print("https://app.whatzapi.com/api/send-text.php?number=$phone&msg=$message&apikey=$api&instance=$instance");
          if (response.statusCode == 200) {
            var responseText = response.body;
            var jsondata = json.decode(responseText.toString().replaceAll("<br>", ""));
            //print(jsondata);
            if (jsondata['success'].toString()=="True") {
              setState(() {
                report.addAll({
                  phone: "Message sent",
                });
                successCounter++;
                finishedCount++;
              });
            } else {
              setState(() {
                report.addAll({
                  phone: "Message failed",
                });
                failedCounter++;
                finishedCount++;
              });
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Internet Connection Error')));
          }
          setState(() {
            percentage = (finishedCount/phones.length*100).toInt();
          });
          if (finishedCount == phones.length) {
            setState(() {
              finished = true;
            });
          }
          await Future.delayed(const Duration(seconds: 5));
        }
      }
    }
    
  }
  @override
  void initState() {
    started = true;
    send();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: !started? Colors.green:Colors.blue,width: 2),
            top: BorderSide(color: !started? Colors.green:Colors.blue,width: 2),
            left: BorderSide(color: !started? Colors.green:Colors.blue,width: 2),
            right: BorderSide(color: !started? Colors.green:Colors.blue,width: 2),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20))
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children:[
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Quadro Whatsapp Sender",
                    style: Style().style(30,Colors.blue,true),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Phones Counted: ",
                    style: Style().style(25, Colors.blue, true)
                  ),
                  Text(
                    "$counter",
                    style: Style().style(25, Colors.blue, true)
                  ),
                ]
              ),
              Center(
                child: Text(
                  "Percentage: $percentage %",
                  style: Style().style(25,!finished? Colors.black:Colors.green, !finished? false:true),
                )
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Success: ",
                    style: Style().style(25, Colors.green, true)
                  ),
                  Text(
                    "$successCounter",
                    style: Style().style(25, Colors.green, true)
                  ),
                ]
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Failed: ",
                    style: Style().style(25, Colors.red, true)
                  ),
                  Text(
                    "$failedCounter",
                    style: Style().style(25, Colors.red, true)
                  ),
                ]
              ),
              const SizedBox(height: 20,),
              finished?Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: ()async{
                      await exportToExcel();
                    },
                    style:Style().buttonStyle(Colors.green,const Color.fromARGB(255, 0, 111, 4),20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Export Report",
                        style: Style().style(25, Colors.white, true),
                      ),
                    ),
                  ),
                )
              )
              :
              const SizedBox(),
              const Spacer(),
              TextButton(
                onPressed: ()async{
                  setState((){
                    finished = false;
                    started= false;
                    counter= 0 ;
                    failedCounter= 0 ;
                    successCounter= 0 ;
                    percentage = 0;
                  });
                  // Navigator.pop(context);
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const MyHomePage()));
                  await Process.run("close.bat", []);
                },
                style:Style().buttonStyle(Colors.green,const Color.fromARGB(255, 0, 111, 4),20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Stop and Restart",
                    style: Style().style(25, Colors.white, true),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}