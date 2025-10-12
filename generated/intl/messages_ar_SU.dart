// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar_SU locale. All the
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
  String get localeName => 'ar_SU';

  static String m0(number) => "حضر بالفعل سنتر ( ${number} )";

  static String m1(number) => "حضر بالفعل (طالب أونلاين) ( ${number} )";

  static String m2(number) => "المتوقع حضوره ( ${number} )";

  static String m3(message) => "فشلت العملية ${message}";

  static String m4(mark) => "الدرجة: ${mark}";

  static String m5(parrentphone) => "هاتف ولي الامر: ${parrentphone}";

  static String m6(studentid) => "درجة ${studentid}";

  static String m7(id) => "رقم الطالب: ${id}";

  static String m8(stdid) => "تمت العملية بنجاح رقم الطالب: ${stdid}";

  static String m9(branch) => "انت تدير ${branch}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "add": MessageLookupByLibrary.simpleMessage("إضافة"),
    "add2attendants": MessageLookupByLibrary.simpleMessage(
      "إضافة إلى الحاضرين العاديين",
    ),
    "addStd": MessageLookupByLibrary.simpleMessage("إضافة طالب"),
    "addStudentsManually": MessageLookupByLibrary.simpleMessage(
      "اضافة الطلبة يدويا",
    ),
    "arrangingquizmarks": MessageLookupByLibrary.simpleMessage(
      "ترتيب علامات الاختبار",
    ),
    "attendants": m0,
    "attendantsonline": m1,
    "back": MessageLookupByLibrary.simpleMessage("رجوع"),
    "blocked": MessageLookupByLibrary.simpleMessage("الطالب محظور!"),
    "blockedFromAttend": MessageLookupByLibrary.simpleMessage("منع من الحضور"),
    "blockedSentence": MessageLookupByLibrary.simpleMessage(
      "تم حظر هذا الطالب من قبل المسؤول!",
    ),
    "center": MessageLookupByLibrary.simpleMessage("السنتر:"),
    "close": MessageLookupByLibrary.simpleMessage("إغلاق"),
    "code": MessageLookupByLibrary.simpleMessage("الكود: "),
    "createAcc": MessageLookupByLibrary.simpleMessage("إنشاء حساب للطالب"),
    "createCodes": MessageLookupByLibrary.simpleMessage(
      "إنشاء أكواد الأونلاين",
    ),
    "email": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني:"),
    "entercodesprice": MessageLookupByLibrary.simpleMessage("ادخل سعر الكود"),
    "enterhowmanycodes": MessageLookupByLibrary.simpleMessage(
      "أدخل عدد الأكواد",
    ),
    "errorInPreparingWhatsappBot": MessageLookupByLibrary.simpleMessage(
      "خطأ في تحضير الواتساب",
    ),
    "exitWithoutSaving": MessageLookupByLibrary.simpleMessage("خروج بدون حفظ"),
    "expectedToAttend": m2,
    "export2excell": MessageLookupByLibrary.simpleMessage(
      "إخراج إلى جدول Excel",
    ),
    "failed": MessageLookupByLibrary.simpleMessage("فشلت العملية"),
    "failedRegisterSentence": m3,
    "failedToExport": MessageLookupByLibrary.simpleMessage(
      "خطأ في عملية استخراج الحصة ل Excel",
    ),
    "fill1name": MessageLookupByLibrary.simpleMessage(
      "يرجى ملء الاسم الأول للطالب",
    ),
    "fill2name": MessageLookupByLibrary.simpleMessage(
      "يرجى ملء الاسم الثاني للطالب",
    ),
    "fillemail": MessageLookupByLibrary.simpleMessage(
      "يرجى ملء البريد الإلكتروني للطالب",
    ),
    "fillpe": MessageLookupByLibrary.simpleMessage(
      "يرجى ملء بريد ولي الأمر للطالب",
    ),
    "fillphone": MessageLookupByLibrary.simpleMessage("يرجى ملء الهاتف للطالب"),
    "fillpp": MessageLookupByLibrary.simpleMessage(
      "يرجى ملء هاتف ولي الأمر للطالب",
    ),
    "firstsec": MessageLookupByLibrary.simpleMessage("الصف الأول الثانوي"),
    "gender": MessageLookupByLibrary.simpleMessage("الجنس:"),
    "getStds": MessageLookupByLibrary.simpleMessage("إخراج كل الطلاب"),
    "gettingattendants": MessageLookupByLibrary.simpleMessage(
      "تحضير بيانات الحضور",
    ),
    "gettingquizid": MessageLookupByLibrary.simpleMessage("جلب رقم الاختبار"),
    "gotattendants": MessageLookupByLibrary.simpleMessage(
      "تم تحضير بيانات الحضور",
    ),
    "gotid": MessageLookupByLibrary.simpleMessage("تم جلب رقم الاختبار"),
    "gotmarks": MessageLookupByLibrary.simpleMessage(
      "تم ترتيب علامات الاختبار",
    ),
    "gotowhatsappcenter": MessageLookupByLibrary.simpleMessage(
      "الانتقال إلى الواتساب",
    ),
    "id": MessageLookupByLibrary.simpleMessage("الرقم التعريفي:"),
    "mark": m4,
    "marksMode": MessageLookupByLibrary.simpleMessage("صفحة الدرجات"),
    "markssent": MessageLookupByLibrary.simpleMessage("تم إرسال الدرجات"),
    "nodata": MessageLookupByLibrary.simpleMessage("لا توجد بيانات"),
    "offline": MessageLookupByLibrary.simpleMessage("سنتر"),
    "online": MessageLookupByLibrary.simpleMessage("أونلاين"),
    "parrentemail": MessageLookupByLibrary.simpleMessage("بريد ولي الامر:"),
    "parrentpassword": MessageLookupByLibrary.simpleMessage(
      "كلمة مرور ولي الامر:",
    ),
    "parrentphone": m5,
    "parrentphonetitle": MessageLookupByLibrary.simpleMessage(
      "هاتف ولي الامر:",
    ),
    "password": MessageLookupByLibrary.simpleMessage("كلمة المرور:"),
    "phone": MessageLookupByLibrary.simpleMessage("الهاتف:"),
    "pressStart": MessageLookupByLibrary.simpleMessage("اضغط بدء"),
    "processStatus": MessageLookupByLibrary.simpleMessage("حالة العملية ..."),
    "quizfullmark": MessageLookupByLibrary.simpleMessage(
      "أدخل العلامة الكاملة للاختبار!!!",
    ),
    "quizfullmark2": MessageLookupByLibrary.simpleMessage(
      "درجة الاختبار النهائية",
    ),
    "secondsec": MessageLookupByLibrary.simpleMessage("الصف الثاني الثانوي"),
    "select": MessageLookupByLibrary.simpleMessage("اختر"),
    "selectBranch": MessageLookupByLibrary.simpleMessage("اختر الفرع"),
    "selectStage": MessageLookupByLibrary.simpleMessage("اختر مرحلة الطالب"),
    "sendattendants": MessageLookupByLibrary.simpleMessage(
      "إرسال الحضور إلى السيرفر",
    ),
    "sent": MessageLookupByLibrary.simpleMessage("تم الإرسال"),
    "start": MessageLookupByLibrary.simpleMessage("بدء"),
    "stdMark": m6,
    "stdid": m7,
    "studentData": MessageLookupByLibrary.simpleMessage("بيانات الطالب"),
    "submitThisSession": MessageLookupByLibrary.simpleMessage("حفظ هذه الحصة"),
    "submitted": MessageLookupByLibrary.simpleMessage("تم الحفظ"),
    "success": MessageLookupByLibrary.simpleMessage("نجحت العملية"),
    "successRegisterSentence": m8,
    "thirdprep": MessageLookupByLibrary.simpleMessage("الصف الثالث الإعدادي"),
    "thirdsec": MessageLookupByLibrary.simpleMessage("الصف الثالث الثانوي"),
    "time": MessageLookupByLibrary.simpleMessage("الوقت:"),
    "typeanythingofstddata": MessageLookupByLibrary.simpleMessage(
      "ادخل ايا من بيانات الطالب",
    ),
    "welcomeRegisterSentence": MessageLookupByLibrary.simpleMessage(
      "مرحبًا بك في صفحة تسجيل الطالب",
    ),
    "whatsappBotReady": MessageLookupByLibrary.simpleMessage(
      "الواتساب جاهز للبدء",
    ),
    "whatsappcenter": MessageLookupByLibrary.simpleMessage("الواتساب سنتر"),
    "youareworkingin": m9,
  };
}
