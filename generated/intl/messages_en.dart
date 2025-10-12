// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(number) => "Attended Offline ( ${number} )";

  static String m1(number) => "Attended Online ( ${number} )";

  static String m2(number) => "Expected To Attend ( ${number} )";

  static String m3(message) => "Request was failed ${message}";

  static String m4(mark) => "Mark: ${mark}";

  static String m5(parrentphone) => "Parrent Phone : ${parrentphone}";

  static String m6(studentid) => "${studentid}`s Mark";

  static String m7(id) => "Student Id: ${id}";

  static String m8(stdid) => "Request was successful Student Id : ${stdid}";

  static String m9(branch) => "You Are Working in ${branch}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "add2attendants": MessageLookupByLibrary.simpleMessage(
      "Add To Normal Attendants",
    ),
    "addStd": MessageLookupByLibrary.simpleMessage("Add Student"),
    "addStudentsManually": MessageLookupByLibrary.simpleMessage(
      "Add Students Manually",
    ),
    "arrangingquizmarks": MessageLookupByLibrary.simpleMessage(
      "Arranging Quiz Marks",
    ),
    "attendants": m0,
    "attendantsonline": m1,
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "blocked": MessageLookupByLibrary.simpleMessage("Blocked Student!"),
    "blockedFromAttend": MessageLookupByLibrary.simpleMessage(
      "Block From Attend",
    ),
    "blockedSentence": MessageLookupByLibrary.simpleMessage(
      "This user has been blocked by the admin!",
    ),
    "center": MessageLookupByLibrary.simpleMessage("Center :"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "code": MessageLookupByLibrary.simpleMessage("Code :"),
    "createAcc": MessageLookupByLibrary.simpleMessage("Create Student Account"),
    "createCodes": MessageLookupByLibrary.simpleMessage("Create Online Codes"),
    "email": MessageLookupByLibrary.simpleMessage("Email :"),
    "entercodesprice": MessageLookupByLibrary.simpleMessage("Enter Code Price"),
    "enterhowmanycodes": MessageLookupByLibrary.simpleMessage(
      "Enter How Many Codes",
    ),
    "errorInPreparingWhatsappBot": MessageLookupByLibrary.simpleMessage(
      "Error in Preparing Whatsapp Bot",
    ),
    "exitWithoutSaving": MessageLookupByLibrary.simpleMessage(
      "Exit Without Saving",
    ),
    "expectedToAttend": m2,
    "export2excell": MessageLookupByLibrary.simpleMessage(
      "Export To Excel Sheet",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("Failed"),
    "failedRegisterSentence": m3,
    "failedToExport": MessageLookupByLibrary.simpleMessage(
      "Failed To Export Data To Excel Sheet",
    ),
    "fill1name": MessageLookupByLibrary.simpleMessage("Fill Student Firstname"),
    "fill2name": MessageLookupByLibrary.simpleMessage(
      "Fill Student Secondname",
    ),
    "fillemail": MessageLookupByLibrary.simpleMessage("Fill Student Email"),
    "fillpe": MessageLookupByLibrary.simpleMessage(
      "Fill Student Parrent Email",
    ),
    "fillphone": MessageLookupByLibrary.simpleMessage("Fill Student Phone"),
    "fillpp": MessageLookupByLibrary.simpleMessage(
      "Fill Student Parrent Phone",
    ),
    "firstsec": MessageLookupByLibrary.simpleMessage("First Secondry"),
    "gender": MessageLookupByLibrary.simpleMessage("Gender :"),
    "getStds": MessageLookupByLibrary.simpleMessage("Export all Students"),
    "gettingattendants": MessageLookupByLibrary.simpleMessage(
      "Getting Attendants",
    ),
    "gettingquizid": MessageLookupByLibrary.simpleMessage("Getting Quiz Id"),
    "gotattendants": MessageLookupByLibrary.simpleMessage("Got Attendants"),
    "gotid": MessageLookupByLibrary.simpleMessage("Got Quiz Id"),
    "gotmarks": MessageLookupByLibrary.simpleMessage("Got Quiz Marks"),
    "gotowhatsappcenter": MessageLookupByLibrary.simpleMessage(
      "Go To Whatsapp Center",
    ),
    "id": MessageLookupByLibrary.simpleMessage("ID :"),
    "mark": m4,
    "marksMode": MessageLookupByLibrary.simpleMessage("Marks Mode"),
    "markssent": MessageLookupByLibrary.simpleMessage("Marks Sent"),
    "nodata": MessageLookupByLibrary.simpleMessage("No Data"),
    "offline": MessageLookupByLibrary.simpleMessage("Offline"),
    "online": MessageLookupByLibrary.simpleMessage("Online"),
    "parrentemail": MessageLookupByLibrary.simpleMessage("Parrent Email :"),
    "parrentpassword": MessageLookupByLibrary.simpleMessage(
      "Parrent Password :",
    ),
    "parrentphone": m5,
    "parrentphonetitle": MessageLookupByLibrary.simpleMessage(
      "Parrent Phone :",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Password :"),
    "phone": MessageLookupByLibrary.simpleMessage("Phone :"),
    "pressStart": MessageLookupByLibrary.simpleMessage("Press Start"),
    "processStatus": MessageLookupByLibrary.simpleMessage("Process Status ..."),
    "quizfullmark": MessageLookupByLibrary.simpleMessage(
      "Enter Quiz Ful Mark!!!",
    ),
    "quizfullmark2": MessageLookupByLibrary.simpleMessage("Quiz Full Mark"),
    "secondsec": MessageLookupByLibrary.simpleMessage("Second Secondry"),
    "select": MessageLookupByLibrary.simpleMessage("Select"),
    "selectBranch": MessageLookupByLibrary.simpleMessage("Select Branch"),
    "selectStage": MessageLookupByLibrary.simpleMessage("Select Student Stage"),
    "sendattendants": MessageLookupByLibrary.simpleMessage(
      "Sending Attendants To Server",
    ),
    "sent": MessageLookupByLibrary.simpleMessage("Sent Attendants"),
    "start": MessageLookupByLibrary.simpleMessage("Start"),
    "stdMark": m6,
    "stdid": m7,
    "studentData": MessageLookupByLibrary.simpleMessage("Student Data"),
    "submitThisSession": MessageLookupByLibrary.simpleMessage(
      "Submit This Session",
    ),
    "submitted": MessageLookupByLibrary.simpleMessage("Submitted"),
    "success": MessageLookupByLibrary.simpleMessage("Success"),
    "successRegisterSentence": m8,
    "thirdprep": MessageLookupByLibrary.simpleMessage("Third Prep"),
    "thirdsec": MessageLookupByLibrary.simpleMessage("Third Secondry"),
    "time": MessageLookupByLibrary.simpleMessage("Time :"),
    "typeanythingofstddata": MessageLookupByLibrary.simpleMessage(
      "Type Anything of student data",
    ),
    "welcomeRegisterSentence": MessageLookupByLibrary.simpleMessage(
      "Welcome to Student Register Page",
    ),
    "whatsappBotReady": MessageLookupByLibrary.simpleMessage(
      "Whatsapp Bot Ready To Go",
    ),
    "whatsappcenter": MessageLookupByLibrary.simpleMessage("Whatsapp Center"),
    "youareworkingin": m9,
  };
}
