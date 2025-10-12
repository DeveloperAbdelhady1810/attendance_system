import 'dart:io';
import 'package:attendants/classes/session.dart';
import 'package:attendants/classes/user.dart';
import 'package:attendants/classes/variables.dart';
import 'package:attendants/classes/worksession.dart';
import 'package:attendants/screens/attendants_screen.dart';
import 'package:attendants/screens/home.dart';
import 'package:attendants/screens/new_attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:window_manager/window_manager.dart';
import 'generated/l10n.dart';
import 'package:google_fonts/google_fonts.dart';
late Widget initial;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext.setTrustedCertificatesBytes(data.buffer.asUint8List());
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(WorkSessionAdapter());
  Hive.registerAdapter(SessionAdapter());
  await Hive.openBox("Attended");
  await Hive.openBox("Blocked");
  await Hive.openBox("Expected");
  await Hive.openBox("ManuallyAdded");
  await Hive.openBox("BlockedFromAttend");
  await Hive.openBox("worksession");
  await Hive.openBox("homework");
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_)async{
    await windowManager.maximize();
  });
  // await Variables().worksession.clear();
  if (Variables().worksession.isNotEmpty) {
    // print(Variables().worksession.values.elementAt(0).chpname);
    // initial = Attendants(session: Variables().worksession.values.elementAt(0),isworksession: true,);
    initial = NewAttendanceScreen(session: Variables().worksession.values.elementAt(0),isworksession: true,chpname: Variables().worksession.values.elementAt(0).chpname,);
  } else {
    initial = const Home(connected: false,connection: "",currentStage: "",);
  }
  // var settings = ConnectionSettings(
  //   host: 'sql8.freesqldatabase.com', 
  //   port: 3306,
  //   user: 'sql8725971',
  //   password: 'ZPRktZcvXj',
  //   db: 'sql8725971'
  // );
  // SqlCenter().conn = await MySqlConnection.connect(settings);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('en'),
      title: 'Sessions Attendants System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.lemonadaTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: initial,
      // home: const Home(connected: false,connection: "",currentStage: "",),
    );
  }
}